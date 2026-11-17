import 'package:clinical_edge/core/role.dart';

/// Route paths (contract: see docs/REQUIREMENTS.md → Navigation and screens).
///
/// Changing a path is BREAKING: deep links, tests and the debug menu use them.
abstract final class AppRoutes {
  /// Sign-in with role picker (all roles).
  static const String signIn = '/sign-in';

  /// Learner home tab.
  static const String home = '/home';

  /// Course catalogue tab (learner and supervisor).
  static const String learn = '/learn';

  /// Course detail (push).
  static String course(String courseId) => '/learn/$courseId';

  /// Lesson player (learner, push).
  static String lesson(String courseId, int n) => '/learn/$courseId/lesson/$n';

  /// Checkout (learner, push).
  static String checkout(String courseId) => '/learn/$courseId/checkout';

  /// Receipt (learner, push that replaces checkout).
  static String receipt(String courseId, String orderId) =>
      '/learn/$courseId/receipt/$orderId';

  /// Assessments and history tab.
  static const String assess = '/assess';

  /// Quiz in progress and result (push).
  static String quiz(String quizId) => '/assess/$quizId/run';

  /// Certifications and CPD tab.
  static const String certs = '/certs';

  /// Upload certificate (modal bottom sheet).
  static const String certUpload = '/certs/upload';

  /// Competency checklists tab (learner).
  static const String signoffs = '/signoffs';

  /// Sign-off queue tab (supervisor).
  static const String queue = '/queue';

  /// Review and decide (supervisor, push).
  static String review(String requestId) => '/queue/$requestId';

  /// Recently decided tab (supervisor).
  static const String decided = '/decided';

  /// Cohort dashboard tab (admin).
  static const String cohort = '/cohort';

  /// Audit log tab (admin).
  static const String audit = '/audit';

  /// Usage insights tab (admin).
  static const String insights = '/insights';

  /// Profile and settings (all roles, pushed from the avatar).
  static const String profile = '/profile';

  /// Home route of a role.
  static String homeFor(Role role) => switch (role) {
    Role.learner => home,
    Role.supervisor => queue,
    Role.admin => cohort,
  };
}

/// Which role may open which path.
abstract final class RouteAccess {
  static const List<String> _learner = <String>[
    AppRoutes.home,
    AppRoutes.learn,
    AppRoutes.assess,
    AppRoutes.certs,
    AppRoutes.signoffs,
  ];
  static const List<String> _supervisor = <String>[
    AppRoutes.queue,
    AppRoutes.decided,
    AppRoutes.learn,
  ];
  static const List<String> _admin = <String>[
    AppRoutes.cohort,
    AppRoutes.audit,
    AppRoutes.insights,
  ];

  static final RegExp _learnerOnlyCourseRoute = RegExp(
    r'^/learn/[^/]+/(lesson|checkout|receipt)(/|$)',
  );

  /// Whether [role] may open [path].
  static bool allows(Role role, String path) {
    if (path == AppRoutes.profile) return true;
    final roots = switch (role) {
      Role.learner => _learner,
      Role.supervisor => _supervisor,
      Role.admin => _admin,
    };
    final underRoot = roots.any((r) => path == r || path.startsWith('$r/'));
    if (!underRoot) return false;
    if (role != Role.learner && _learnerOnlyCourseRoute.hasMatch(path)) {
      return false;
    }
    return true;
  }
}
