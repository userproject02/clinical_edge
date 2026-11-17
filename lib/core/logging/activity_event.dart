import 'package:clinical_edge/core/json_converters.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_event.freezed.dart';
part 'activity_event.g.dart';

/// Audit actions (append-only, hash-chained). Wire names are a contract:
/// the hash chain and CSV export depend on them.
enum AuditAction {
  /// Demo role switched.
  roleChange('role.change'),

  /// Quiz submitted (target: score).
  quizScore('quiz.score'),

  /// Learner requested a competency sign-off.
  signoffRequest('signoff.request'),

  /// Supervisor approved or rejected a sign-off.
  signoffDecision('signoff.decision'),

  /// Course purchased (target: amount + invoice number only).
  purchase('purchase'),

  /// Certificate uploaded.
  certUpload('cert.upload'),

  /// All lessons of a course finished.
  courseComplete('course.complete'),

  /// Audit log exported as CSV.
  auditExport('audit.export');

  new(this.wire);

  /// Name stored in events and exports.
  final String wire;

  /// Parses a wire name.
  static AuditAction fromWire(String wire) =>
      values.firstWhere((a) => a.wire == wire);
}

/// Usage actions (separate store, may be lossy).
enum UsageAction {
  /// Signed in.
  authSignin('auth.signin'),

  /// Signed out.
  authSignout('auth.signout'),

  /// Course detail opened.
  courseView('course.view'),

  /// Lesson opened.
  lessonView('lesson.view'),

  /// Lesson marked complete.
  lessonComplete('lesson.complete'),

  /// Checkout started.
  checkoutStart('checkout.start'),

  /// Expiry reminder shown.
  notifyReminder('notify.reminder');

  new(this.wire);

  /// Name stored in events.
  final String wire;

  /// Parses a wire name.
  static UsageAction fromWire(String wire) =>
      values.firstWhere((a) => a.wire == wire);
}

/// Which store an event belongs to.
enum EventKind {
  /// Append-only, hash-chained.
  audit,

  /// Analytics, lossy.
  usage,
}

/// One logged event. Field names and meanings are a contract (hash chain,
/// CSV export: ts, user, role, action, target, platform, kind, prevHash,
/// hash). [prevHash] and [hash] are set for audit events only.
@freezed
abstract class ActivityEvent with _$ActivityEvent {
  /// Creates an event.
  const factory({
    required String id,
    @UtcDateTimeConverter() required DateTime ts,
    required String userId,
    required Role role,
    required String action,
    required String target,
    required String platform,
    required EventKind kind,
    String? prevHash,
    String? hash,
  }) = _ActivityEvent;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$ActivityEventFromJson(json);
}
