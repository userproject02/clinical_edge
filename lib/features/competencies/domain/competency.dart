import 'package:clinical_edge/core/json_converters.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'competency.freezed.dart';
part 'competency.g.dart';

/// A competency checklist.
@freezed
abstract class CompetencyChecklist with _$CompetencyChecklist {
  /// Creates a checklist.
  const factory({
    required String id,
    required LocalizedText name,
    required LocalizedText audience,
    required List<LocalizedText> items,
  }) = _CompetencyChecklist;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) =>
      _$CompetencyChecklistFromJson(json);
}

/// Sign-off lifecycle: none → pending → approved | rejected.
enum SignOffStatus {
  /// Not requested yet.
  none,

  /// Waiting for a supervisor.
  pending,

  /// Approved.
  approved,

  /// Changes requested.
  rejected,
}

/// A learner's sign-off request for one checklist.
@freezed
abstract class SignOffRequest with _$SignOffRequest {
  /// Creates a request.
  const factory({
    required String id,
    required String learnerId,
    required String checklistId,
    required SignOffStatus status,
    @NullableUtcDateTimeConverter() DateTime? requestedAt,
    String? decidedBy,
    @NullableUtcDateTimeConverter() DateTime? decidedAt,
    LocalizedText? comment,
  }) = _SignOffRequest;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$SignOffRequestFromJson(json);
}
