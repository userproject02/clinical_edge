import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/admin/presentation/admin_providers.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/certifications/presentation/cert_providers.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_providers.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:clinical_edge/features/notifications/domain/inbox_item.dart';
import 'package:material_ui/material_ui.dart' show Locale;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'inbox_providers.g.dart';

/// Notifications for the signed-in role, most urgent first:
/// - learner: expired / expiring / verifying certificates, then sign-off
///   decisions (newest first);
/// - supervisor: pending sign-off requests (newest first);
/// - admin: cohort certificates in the renewal window (soonest first), then
///   sign-offs waiting for supervisors.
@riverpod
Future<List<InboxItem>> inbox(Ref ref) async {
  final session = await ref.watch(sessionProvider.future);
  if (session == null) return const <InboxItem>[];
  final locale = ref.watch(localeProvider);
  final l = lookupAppLocalizations(locale);
  return await (switch (session.role) {
    Role.learner => _learner(ref, l, locale),
    Role.supervisor => _supervisor(ref, l, locale),
    Role.admin => _admin(ref, l, locale),
  });
}

Future<List<InboxItem>> _learner(
  Ref ref,
  AppLocalizations l,
  Locale locale,
) async {
  final clock = ref.watch(clockProvider);
  final certs = await ref.watch(myCertificationsProvider.future);
  final requests = await ref.watch(mySignOffsProvider.future);
  final checklists = await ref.watch(checklistsByIdProvider.future);
  final users = await ref.watch(usersByIdProvider.future);

  final expired = <InboxItem>[];
  final expiring = <InboxItem>[];
  final verifying = <InboxItem>[];
  for (final cert in [
    ...certs,
  ]..sort((a, b) => a.expiresOn.compareTo(b.expiresOn))) {
    final label = cert.code ?? cert.name.forLocale(locale);
    switch (cert.status(clock)) {
      case CertStatus.expired:
        expired.add(
          InboxItem(
            id: 'cert.${cert.id}.expired',
            kind: InboxKind.certExpired,
            title: l.inboxCertExpired(label),
            body: l.inboxCertExpiredBody(Formats.date(cert.expiresOn, locale)),
            route: AppRoutes.certs,
          ),
        );
      case CertStatus.renewSoon:
        final text = reminderText(l, locale, cert, cert.daysLeft(clock));
        expiring.add(
          InboxItem(
            id: 'cert.${cert.id}.renew',
            kind: InboxKind.certExpiring,
            title: text.title,
            body: text.body,
            route: AppRoutes.certs,
          ),
        );
      case CertStatus.verifying:
        verifying.add(
          InboxItem(
            id: 'cert.${cert.id}.verifying',
            kind: InboxKind.certVerifying,
            title: l.inboxCertVerifying(cert.name.forLocale(locale)),
            body: l.inboxCertVerifyingBody,
            route: AppRoutes.certs,
          ),
        );
      case CertStatus.valid:
        break;
    }
  }

  final decided =
      requests
          .where(
            (r) =>
                r.decidedAt != null &&
                (r.status == SignOffStatus.approved ||
                    r.status == SignOffStatus.rejected),
          )
          .toList()
        ..sort((a, b) => b.decidedAt!.compareTo(a.decidedAt!));
  final decisions = <InboxItem>[
    for (final r in decided)
      () {
        final checklist =
            checklists[r.checklistId]?.name.forLocale(locale) ?? '';
        final approved = r.status == SignOffStatus.approved;
        return InboxItem(
          id: 'signoff.${r.id}.${r.status.name}',
          kind: approved
              ? InboxKind.signOffApproved
              : InboxKind.signOffRejected,
          title: approved
              ? l.inboxSignOffApproved(checklist)
              : l.inboxSignOffRejected(checklist),
          body: l.inboxSignOffDecidedBody(
            users[r.decidedBy]?.name.forLocale(locale) ?? '',
            Formats.date(r.decidedAt!, locale),
          ),
          route: AppRoutes.signoffs,
        );
      }(),
  ];
  return <InboxItem>[...expired, ...expiring, ...verifying, ...decisions];
}

Future<List<InboxItem>> _supervisor(
  Ref ref,
  AppLocalizations l,
  Locale locale,
) async {
  final queue = await ref.watch(signOffQueueProvider.future);
  final checklists = await ref.watch(checklistsByIdProvider.future);
  final users = await ref.watch(usersByIdProvider.future);
  return <InboxItem>[
    for (final r in queue.reversed)
      InboxItem(
        id: 'queue.${r.id}',
        kind: InboxKind.signOffRequest,
        title: l.inboxSignOffRequest(
          users[r.learnerId]?.name.forLocale(locale) ?? '',
        ),
        body: l.inboxSignOffRequestBody(
          checklists[r.checklistId]?.name.forLocale(locale) ?? '',
          r.requestedAt == null ? '' : Formats.date(r.requestedAt!, locale),
        ),
        route: AppRoutes.review(r.id),
      ),
  ];
}

Future<List<InboxItem>> _admin(
  Ref ref,
  AppLocalizations l,
  Locale locale,
) async {
  final rows = await ref.watch(cohortLearnersProvider.future);
  final pending = await ref.watch(signOffQueueProvider.future);
  final expiring =
      rows
          .where(
            (r) =>
                r.expiryCode != null &&
                r.expiryDays != null &&
                r.expiryDays! <= CertRules.renewSoonDays,
          )
          .toList()
        ..sort((a, b) => a.expiryDays!.compareTo(b.expiryDays!));
  return <InboxItem>[
    for (final r in expiring)
      InboxItem(
        id: 'cohort.${r.user.id}.${r.expiryCode}',
        kind: InboxKind.cohortExpiry,
        title: l.inboxCohortExpiry(
          r.user.name.forLocale(locale),
          r.expiryCode!,
          r.expiryDays!,
        ),
        body: l.inboxCohortExpiryBody,
        route: AppRoutes.cohort,
      ),
    if (pending.isNotEmpty)
      InboxItem(
        id: 'pending.${pending.map((r) => r.id).join(',')}',
        kind: InboxKind.cohortPending,
        title: l.inboxCohortPending(pending.length),
        body: l.inboxCohortPendingBody,
        route: AppRoutes.cohort,
      ),
  ];
}

/// Ids of notifications already shown in the sheet (this app session).
@Riverpod(keepAlive: true)
class InboxSeen extends _$InboxSeen {
  @override
  Set<String> build() => <String>{};

  /// Marks [ids] as seen.
  void markAll(Iterable<String> ids) => state = <String>{...state, ...ids};
}

/// Whether the bell shows its unread dot.
@riverpod
bool inboxUnread(Ref ref) {
  final items = ref.watch(inboxProvider).value ?? const <InboxItem>[];
  final seen = ref.watch(inboxSeenProvider);
  return items.any((i) => !seen.contains(i.id));
}
