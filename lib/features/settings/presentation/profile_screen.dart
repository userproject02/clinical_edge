import 'dart:async';

import 'package:clinical_edge/app/feature_flags.dart';
import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/notifications.dart';
import 'package:clinical_edge/app/state/theme_mode.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/motion.dart' show FadeUpIn;
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/auth/presentation/role_labels.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/certifications/presentation/cert_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// `/profile`: user card, demo role, language, theme, notifications, the
/// "under the hood" card, sign out and version (AUTH-2, AUTH-3, SET-1).
class ProfileScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final session = ref.watch(sessionProvider).value;
    if (session == null) return const SizedBox.shrink();
    final role = session.role;
    return AppScaffold.detail(
      title: l.titleProfile,
      onBack: () => context.canPop()
          ? context.pop()
          : context.go(AppRoutes.homeFor(role)),
      body: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 24),
        children: <Widget>[
          for (final (i, w) in <Widget>[
            _UserCard(session: session),
            _SettingsCard(session: session),
            const _HoodCard(),
            _SignOutButton(label: l.signOut),
            Text(
              l.appVersion,
              textAlign: TextAlign.center,
              style: context.micro.copyWith(
                color: context.colors.muted,
                fontWeight: FontWeight.w400,
              ),
            ),
          ].indexed) ...<Widget>[
            if (i > 0) const SizedBox(height: 12),
            FadeUpIn(index: i, child: w),
          ],
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const new({required this.child, this.padding = 16});

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(AppRadii.cardLarge),
    ),
    child: child,
  );
}

class _UserCard extends ConsumerWidget {
  const new({required this.session});

  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final u = session.user;
    final tenant = ref.watch(tenantProvider).value;
    final caption = context.caption.copyWith(color: c.muted);
    return _Card(
      padding: 18,
      child: Row(
        children: <Widget>[
          ExcludeSemantics(
            child: Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c.brandSoft,
                shape: BoxShape.circle,
              ),
              child: Text(
                u.initials,
                style: context.sectionTitle.copyWith(
                  color: c.brand,
                  fontSize: 18,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  u.name.of(context),
                  style: context.sectionTitle.copyWith(fontSize: 17),
                ),
                Text(u.title.of(context), style: caption),
                if (tenant != null) Text(tenant.of(context), style: caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends ConsumerWidget {
  const new({required this.session});

  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final label = context.caption.copyWith(
      color: c.muted,
      fontWeight: FontWeight.w600,
    );
    final brightness = Theme.of(context).brightness;
    final locale = ref.watch(localeProvider);
    final notifications = ref.watch(notificationsEnabledProvider);

    Widget section(String title, Widget child) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(title, style: label),
        const SizedBox(height: 8),
        child,
      ],
    );

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (kDemoRoleSwitcher) ...<Widget>[
            section(
              l.signInDemoRole,
              SegmentedPicker<Role>(
                key: const Key('profile.role'),
                semanticLabel: l.signInDemoRole,
                selected: session.role,
                onChanged: (r) => unawaited(_switchRole(context, ref, r)),
                segments: <Segment<Role>>[
                  for (final r in Role.values)
                    Segment(value: r, label: roleLabel(l, r)),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          section(
            l.settingsLanguage,
            SegmentedPicker<String>(
              key: const Key('profile.language'),
              semanticLabel: l.settingsLanguage,
              selected: locale.languageCode,
              onChanged: (code) => unawaited(
                ref.read(localeProvider.notifier).set(Locale(code)),
              ),
              segments: <Segment<String>>[
                Segment(value: 'en', label: l.languageEnglish),
                Segment(value: 'ar', label: l.languageArabic),
              ],
            ),
          ),
          const SizedBox(height: 16),
          section(
            l.settingsTheme,
            SegmentedPicker<Brightness>(
              key: const Key('profile.theme'),
              semanticLabel: l.settingsTheme,
              selected: brightness,
              onChanged: (b) => unawaited(
                ref
                    .read(themeModeProvider.notifier)
                    .set(
                      b == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
                    ),
              ),
              segments: <Segment<Brightness>>[
                Segment(value: Brightness.light, label: l.themeLight),
                Segment(value: Brightness.dark, label: l.themeDark),
              ],
            ),
          ),
          const SizedBox(height: 8),
          MergeSemantics(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        l.settingsPush,
                        style: context.body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        l.settingsPushBody,
                        style: context.caption.copyWith(color: c.muted),
                      ),
                    ],
                  ),
                ),
                Switch(
                  key: const Key('profile.notifications'),
                  value: notifications,
                  activeThumbColor: c.onBrand,
                  activeTrackColor: c.brand,
                  inactiveThumbColor: c.muted,
                  inactiveTrackColor: c.surface2,
                  trackOutlineColor: WidgetStateProperty.resolveWith(
                    (s) => s.contains(WidgetState.selected) ? c.brand : c.muted,
                  ),
                  // Shared with the Certs reminders card; asks for OS
                  // permission when turned on.
                  onChanged: (v) =>
                      unawaited(ref.read(setRemindersEnabledProvider)(v)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _switchRole(
    BuildContext context,
    WidgetRef ref,
    Role role,
  ) async {
    final l = AppLocalizations.of(context);
    // Capture everything before switching: the router is rebuilt for the
    // new role, which disposes this widget (and its ref).
    final rootContext = ref.read(rootNavigatorContextProvider);
    final session = ref.read(sessionProvider.notifier);
    ref.read(resumeLocationProvider.notifier).set(AppRoutes.profile);
    final next = await session.switchRole(role);
    // Wait for the rebuilt router's navigator to mount.
    await WidgetsBinding.instance.endOfFrame;
    final navContext = rootContext();
    if (navContext == null || !navContext.mounted) return;
    AppSnackBar.show(
      navContext,
      title: l.roleSwitchedTitle,
      message: l.roleSwitchedBody(next.user.name.of(navContext)),
      tone: StatusTone.blue,
      bottomInset: 24,
    );
  }
}

class _HoodCard extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l.settingsHoodTitle, style: context.cardTitle),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              // Product names stay in Latin script in both languages.
              const StatusTag(label: 'Material 3', tone: StatusTone.brand),
              const StatusTag(label: 'Riverpod', tone: StatusTone.brand),
              const StatusTag(label: 'go_router', tone: StatusTone.brand),
              StatusTag(label: l.settingsHoodFeatureFirst),
              StatusTag(label: l.settingsHoodMockRepos),
              const StatusTag(label: 'ActivityLogger'),
              const StatusTag(label: 'PaymentGateway'),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l.settingsHoodBody,
            style: context.caption.copyWith(color: context.colors.muted),
          ),
        ],
      ),
    );
  }
}

class _SignOutButton extends ConsumerWidget {
  const new({required this.label});

  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        key: const Key('profile.signOut'),
        style: OutlinedButton.styleFrom(
          foregroundColor: c.bad,
          side: BorderSide(color: c.outline),
          shape: const StadiumBorder(),
          textStyle: context.cardTitle.copyWith(letterSpacing: 0),
        ),
        onPressed: () =>
            unawaited(ref.read(sessionProvider.notifier).signOut()),
        child: Text(label),
      ),
    );
  }
}
