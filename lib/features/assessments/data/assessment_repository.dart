import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/seed/demo_seeder.dart';
import 'package:clinical_edge/seed/seed_loader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assessment_repository.g.dart';

/// Question bank, quiz draws and attempt history.
abstract interface class AssessmentRepository {
  /// Quiz definition.
  Future<Quiz> quiz(String quizId);

  /// Every quiz definition (seed order).
  Future<List<Quiz>> quizzes();

  /// Number of questions in the bank.
  Future<int> bankSize();

  /// The questions of one attempt. v1 draws them in a fixed order (the
  /// quiz's topics in `topicOrder`, bank order within a topic) so the demo
  /// is stable; the BLS quiz is the 8 resuscitation questions.
  Future<List<Question>> drawQuiz(String quizId);

  /// Stores [attempt].
  Future<QuizAttempt> submitAttempt(QuizAttempt attempt);

  /// Attempts of [userId], newest first.
  Future<List<QuizAttempt>> history(String userId);
}

/// Mock [AssessmentRepository]: bank from seed, attempts in [LocalDb].
class MockAssessmentRepository implements AssessmentRepository {
  /// Creates the repository.
  new({required this.seed, required this.db, required this.seeder});

  /// Seed source.
  final SeedLoader seed;

  /// Persistence.
  final LocalDb db;

  /// Ensures demo data exists.
  final DemoSeeder seeder;

  @override
  Future<Quiz> quiz(String quizId) async =>
      (await seed.load(SeedFile.questionBank))
          .objects('quizzes')
          .map(Quiz.fromJson)
          .firstWhere((q) => q.id == quizId);

  @override
  Future<List<Quiz>> quizzes() async =>
      (await seed.load(SeedFile.questionBank))
          .objects('quizzes')
          .map(Quiz.fromJson)
          .toList();

  @override
  Future<int> bankSize() async =>
      (await seed.load(SeedFile.questionBank)).objects('questions').length;

  @override
  Future<List<Question>> drawQuiz(String quizId) async {
    final q = await quiz(quizId);
    final bank = (await seed.load(SeedFile.questionBank))
        .objects('questions')
        .map(Question.fromJson)
        .toList();
    return <Question>[
      for (final topic in q.topicOrder) ...bank.where((x) => x.topic == topic),
    ].take(q.size).toList();
  }

  @override
  Future<QuizAttempt> submitAttempt(QuizAttempt attempt) async {
    await seeder.ready;
    await (await db.open(Collections.attempts))
        .put(attempt.id, attempt.toJson());
    return attempt;
  }

  @override
  Future<List<QuizAttempt>> history(String userId) async {
    await seeder.ready;
    final rows = await (await db.open(Collections.attempts)).values();
    return rows
        .map(QuizAttempt.fromJson)
        .where((a) => a.userId == userId)
        .toList()
      ..sort((a, b) => b.submittedAt.compareTo(a.submittedAt));
  }
}

/// The assessment repository.
@Riverpod(keepAlive: true)
AssessmentRepository assessmentRepository(Ref ref) =>
    throw UnimplementedError('Override assessmentRepositoryProvider.');
