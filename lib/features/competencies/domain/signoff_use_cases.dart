import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/competencies/data/competency_repository.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';

/// Thrown when the acting user may not perform a sign-off action.
class SignOffPermissionException implements Exception {
  /// Creates the exception.
  const new(this.message);

  /// Why.
  final String message;

  @override
  String toString() => 'SignOffPermissionException: $message';
}

/// COMP-1: a learner requests sign-off for a checklist; writes
/// `signoff.request` (audit) with the checklist name as target.
class RequestSignOff {
  /// Creates the use case.
  const new({required this.repository, required this.logger});

  /// Sign-off store.
  final CompetencyRepository repository;

  /// Activity logger.
  final ActivityLogger logger;

  /// Runs the use case as [learnerId] acting in [role].
  Future<SignOffRequest> call({
    required String learnerId,
    required Role role,
    required CompetencyChecklist checklist,
  }) async {
    if (role != Role.learner) {
      throw const SignOffPermissionException('only learners request');
    }
    final r = await repository.request(learnerId, checklist.id);
    await logger.audit(AuditAction.signoffRequest, target: checklist.name.en);
    return r;
  }
}

/// COMP-2: a supervisor approves or rejects a pending request; writes
/// `signoff.decision` (audit) with target
/// `"<checklist> · <learner> · approved|rejected"` (never the comment).
class DecideSignOff {
  /// Creates the use case.
  const new({required this.repository, required this.logger});

  /// Sign-off store.
  final CompetencyRepository repository;

  /// Activity logger.
  final ActivityLogger logger;

  /// Runs the use case. An empty [comment] rejects with
  /// [CommentRequiredException]; an empty approval stores [defaultApproval].
  Future<SignOffRequest> call({
    required SignOffRequest request,
    required CompetencyChecklist checklist,
    required String learnerName,
    required String supervisorId,
    required Role role,
    required bool approve,
    required String comment,
    required LocalizedText defaultApproval,
  }) async {
    if (role != Role.supervisor) {
      throw const SignOffPermissionException('only supervisors decide');
    }
    if (supervisorId == request.learnerId) {
      throw const SignOffPermissionException('cannot decide own request');
    }
    final text = comment.trim();
    if (!approve && text.isEmpty) throw const CommentRequiredException();
    final decided = await repository.decide(
      request.id,
      approve: approve,
      supervisorId: supervisorId,
      comment: text.isEmpty
          ? defaultApproval
          : LocalizedText(en: text, ar: text),
    );
    await logger.audit(
      AuditAction.signoffDecision,
      target:
          '${checklist.name.en} · $learnerName · '
          '${approve ? 'approved' : 'rejected'}',
    );
    return decided;
  }
}
