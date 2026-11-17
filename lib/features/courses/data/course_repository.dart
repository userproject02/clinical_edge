import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_repository.g.dart';

/// Catalogue and ownership.
abstract interface class CourseRepository {
  /// Catalogue categories.
  Future<List<CourseCategory>> categories();

  /// Every course, in catalogue order.
  Future<List<Course>> catalogue();

  /// Course by id, or null.
  Future<Course?> byId(String courseId);

  /// Ids of the courses [userId] owns.
  Future<Set<String>> ownedCourseIds(String userId);

  /// Whether [userId] owns [courseId].
  Future<bool> isOwned(String userId, String courseId);

  /// Unlocks [courseId] for [userId] (after purchase).
  Future<void> grantOwnership(String userId, String courseId);
}

/// Lesson completion.
abstract interface class ProgressRepository {
  /// Completed lessons of [userId].
  Future<List<LessonProgress>> forUser(String userId);

  /// Marks [lessonId] complete (idempotent; keeps the first timestamp).
  Future<LessonProgress> markComplete(String userId, String lessonId);
}

/// The course repository.
@Riverpod(keepAlive: true)
CourseRepository courseRepository(Ref ref) =>
    throw UnimplementedError('Override courseRepositoryProvider.');

/// The progress repository.
@Riverpod(keepAlive: true)
ProgressRepository progressRepository(Ref ref) =>
    throw UnimplementedError('Override progressRepositoryProvider.');
