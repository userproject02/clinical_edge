import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/features/assessments/data/assessment_repository.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/features/assessments/domain/submit_attempt.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'assessment_providers.g.dart';

/// One quiz card on the Assess tab (QZ-3).
class QuizCardData {
  /// Creates the card data.
  const new({
    required this.quiz,
    required this.bankSize,
    required this.unlocked,
    required this.lessonsToUnlock,
    required this.attempts,
  });

  /// Quiz definition.
  final Quiz quiz;

  /// Questions in the bank.
  final int bankSize;

  /// Whether the learner may start it (its course is complete, or it is the
  /// first quiz).
  final bool unlocked;

  /// Lessons in the quiz's course (for the "Unlocks after all N lessons"
  /// line).
  final int lessonsToUnlock;

  /// This quiz's attempts, newest first.
  final List<QuizAttempt> attempts;

  /// Best score, or null without attempts.
  int? get best => attempts.isEmpty
      ? null
      : attempts.map((a) => a.scorePct).reduce((a, b) => a > b ? a : b);
}

/// Assess tab content: every quiz with lock state and history.
///
/// The first quiz (BLS) is always open; later quizzes unlock when their
/// course is complete.
@riverpod
Future<List<QuizCardData>> quizCards(Ref ref) async {
  final repo = ref.watch(assessmentRepositoryProvider);
  final quizzes = await repo.quizzes();
  final bank = await repo.bankSize();
  final history = await ref.watch(quizHistoryProvider.future);
  final courses = await ref.watch(courseProgressListProvider.future);
  return <QuizCardData>[
    for (final (i, q) in quizzes.indexed)
      () {
        final course = courses.where((c) => c.course.id == q.courseId);
        return QuizCardData(
          quiz: q,
          bankSize: bank,
          unlocked: i == 0 || course.any((c) => c.owned && c.isComplete),
          lessonsToUnlock: course.firstOrNull?.total ?? 0,
          attempts: history.where((a) => a.quizId == q.id).toList(),
        );
      }(),
  ];
}

/// "Attempt N" number of [attempt]: its position among the attempts of the
/// same quiz, oldest = 1. [history] is newest first.
int attemptNumber(List<QuizAttempt> history, QuizAttempt attempt) =>
    history
        .where((a) => a.quizId == attempt.quizId)
        .toList()
        .reversed
        .toList()
        .indexOf(attempt) +
    1;

/// State of one quiz run (QZ-1, QZ-2).
class QuizSession {
  /// Creates a session.
  const new({
    required this.quiz,
    required this.questions,
    required this.answers,
    required this.index,
    this.result,
    this.submitting = false,
  });

  /// Quiz definition.
  final Quiz quiz;

  /// Drawn questions.
  final List<Question> questions;

  /// Chosen option per question (null = unanswered).
  final List<int?> answers;

  /// Current question.
  final int index;

  /// The saved attempt once finished.
  final QuizAttempt? result;

  /// Whether the attempt is being saved.
  final bool submitting;

  /// Current question.
  Question get current => questions[index];

  /// Whether the current question is answered (locked).
  bool get answered => answers[index] != null;

  /// Whether this is the last question.
  bool get isLast => index == questions.length - 1;

  /// Whether the run has any answers but no result yet.
  bool get inProgress => result == null && answers.any((a) => a != null);

  /// Correct answers so far.
  int get correct => <int>[
    for (final (i, q) in questions.indexed)
      if (answers[i] == q.correctIndex) i,
  ].length;

  QuizSession _copy({
    List<int?>? answers,
    int? index,
    QuizAttempt? result,
    bool? submitting,
  }) => QuizSession(
    quiz: quiz,
    questions: questions,
    answers: answers ?? this.answers,
    index: index ?? this.index,
    result: result ?? this.result,
    submitting: submitting ?? this.submitting,
  );
}

/// Attempt id source (overridable in tests).
@Riverpod(keepAlive: true)
String Function() attemptIdFactory(Ref ref) =>
    () => 'att-${const Uuid().v4()}';

/// One quiz run: answer, next, submit, retake.
@riverpod
class QuizRun extends _$QuizRun {
  @override
  Future<QuizSession> build(String quizId) => _fresh();

  Future<QuizSession> _fresh() async {
    final repo = ref.read(assessmentRepositoryProvider);
    final quiz = await repo.quiz(quizId);
    final questions = await repo.drawQuiz(quizId);
    return QuizSession(
      quiz: quiz,
      questions: questions,
      answers: List<int?>.filled(questions.length, null),
      index: 0,
    );
  }

  /// Locks [option] as the answer to the current question; later taps are
  /// ignored.
  void answer(int option) {
    final s = state.value;
    if (s == null || s.answered || s.result != null) return;
    state = AsyncData(
      s._copy(answers: <int?>[...s.answers]..[s.index] = option),
    );
  }

  /// Moves on; on the last question saves the attempt.
  Future<void> next() async {
    final s = state.value;
    if (s == null || !s.answered || s.submitting || s.result != null) return;
    if (!s.isLast) {
      state = AsyncData(s._copy(index: s.index + 1));
      return;
    }
    state = AsyncData(s._copy(submitting: true));
    final attempt =
        await SubmitAttempt(
          repository: ref.read(assessmentRepositoryProvider),
          logger: ref.read(activityLoggerProvider),
          clock: ref.read(clockProvider),
          newId: ref.read(attemptIdFactoryProvider),
        )(
          userId: ref.read(sessionProvider).value?.user.id ?? '',
          quiz: s.quiz,
          questions: s.questions,
          answers: s.answers.cast<int>(),
        );
    ref.invalidate(quizHistoryProvider);
    state = AsyncData(s._copy(result: attempt, submitting: false));
  }

  /// Starts a fresh attempt.
  Future<void> retake() async {
    state = AsyncData(await _fresh());
  }
}
