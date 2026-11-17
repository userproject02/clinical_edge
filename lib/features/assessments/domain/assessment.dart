import 'package:clinical_edge/core/json_converters.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'assessment.freezed.dart';
part 'assessment.g.dart';

/// Quiz rules.
abstract final class QuizRules {
  /// Pass mark in percent.
  static const int passMarkPct = 80;

  /// Score in whole percent (half up): 7/8 → 88, 5/8 → 63.
  static int scorePct(int correct, int total) =>
      total == 0 ? 0 : ((correct * 200 + total) ~/ (total * 2));

  /// Whether [scorePct] passes.
  static bool passed(int scorePct) => scorePct >= passMarkPct;
}

/// One multiple-choice question (exactly 4 options).
@freezed
abstract class Question with _$Question {
  /// Creates a question.
  const factory({
    required String id,
    required String bankId,
    required String topic,
    required LocalizedText prompt,
    required List<LocalizedText> options,
    required int correctIndex,
    required LocalizedText explanation,
    required String sourceGuideline,
  }) = _Question;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$QuestionFromJson(json);
}

/// A quiz definition.
@freezed
abstract class Quiz with _$Quiz {
  /// Creates a quiz.
  const factory({
    required String id,
    required String courseId,
    required LocalizedText title,
    required List<String> topicOrder,
    required int size,
    required int passMarkPct,
  }) = _Quiz;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$QuizFromJson(json);
}

/// A submitted quiz.
@freezed
abstract class QuizAttempt with _$QuizAttempt {
  /// Creates an attempt.
  const factory({
    required String id,
    required String userId,
    required String quizId,
    required List<int> answers,
    required int scorePct,
    required bool passed,
    @UtcDateTimeConverter() required DateTime submittedAt,
  }) = _QuizAttempt;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$QuizAttemptFromJson(json);
}
