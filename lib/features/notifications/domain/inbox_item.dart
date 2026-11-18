/// What an inbox item is about (sets its icon and tone).
enum InboxKind {
  /// A certificate has expired (learner).
  certExpired,

  /// A certificate is in its renewal window (learner).
  certExpiring,

  /// An uploaded certificate is waiting for verification (learner).
  certVerifying,

  /// A sign-off request was approved (learner).
  signOffApproved,

  /// A sign-off request was returned with changes requested (learner).
  signOffRejected,

  /// A learner asked for sign-off (supervisor).
  signOffRequest,

  /// A cohort certificate expires soon (admin).
  cohortExpiry,

  /// Sign-off requests are waiting for supervisors (admin).
  cohortPending,
}

/// One entry in the bell's notifications sheet.
///
/// Items are derived from live data every time (certificates, sign-offs,
/// cohort figures); nothing is stored. [id] is stable for the same fact, so
/// "seen" survives rebuilds.
class InboxItem {
  /// Creates an item.
  const new({
    required this.id,
    required this.kind,
    required this.title,
    required this.body,
    required this.route,
  });

  /// Stable id of the fact this item reports.
  final String id;

  /// What the item is about.
  final InboxKind kind;

  /// Headline (localized).
  final String title;

  /// Supporting line (localized).
  final String body;

  /// Where tapping the item goes.
  final String route;
}
