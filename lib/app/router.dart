import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/screens/placeholder_screen.dart';
import 'package:clinical_edge/app/screens/role_shell.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/app_bottom_sheet.dart';
import 'package:clinical_edge/core/widgets/bottom_nav_bar.dart';
import 'package:clinical_edge/features/admin/presentation/audit_screen.dart';
import 'package:clinical_edge/features/admin/presentation/cohort_screen.dart';
import 'package:clinical_edge/features/admin/presentation/insights_screen.dart';
import 'package:clinical_edge/features/assessments/presentation/assess_screen.dart';
import 'package:clinical_edge/features/assessments/presentation/quiz_screen.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/auth/presentation/sign_in_screen.dart';
import 'package:clinical_edge/features/certifications/presentation/certs_screen.dart';
import 'package:clinical_edge/features/certifications/presentation/upload_sheet.dart';
import 'package:clinical_edge/features/checkout/presentation/checkout_screen.dart';
import 'package:clinical_edge/features/checkout/presentation/receipt_screen.dart';
import 'package:clinical_edge/features/competencies/presentation/queue_screens.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_providers.dart';
import 'package:clinical_edge/features/competencies/presentation/signoffs_screen.dart';
import 'package:clinical_edge/features/courses/presentation/catalogue_screen.dart';
import 'package:clinical_edge/features/courses/presentation/course_detail_screen.dart';
import 'package:clinical_edge/features/courses/presentation/lesson_screen.dart';
import 'package:clinical_edge/features/home/presentation/home_screen.dart';
import 'package:clinical_edge/features/settings/presentation/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

/// The app's [GoRouter].
///
/// One `StatefulShellRoute.indexedStack` per role keeps each tab's back
/// stack. `/learn` belongs to both the learner and supervisor shells, so the
/// active role's shell is listed first (go_router matches in order); the
/// router is rebuilt when the role changes. Session changes re-run the
/// redirect: signed out → `/sign-in`; a route of another role → own home.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final role = ref.watch(sessionProvider.select((s) => s.value?.role));
  final session = ref.read(sessionProvider).value;
  final resume = ref.read(resumeLocationProvider);
  if (resume != null) {
    unawaited(
      Future<void>.microtask(
        () => ref.read(resumeLocationProvider.notifier).set(null),
      ),
    );
  }
  final refresh = ValueNotifier<int>(0);
  ref.listen(sessionProvider, (_, _) => refresh.value++);

  final rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final router = GoRouter(
    navigatorKey: rootKey,
    initialLocation: session == null
        ? AppRoutes.signIn
        : resume ?? AppRoutes.homeFor(session.role),
    refreshListenable: refresh,
    redirect: (context, state) {
      final s = ref.read(sessionProvider);
      // Still restoring the stored session: stay put (main.dart preloads it,
      // so this only happens for a frame in tests).
      if (s.isLoading && !s.hasValue) return null;
      return redirectFor(s.value, state.uri);
    },
    routes: buildRoutes(activeRole: role ?? Role.learner, rootKey: rootKey),
  );
  ref.onDispose(() {
    // MaterialApp swaps to the new router on the next frame; dispose after.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      router.dispose();
      refresh.dispose();
    });
  });
  return router;
}

/// Redirect rules (pure, unit-tested). [session] is null when signed out.
String? redirectFor(Session? session, Uri uri) {
  final path = uri.path;
  final atSignIn = path == AppRoutes.signIn;
  if (session == null) return atSignIn ? null : AppRoutes.signIn;
  if (atSignIn || path == '/' || path.isEmpty) {
    return AppRoutes.homeFor(session.role);
  }
  if (!RouteAccess.allows(session.role, path)) {
    return AppRoutes.homeFor(session.role);
  }
  return null;
}

/// All routes, with [activeRole]'s shell first.
List<RouteBase> buildRoutes({
  required Role activeRole,
  required GlobalKey<NavigatorState> rootKey,
}) {
  final shells = <Role, RouteBase>{
    Role.learner: _learnerShell(rootKey),
    Role.supervisor: _supervisorShell(),
    Role.admin: _adminShell(),
  };
  return <RouteBase>[
    GoRoute(
      path: AppRoutes.signIn,
      pageBuilder: (context, state) =>
          _fadePage(context, state, const SignInScreen()),
    ),
    shells[activeRole]!,
    for (final r in Role.values)
      if (r != activeRole) shells[r]!,
    GoRoute(
      path: AppRoutes.profile,
      parentNavigatorKey: rootKey,
      pageBuilder: (context, state) =>
          pushPage(context, state, const ProfileScreen()),
    ),
  ];
}

