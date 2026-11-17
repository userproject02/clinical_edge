import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/features/certifications/data/certification_repository.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';

/// Outcome of [MarkLessonComplete].
enum LessonCompletion {
  /// The lesson was already done.
  alreadyDone,

  /// Lesson done, course not finished.
  lessonDone,

  /// This lesson finished the course (credits awarded).
  courseComplete,
}

/// CRS-3 / CRS-4: mark a lesson complete; when it finishes the course,
/// write `course.complete` (audit) and add the course's CPD credits.
class MarkLessonComplete {
  /// Creates the use case.
  const new({
    required this.progress,
    required this.cpd,
    required this.logger,
    required this.clock,
  });

  /// Progress store.
  final ProgressRepository progress;

  /// CPD ledger.
  final CpdRepository cpd;

  /// Activity logger.
  final ActivityLogger logger;

  /// Time source.
  final Clock clock;

  /// Runs the use case.
  Future<LessonCompletion> call({
    required String userId,
    required Course course,
    required int lessonIndex,
  }) async {
    final lesson = course.lessons[lessonIndex];
    final before = {for (final p in await progress.forUser(userId)) p.lessonId};
    if (before.contains(lesson.id)) return LessonCompletion.alreadyDone;
    await progress.markComplete(userId, lesson.id);
    logger.usage(
      UsageAction.lessonComplete,
      target: '${course.title.en} · ${lesson.title.en}',
    );
    final allDone = course.lessons.every(
      (l) => l.id == lesson.id || before.contains(l.id),
    );
    if (!allDone) return LessonCompletion.lessonDone;
    await cpd.add(
      CpdEntry(
        id: 'cpd-course-${course.id}-$userId',
        userId: userId,
        date: clock.today(),
        activity: course.title,
        source: CpdSource.clinicaledge,
        credits: course.cpdCredits,
      ),
    );
    await logger.audit(
      AuditAction.courseComplete,
      target: '${course.title.en} · +${course.cpdCredits} CPD',
    );
    return LessonCompletion.courseComplete;
  }
}
