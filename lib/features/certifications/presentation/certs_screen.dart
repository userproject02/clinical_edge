import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/state/notifications.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/certifications/presentation/cert_providers.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Shows the simulated expiry reminder banner (CERT-4); used by the
/// "Simulate expiry reminder" button and the app-bar bell.
Future<void> showExpiryReminder(BuildContext context, WidgetRef ref) async {
  final text = await ref.read(simulateReminderProvider)();
  if (text == null || !context.mounted) return;
  NotificationBanner.show(context, title: text.title, message: text.body);
}

/// Days of validity the expiry meter spans (a typical 2-year certificate).
const int certMeterSpanDays = 730;

/// Tone of a certificate status.
StatusTone certTone(CertStatus s) => switch (s) {
  CertStatus.valid => StatusTone.ok,
  CertStatus.renewSoon => StatusTone.warn,
  CertStatus.verifying => StatusTone.blue,
  CertStatus.expired => StatusTone.bad,
};

/// Label of a certificate status.
String certStatusLabel(AppLocalizations l, CertStatus s) => switch (s) {
  CertStatus.valid => l.certStatusValid,
  CertStatus.renewSoon => l.certStatusRenewSoon,
  CertStatus.verifying => l.certStatusVerifying,
  CertStatus.expired => l.certStatusExpired,
};

/// `/certs`: CPD ring, reminders, certifications and CPD ledger
/// (CERT-1, CERT-2, CERT-4).
class CertsScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final certs = ref.watch(myCertificationsProvider).value;
    final config = ref.watch(cpdConfigProvider).value;
    final ledger = ref.watch(cpdLedgerProvider).value;
    final ready = certs != null && config != null && ledger != null;
    return TabScaffold(
      title: l.titleCerts,
      body: Stack(
        children: <Widget>[
          if (!ready)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SkeletonBox(height: 220),
            )
          else
            ListView(
              key: const Key('certs.list'),
              padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 96),
              children: <Widget>[
                for (final (i, w) in <Widget>[
                  _CpdCard(
                    config: config,
                    total: ledger.fold(0, (s, e) => s + e.credits),
                  ),
                  const _RemindersCard(),
                  const _SimulateButton(),
                  _Section(
                    title: l.certsListTitle,
                    children: <Widget>[
                      for (final c in certs) _CertRow(cert: c),
                    ],
                  ),
                  _Section(
                    title: l.certsLedgerTitle,
                    children: <Widget>[
                      for (final e in ledger) _LedgerRow(entry: e),
                    ],
                  ),
                ].indexed) ...<Widget>[
                  if (i > 0) const SizedBox(height: 14),
                  FadeUpIn(index: i, child: w),
                ],
              ],
            ),
          PositionedDirectional(
            end: 16,
            bottom: 16,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: context.colors.brand.withValues(alpha: 0.28),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: FloatingActionButton.extended(
                key: const Key('certs.upload'),
                heroTag: 'certs.upload',
                backgroundColor: context.colors.brand,
                foregroundColor: context.colors.onBrand,
                shape: const StadiumBorder(),
                elevation: 0,
                focusElevation: 0,
                hoverElevation: 0,
                highlightElevation: 0,
                onPressed: () => context.go(AppRoutes.certUpload),
                icon: const Icon(Icons.upload_file_rounded),
                label: Text(l.certsUpload),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const new({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(AppRadii.cardLarge),
    ),
    child: child,
  );
}

class _CpdCard extends StatelessWidget {
  const new({required this.config, required this.total});

  final CpdConfig config;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final left = (config.target - total).clamp(0, config.target);
    return _Card(
      key: const Key('certs.cpd'),
      child: Row(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ProgressRing(
                key: const Key('certs.cpdRing'),
                value: total / config.target,
                size: 112,
                strokeWidth: 11,
                label: '',
                semanticLabel: l.certsCpdSemantics(total, config.target),
              ),
              ExcludeSemantics(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    LtrText(
                      Formats.integer(total),
                      key: const Key('certs.cpdTotal'),
                      style: context.screenTitle.copyWith(
                        fontSize: 30,
                        height: 1,
                        letterSpacing: 0,
                      ),
                    ),
                    Text(
                      l.certsCpdOf(Formats.integer(config.target)),
                      style: context.caption.copyWith(color: c.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(l.homeCredits(config.cycle), style: context.cardTitle),
                const SizedBox(height: 4),
                Text(
                  left > 0 ? l.certsCpdToTarget(left) : l.certsCpdReached,
                  style: context.body.copyWith(
                    color: c.brand,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  config.targetNote.of(context),
                  style: context.caption.copyWith(color: c.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RemindersCard extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final on = ref.watch(notificationsEnabledProvider);
    return _Card(
      key: const Key('certs.reminders'),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: c.brandSoft,
              borderRadius: BorderRadius.circular(AppRadii.field),
            ),
            child: Icon(Icons.notifications_active_outlined, color: c.brand),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(l.certsRemindersTitle, style: context.cardTitle),
                Text(
                  l.certsRemindersDays(ltr(CertRules.reminderDays.join(' · '))),
                  style: context.caption.copyWith(color: c.muted),
                ),
              ],
            ),
          ),
          Switch(
            key: const Key('certs.remindersSwitch'),
            value: on,
            activeThumbColor: c.onBrand,
            activeTrackColor: c.brand,
            inactiveThumbColor: c.muted,
            inactiveTrackColor: c.surface2,
            trackOutlineColor: WidgetStateProperty.resolveWith(
              (s) => s.contains(WidgetState.selected) ? c.brand : c.muted,
            ),
            onChanged: (v) =>
                unawaited(ref.read(setRemindersEnabledProvider)(v)),
          ),
        ],
      ),
    );
  }
}

class _SimulateButton extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    return DashedBorder(
      color: c.brand.withValues(alpha: 0.6),
      radius: AppRadii.pill,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          key: const Key('certs.simulate'),
          customBorder: const StadiumBorder(),
          onTap: () => unawaited(showExpiryReminder(context, ref)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 52),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.notifications_outlined, color: c.brand, size: 20),
                const SizedBox(width: 8),
                Text(
                  l.certsSimulate,
                  style: context.body.copyWith(
                    color: c.brand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const new({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 4, bottom: 8),
        child: Text(title, style: context.sectionTitle),
      ),
      _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (final (i, w) in children.indexed) ...<Widget>[
              if (i > 0) Divider(height: 24, color: context.colors.outline),
              w,
            ],
          ],
        ),
      ),
    ],
  );
}