// --- Shells ---------------------------------------------------------------

RouteBase _learnerShell(GlobalKey<NavigatorState> rootKey) {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, shell) {
      final l = AppLocalizations.of(context);
      return RoleShell(
        navigationShell: shell,
        items: <NavItem>[
          NavItem(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home_rounded,
            label: l.navHome,
          ),
          NavItem(
            icon: Icons.menu_book_outlined,
            selectedIcon: Icons.menu_book_rounded,
            label: l.navLearn,
          ),
          NavItem(
            icon: Icons.assignment_turned_in_outlined,
            selectedIcon: Icons.assignment_turned_in_rounded,
            label: l.navAssess,
          ),
          NavItem(
            icon: Icons.workspace_premium_outlined,
            selectedIcon: Icons.workspace_premium_rounded,
            label: l.navCerts,
          ),
          NavItem(
            icon: Icons.fact_check_outlined,
            selectedIcon: Icons.fact_check_rounded,
            label: l.navSignoffs,
          ),
        ],
      );
    },
    branches: <StatefulShellBranch>[
      _branch(
        _tab(
          AppRoutes.home,
          (l) => l.titleHome,
          Icons.home_outlined,
          screen: (_) => const HomeScreen(),
        ),
      ),
      _branch(_learnRoute(learnerOnly: true)),
      _branch(
        _tab(
          AppRoutes.assess,
          (l) => l.titleAssessments,
          Icons.assignment_turned_in_outlined,
          screen: (_) => const AssessScreen(),
          routes: <RouteBase>[
            // Root navigator: the quiz has no bottom navigation.
            GoRoute(
              path: ':quizId/run',
              parentNavigatorKey: rootKey,
              pageBuilder: (context, state) => pushPage(
                context,
                state,
                QuizScreen(quizId: state.pathParameters['quizId']!),
              ),
            ),
          ],
        ),
      ),
      _branch(
        _tab(
          AppRoutes.certs,
          (l) => l.titleCerts,
          Icons.workspace_premium_outlined,
          screen: (_) => const CertsScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: 'upload',
              parentNavigatorKey: rootKey,
              pageBuilder: (context, state) => BottomSheetPage<void>(
                key: state.pageKey,
                name: state.uri.path,
                child: const UploadSheet(),
              ),
            ),
          ],
        ),
      ),
      _branch(
        _tab(
          AppRoutes.signoffs,
          (l) => l.titleCompetencies,
          Icons.fact_check_outlined,
          screen: (_) => const SignOffsScreen(),
        ),
      ),
    ],
  );
}

RouteBase _supervisorShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, shell) {
      final l = AppLocalizations.of(context);
      return Consumer(
        builder: (context, ref, _) => RoleShell(
          navigationShell: shell,
          items: <NavItem>[
            NavItem(
              icon: Icons.inbox_outlined,
              selectedIcon: Icons.inbox_rounded,
              label: l.navQueue,
              // Pending sign-off requests.
              badge: ref.watch(signOffQueueProvider).value?.length ?? 0,
            ),
            NavItem(
              icon: Icons.task_alt_outlined,
              selectedIcon: Icons.task_alt_rounded,
              label: l.navDecided,
            ),
            NavItem(
              icon: Icons.menu_book_outlined,
              selectedIcon: Icons.menu_book_rounded,
              label: l.navLearn,
            ),
          ],
        ),
      );
    },
    branches: <StatefulShellBranch>[
      _branch(
        _tab(
          AppRoutes.queue,
          (l) => l.titleQueue,
          Icons.inbox_outlined,
          screen: (_) => const QueueScreen(),
          routes: <RouteBase>[
            _detail(
              ':requestId',
              (l) => l.titleReview,
              Icons.rate_review_outlined,
              screen: (state) =>
                  ReviewScreen(requestId: state.pathParameters['requestId']!),
            ),
          ],
        ),
      ),
      _branch(
        _tab(
          AppRoutes.decided,
          (l) => l.titleDecided,
          Icons.task_alt_outlined,
          screen: (_) => const DecidedScreen(),
        ),
      ),
      _branch(_learnRoute(learnerOnly: false)),
    ],
  );
}

