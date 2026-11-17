import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/features/assessments/data/assessment_repository.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/certifications/data/certification_repository.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/competencies/data/competency_repository.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:clinical_edge/features/courses/domain/course_progress.dart';
import 'package:clinical_edge/features/courses/domain/mark_lesson_complete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'learning_providers.g.dart';

String _userId(Ref ref) =>
    ref.watch(sessionProvider.select((s) => s.value?.user.id)) ?? '';

/// Catalogue categories.
@riverpod
Future<List<CourseCategory>> categories(Ref ref) =>
    ref.watch(courseRepositoryProvider).categories();

/// Catalogue.
@riverpod
Future<List<Course>> catalogue(Ref ref) =>
    ref.watch(courseRepositoryProvider).catalogue();

/// Owned course ids of the signed-in user.
@riverpod
Future<Set<String>> ownedCourseIds(Ref ref) =>
    ref.watch(courseRepositoryProvider).ownedCourseIds(_userId(ref));

/// Completed lessons of the signed-in user.
@riverpod
Future<List<LessonProgress>> lessonProgress(Ref ref) =>
    ref.watch(progressRepositoryProvider).forUser(_userId(ref));

/// Every course with ownership and progress (catalogue order).
@riverpod
Future<List<CourseProgress>> courseProgressList(Ref ref) async {
  final courses = await ref.watch(catalogueProvider.future);
  final owned = await ref.watch(ownedCourseIdsProvider.future);
  final done = {
    for (final p in await ref.watch(lessonProgressProvider.future)) p.lessonId,
  };
  return <CourseProgress>[
    for (final c in courses)
      CourseProgress(
        course: c,
        owned: owned.contains(c.id),
        doneLessonIds: done,
      ),
  ];
}

/// One course with progress.
@riverpod
Future<CourseProgress?> courseProgress(Ref ref, String courseId) async {
  final all = await ref.watch(courseProgressListProvider.future);
  return all.where((c) => c.course.id == courseId).firstOrNull;
}

/// Home totals.
@riverpod
Future<LearnerOverview> learnerOverview(Ref ref) async => LearnerOverview(
  (await ref.watch(courseProgressListProvider.future))
      .where((c) => c.owned)
      .toList(),
);

/// Certifications of the signed-in user (soonest expiry first).
@riverpod
Future<List<Certification>> myCertifications(Ref ref) =>
    ref.watch(certificationRepositoryProvider).list(_userId(ref));

/// CPD config.
@riverpod
Future<CpdConfig> cpdConfig(Ref ref) =>
    ref.watch(cpdRepositoryProvider).config();

/// CPD ledger of the signed-in user (newest first).
@riverpod
Future<List<CpdEntry>> cpdLedger(Ref ref) =>
    ref.watch(cpdRepositoryProvider).ledger(_userId(ref));

/// Quiz attempts of the signed-in user (newest first).
@riverpod
Future<List<QuizAttempt>> quizHistory(Ref ref) =>
    ref.watch(assessmentRepositoryProvider).history(_userId(ref));

/// Competency checklists.
@riverpod
Future<List<CompetencyChecklist>> checklists(Ref ref) =>
    ref.watch(competencyRepositoryProvider).checklists();

/// Sign-off requests of the signed-in learner.
@riverpod
Future<List<SignOffRequest>> mySignOffs(Ref ref) =>
    ref.watch(competencyRepositoryProvider).requestsFor(_userId(ref));

/// Marks a lesson complete and refreshes every view of progress.
@Riverpod(keepAlive: true)
Future<LessonCompletion> Function(Course course, int index) completeLesson(
  Ref ref,
) => (course, index) async {
  final result = await MarkLessonComplete(
    progress: ref.read(progressRepositoryProvider),
    cpd: ref.read(cpdRepositoryProvider),
    logger: ref.read(activityLoggerProvider),
    clock: ref.read(clockProvider),
  )(userId: _userIdRead(ref), course: course, lessonIndex: index);
  ref
    ..invalidate(lessonProgressProvider)
    ..invalidate(cpdLedgerProvider);
  return result;
};

String _userIdRead(Ref ref) => ref.read(sessionProvider).value?.user.id ?? '';

/// Logs `course.view` for a course id (usage).
@Riverpod(keepAlive: true)
void Function(String courseId) logCourseView(Ref ref) => (courseId) {
  final title = ref
      .read(catalogueProvider)
      .value
      ?.where((c) => c.id == courseId)
      .firstOrNull
      ?.title
      .en;
  ref
      .read(activityLoggerProvider)
      .usage(UsageAction.courseView, target: title ?? courseId);
};

/// Logs `lesson.view` (usage).
@Riverpod(keepAlive: true)
void Function(Course course, int index) logLessonView(Ref ref) =>
    (course, index) => ref
        .read(activityLoggerProvider)
        .usage(
          UsageAction.lessonView,
          target: '${course.title.en} · ${course.lessons[index].title.en}',
        );