class _CertRow extends ConsumerWidget {
  const new({required this.cert});

  final Certification cert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final clock = ref.watch(clockProvider);
    final status = cert.status(clock);
    final days = cert.daysLeft(clock);
    final tone = certTone(status);
    final locale = Localizations.localeOf(context);
    return Column(
      key: Key('cert.${cert.id}'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: tone.background(c),
                borderRadius: BorderRadius.circular(AppRadii.field),
              ),
              child: Icon(
                Icons.workspace_premium_outlined,
                color: tone.foreground(c),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cert.name.of(context),
                    style: context.body.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    cert.issuer.of(context),
                    style: context.caption.copyWith(color: c.muted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            StatusTag(
              key: Key('cert.${cert.id}.status'),
              label: certStatusLabel(l, status),
              tone: tone,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                l.certExpires(Formats.date(cert.expiresOn, locale)),
                style: context.caption.copyWith(color: c.muted),
              ),
            ),
            Text(
              days > 0
                  ? l.certDaysLeft(Formats.integer(days))
                  : l.certStatusExpired,
              style: context.caption.copyWith(
                color: tone.foreground(c),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearMeter(
          value: (days / certMeterSpanDays).clamp(0.0, 1.0),
          height: 6,
          color: tone.foreground(c),
          semanticLabel: l.certDaysLeftSemantics(days < 0 ? 0 : days),
        ),
      ],
    );
  }
}

class _LedgerRow extends StatelessWidget {
  const new({required this.entry});

  final CpdEntry entry;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final locale = Localizations.localeOf(context);
    final source = switch (entry.source) {
      CpdSource.external => l.cpdSourceExternal,
      CpdSource.clinicaledge => l.cpdSourceClinicaledge,
    };
    return Row(
      key: Key('ledger.${entry.id}'),
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                entry.activity.of(context),
                style: context.body.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                '${Formats.date(entry.date, locale)} · $source',
                style: context.caption.copyWith(color: c.muted),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        LtrText(
          '+${entry.credits}',
          style: context.cardTitle.copyWith(color: c.brand, letterSpacing: 0),
        ),
      ],
    );
  }
}
