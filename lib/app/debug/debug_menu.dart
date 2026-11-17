import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/session.dart';
import 'package:clinical_edge/app/state/theme_mode.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// TEMPORARY developer menu (debug builds only; removed in Phase 3 when
/// Profile & settings and the real sign-in land).
///
/// A small floating button opens a sheet to switch theme, language and the
/// stub session, and to jump to any route of the active role.
class DebugMenuOverlay extends StatelessWidget {
  /// Wraps the app [child].
  const new({
    required this.enabled,
    required this.router,
    required this.child,
    super.key,
  });

  /// Shows the button (pass `kDebugMode`).
  final bool enabled;

  /// The app router (the overlay sits above its navigator).
  final GoRouter router;

  /// The routed app.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    final c = context.colors;
    return Stack(
      children: <Widget>[
        child,
        PositionedDirectional(
          start: 8,
          bottom: 104,
          child: SafeArea(
            child: Semantics(
              label: AppLocalizations.of(context).debugMenu,
              button: true,
              excludeSemantics: true,
              child: Material(
                color: c.inverse.withValues(alpha: 0.85),
                shape: const CircleBorder(),
                // No tooltip: this sits above the navigator's Overlay.
                child: IconButton(
                  iconSize: 20,
                  color: c.onInverse,
                  icon: const Icon(Icons.bug_report_outlined, size: 20),
                  onPressed: () {
                    final navContext =
                        router.routerDelegate.navigatorKey.currentContext;
                    if (navContext == null) return;
                    unawaited(
                      showAppBottomSheet<void>(
                        context: navContext,
                        builder: (_) => DebugMenuSheet(router: router),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Contents of the debug sheet.
class DebugMenuSheet extends ConsumerWidget {
  /// Creates the sheet.
  const new({required this.router, super.key});

  /// Router used for the route jumps.
  final GoRouter router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final mode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final session = ref.watch(sessionProvider);
    final sessionValue = session.signedIn ? session.role : null;

    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(text, style: context.micro.copyWith(color: c.muted)),
    );

    return AppBottomSheet(
      title: l.debugMenu,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            label(l.settingsTheme),
            SegmentedPicker<ThemeMode>(
              semanticLabel: l.settingsTheme,
              selected: mode,
              onChanged: (m) =>
                  unawaited(ref.read(themeModeProvider.notifier).set(m)),
              segments: <Segment<ThemeMode>>[
                Segment(value: ThemeMode.system, label: l.themeSystem),
                Segment(value: ThemeMode.light, label: l.themeLight),
                Segment(value: ThemeMode.dark, label: l.themeDark),
              ],
            ),
            label(l.settingsLanguage),
            SegmentedPicker<String>(
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
            label(l.debugSession),
            SegmentedPicker<Role?>(
              semanticLabel: l.debugSession,
              selected: sessionValue,
              onChanged: (role) {
                // The router is rebuilt for a new role, which closes this
                // sheet's navigator; close it first.
                Navigator.of(context).pop();
                final notifier = ref.read(sessionProvider.notifier);
                if (role == null) {
                  notifier.signOut();
                } else {
                  notifier.signIn(role);
                }
              },
              segments: <Segment<Role?>>[
                Segment(value: null, label: l.debugSignedOut),
                Segment(value: Role.learner, label: l.roleLearner),
                Segment(value: Role.supervisor, label: l.roleSupervisor),
                Segment(value: Role.admin, label: l.roleAdmin),
              ],
            ),
            if (session.signedIn) ...<Widget>[
              label(l.debugRoutes),
              for (final (title, path) in _routesFor(session.role, l))
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  minTileHeight: 48,
                  title: Text(title, style: context.body),
                  trailing: LtrText(
                    path,
                    style: context.mono.copyWith(color: c.muted),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    if (path == AppRoutes.profile) {
                      unawaited(router.push(path));
                    } else {
                      router.go(path);
                    }
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }

  List<(String, String)> _routesFor(Role role, AppLocalizations l) {
    const course = 'c1';
    return switch (role) {
      Role.learner => <(String, String)>[
        (l.titleHome, AppRoutes.home),
        (l.titleCourses, AppRoutes.learn),
        (l.titleCourseDetail, AppRoutes.course(course)),
        (l.titleLesson, AppRoutes.lesson(course, 1)),
        (l.titleCheckout, AppRoutes.checkout('c3')),
        (l.titleReceipt, AppRoutes.receipt('c3', 'o1')),
        (l.titleAssessments, AppRoutes.assess),
        (l.titleQuiz, AppRoutes.quiz('bls')),
        (l.titleCerts, AppRoutes.certs),
        (l.titleUploadCert, AppRoutes.certUpload),
        (l.titleCompetencies, AppRoutes.signoffs),
        (l.titleProfile, AppRoutes.profile),
      ],
      Role.supervisor => <(String, String)>[
        (l.titleQueue, AppRoutes.queue),
        (l.titleReview, AppRoutes.review('q1')),
        (l.titleDecided, AppRoutes.decided),
        (l.titleCourses, AppRoutes.learn),
        (l.titleCourseDetail, AppRoutes.course(course)),
        (l.titleProfile, AppRoutes.profile),
      ],
      Role.admin => <(String, String)>[
        (l.titleCohort, AppRoutes.cohort),
        (l.titleAudit, AppRoutes.audit),
        (l.titleInsights, AppRoutes.insights),
        (l.titleProfile, AppRoutes.profile),
      ],
    };
  }
}
