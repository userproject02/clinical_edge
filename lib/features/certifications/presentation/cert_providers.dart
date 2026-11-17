import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/notifications.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/notifications/local_notifier.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/certifications/data/certification_repository.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/certifications/domain/reminder_service.dart';
import 'package:clinical_edge/features/certifications/domain/upload_certificate.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:material_ui/material_ui.dart' show Locale;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cert_providers.g.dart';

/// Expiry reminder rules on the app clock.
@riverpod
ReminderService reminderService(Ref ref) =>
    ReminderService(clock: ref.watch(clockProvider));

/// The certificate to warn about now (Home expiry alert, bell), or null.
@riverpod
Future<Certification?> dueCertificate(Ref ref) async => ref
    .watch(reminderServiceProvider)
    .due(await ref.watch(myCertificationsProvider.future));

/// Title and body of an expiry reminder for [cert] with [days] left.
({String title, String body}) reminderText(
  AppLocalizations l,
  Locale locale,
  Certification cert,
  int days,
) => (
  title: l.reminderTitle(cert.code ?? cert.name.forLocale(locale), days),
  body: l.reminderBody(Formats.date(cert.expiresOn, locale)),
);

/// Keeps the device's scheduled reminders in step with the switch, the
/// certificate list and the language. Watched by the tab scaffold.
@riverpod
Future<int> reminderSync(Ref ref) async {
  final enabled = ref.watch(notificationsEnabledProvider);
  final locale = ref.watch(localeProvider);
  final certs = await ref.watch(myCertificationsProvider.future);
  final notifier = ref.read(localNotificationsProvider);
  if (!enabled) {
    await notifier.replaceSchedule(const <ScheduledNotification>[]);
    return 0;
  }
  final l = lookupAppLocalizations(locale);
  final slots = ref.read(reminderServiceProvider).upcoming(certs);
  await notifier.replaceSchedule(<ScheduledNotification>[
    for (final s in slots)
      () {
        final text = reminderText(l, locale, s.cert, s.daysBefore);
        return ScheduledNotification(
          id: s.id,
          at: s.at,
          title: text.title,
          body: text.body,
        );
      }(),
  ]);
  return slots.length;
}

/// Turns expiry reminders on or off (shared by the Certs card and Profile).
/// Turning on asks the OS for permission.
@Riverpod(keepAlive: true)
Future<void> Function(bool enabled) setRemindersEnabled(
  Ref ref,
) => (enabled) async {
  await ref.read(notificationsEnabledProvider.notifier).set(enabled: enabled);
  if (enabled) await ref.read(localNotificationsProvider).requestPermission();
};

/// "Simulate expiry reminder" / bell: logs `notify.reminder`, fires a local
/// notification when reminders are on, and returns the text for the
/// in-app banner (null when there is no certificate to remind about).
@Riverpod(keepAlive: true)
Future<({String title, String body})?> Function() simulateReminder(Ref ref) =>
    () async {
      final certs = await ref.read(myCertificationsProvider.future);
      final service = ref.read(reminderServiceProvider);
      final cert = service.simulated(certs);
      if (cert == null) return null;
      final days = cert.daysLeft(ref.read(clockProvider));
      final locale = ref.read(localeProvider);
      final text = reminderText(
        lookupAppLocalizations(locale),
        locale,
        cert,
        days,
      );
      ref
          .read(activityLoggerProvider)
          .usage(
            UsageAction.notifyReminder,
            target: '${cert.code ?? cert.name.en} · $days days',
          );
      if (ref.read(notificationsEnabledProvider)) {
        await ref
            .read(localNotificationsProvider)
            .showNow(title: text.title, body: text.body);
      }
      return text;
    };

/// Uploads a certificate (CERT-3) and refreshes the list.
@Riverpod(keepAlive: true)
Future<Certification> Function({
  required String name,
  required DateTime issuedOn,
  required DateTime? expiresOn,
})
uploadCertificate(Ref ref) =>
    ({required name, required issuedOn, required expiresOn}) async {
      final en = lookupAppLocalizations(const Locale('en'));
      final ar = lookupAppLocalizations(const Locale('ar'));
      final cert =
          await UploadCertificate(
            repository: ref.read(certificationRepositoryProvider),
            logger: ref.read(activityLoggerProvider),
          )(
            userId: ref.read(sessionProvider).value?.user.id ?? '',
            name: name,
            issuer: LocalizedText(
              en: en.certIssuerUploaded,
              ar: ar.certIssuerUploaded,
            ),
            issuedOn: issuedOn,
            expiresOn: expiresOn,
          );
      ref.invalidate(myCertificationsProvider);
      return cert;
    };