RouteBase _adminShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, shell) {
      final l = AppLocalizations.of(context);
      return RoleShell(
        navigationShell: shell,
        items: <NavItem>[
          NavItem(
            icon: Icons.insert_chart_outlined_rounded,
            selectedIcon: Icons.insert_chart_rounded,
            label: l.navCohort,
          ),
          NavItem(
            icon: Icons.verified_user_outlined,
            selectedIcon: Icons.verified_user_rounded,
            label: l.navAudit,
          ),
          NavItem(icon: Icons.trending_up_rounded, label: l.navInsights),
        ],
      );
    },
    branches: <StatefulShellBranch>[
      _branch(
        _tab(
          AppRoutes.cohort,
          (l) => l.titleCohort,
          Icons.insert_chart_outlined_rounded,
          screen: (_) => const CohortScreen(),
        ),
      ),
      _branch(
        _tab(
          AppRoutes.audit,
          (l) => l.titleAudit,
          Icons.verified_user_outlined,
          screen: (_) => const AuditScreen(),
        ),
      ),
      _branch(
        _tab(
          AppRoutes.insights,
          (l) => l.titleInsights,
          Icons.trending_up_rounded,
          screen: (_) => const InsightsScreen(),
        ),
      ),
    ],
  );
}

/// `/learn` with course detail; the learner adds lesson, checkout, receipt.
GoRoute _learnRoute({required bool learnerOnly}) {
  return _tab(
    AppRoutes.learn,
    (l) => l.titleCourses,
    Icons.menu_book_outlined,
    screen: (_) => const CatalogueScreen(),
    routes: <RouteBase>[
      _detail(
        ':courseId',
        (l) => l.titleCourseDetail,
        Icons.school_outlined,
        hero: true,
        screen: (state) =>
            CourseDetailScreen(courseId: state.pathParameters['courseId']!),
        routes: <RouteBase>[
          if (learnerOnly) ...<RouteBase>[
            _detail(
              'lesson/:n',
              (l) => l.titleLesson,
              Icons.play_circle_outline_rounded,
              hero: true,
              screen: (state) => LessonScreen(
                courseId: state.pathParameters['courseId']!,
                number: int.tryParse(state.pathParameters['n']!) ?? 1,
              ),
            ),
            _detail(
              'checkout',
              (l) => l.titleCheckout,
              Icons.shopping_bag_outlined,
              screen: (state) =>
                  CheckoutScreen(courseId: state.pathParameters['courseId']!),
            ),
            _detail(
              'receipt/:orderId',
              (l) => l.titleReceipt,
              Icons.receipt_long_outlined,
              screen: (state) => ReceiptScreen(
                courseId: state.pathParameters['courseId']!,
                orderId: state.pathParameters['orderId']!,
              ),
            ),
          ],
        ],
      ),
    ],
  );
}

// --- Builders -------------------------------------------------------------

StatefulShellBranch _branch(GoRoute root) =>
    StatefulShellBranch(routes: <RouteBase>[root]);

GoRoute _tab(
  String path,
  TitleOf title,
  IconData icon, {
  List<RouteBase> routes = const <RouteBase>[],
  Widget Function(GoRouterState state)? screen,
}) {
  return GoRoute(
    path: path,
    // The shell animates tab switches, so tab roots have no page transition.
    pageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      name: state.uri.path,
      child:
          screen?.call(state) ??
          TabPlaceholder(title: title, path: state.uri.path, icon: icon),
    ),
    routes: routes,
  );
}

GoRoute _detail(
  String path,
  TitleOf title,
  IconData icon, {
  bool hero = false,
  List<RouteBase> routes = const <RouteBase>[],
  Widget Function(GoRouterState state)? screen,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => pushPage(
      context,
      state,
      screen?.call(state) ??
          DetailPlaceholder(
            title: title,
            path: state.uri.path,
            icon: icon,
            hero: hero,
          ),
    ),
    routes: routes,
  );
}

/// Page with the shared-axis push transition (mirrors in RTL; instant with
/// reduced motion).
Page<void> pushPage(BuildContext context, GoRouterState state, Widget child) {
  final duration = Motion.duration(context, Motion.push);
  return CustomTransitionPage<void>(
    key: state.pageKey,
    name: state.uri.path,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SharedAxisPageTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
  );
}

Page<void> _fadePage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    name: state.uri.path,
    transitionDuration: Motion.duration(context, Motion.tabSwitch),
    child: child,
    transitionsBuilder: (context, animation, _, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Motion.standard),
      child: child,
    ),
  );
}

/// Context of the current root navigator (for overlays shown after the
/// router was rebuilt, e.g. the role-switch snackbar).
@Riverpod(keepAlive: true)
BuildContext? Function() rootNavigatorContext(Ref ref) =>
    () => ref
        .read(routerProvider)
        .routerDelegate
        .navigatorKey
        .currentState
        ?.overlay
        ?.context;
