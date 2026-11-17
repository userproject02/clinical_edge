/// The three roles that share the app. The active role decides the bottom-bar
/// tabs, the home route and which routes may be opened.
enum Role {
  /// Takes courses and quizzes, tracks certifications, requests sign-off.
  learner,

  /// Reviews and decides competency sign-offs.
  supervisor,

  /// Watches cohort progress, the audit log and usage insights.
  admin,
}
