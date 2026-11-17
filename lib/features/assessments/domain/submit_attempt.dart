import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/features/assessments/data/assessment_repository.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';

/// QZ-2: scores an attempt, stores it and writes `quiz.score` (audit).
class SubmitAttempt {
  /// Creates the use case.
  const new({
    required this.repository,
    required this.logger,
    required this.clock,
    required this.newId,
  });

  /// Attempt store.
  final AssessmentRepository repository;

  /// Activity logger.
  final ActivityLogger logger;

  /// Time source.
  final Clock clock;

  /// Attempt id source (injected so tests are deterministic).
  final String Function() newId;

  /// Scores [answers] (one option index per question) and saves the attempt.
  Future<QuizAttempt> call({
    required String userId,
    required Quiz quiz,
    required List<Question> questions,
    required List<int> answers,
  }) async {
    assert(answers.length == questions.length, 'one answer per question');
    var correct = 0;
    for (final (i, q) in questions.indexed) {
      if (answers[i] == q.correctIndex) correct++;
    }
    final score = QuizRules.scorePct(correct, questions.length);
    final passed = QuizRules.passed(score);
    // History is ordered by time; under the fixed demo clock every attempt
    // would share one instant, so keep each new one strictly after the last.
    final previous = (await repository.history(userId)).firstOrNull;
    var at = clock.now().toUtc();
    if (previous != null && !at.isAfter(previous.submittedAt)) {
      at = previous.submittedAt.add(const Duration(seconds: 1));
    }
    final attempt = await repository.submitAttempt(
      QuizAttempt(
        id: newId(),
        userId: userId,
        quizId: quiz.id,
        answers: List<int>.unmodifiable(answers),
        scorePct: score,
        passed: passed,
        submittedAt: at,
      ),
    );
    await logger.audit(
      AuditAction.quizScore,
      target: '${quiz.title.en} · $score% (${passed ? 'pass' : 'fail'})',
    );
    return attempt;
  }
}
