import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:flutter/foundation.dart';

/// One course with the learner's progress through it.
@immutable
class CourseProgress {
  /// Creates the value.
  const new({
    required this.course,
    required this.owned,
    required this.doneLessonIds,
  });

  /// The course.
  final Course course;

  /// Whether the learner owns it.
  final bool owned;

  /// Ids of completed lessons.
  final Set<String> doneLessonIds;

  /// Lessons completed.
  int get done =>
      course.lessons.where((l) => doneLessonIds.contains(l.id)).length;

  /// Lessons in the course.
  int get total => course.lessons.length;

  /// Whole percent complete.
  int get pct => total == 0 ? 0 : (done * 100 / total).round();

  /// Every lesson done.
  bool get isComplete => total > 0 && done == total;

  /// Index of the first lesson not done (0 when none done), or null when
  /// complete.
  int? get nextIndex {
    for (var i = 0; i < course.lessons.length; i++) {
      if (!doneLessonIds.contains(course.lessons[i].id)) return i;
    }
    return null;
  }

  /// Whether lesson [index] is done.
  bool isDone(int index) => doneLessonIds.contains(course.lessons[index].id);
}

/// Totals across the learner's owned courses (HOME-1).
@immutable
class LearnerOverview {
  /// Creates the value.
  const new(this.owned);

  /// Owned courses with progress, catalogue order.
  final List<CourseProgress> owned;

  /// Completed lessons in owned courses.
  int get doneLessons => owned.fold(0, (s, c) => s + c.done);

  /// Lessons in owned courses.
  int get totalLessons => owned.fold(0, (s, c) => s + c.total);

  /// Overall percent: completed / total lessons in owned courses.
  int get pct =>
      totalLessons == 0 ? 0 : (doneLessons * 100 / totalLessons).round();

  /// The course and lesson index to resume: the first unfinished course
  /// that has been started, else the first unfinished course.
  (CourseProgress, int)? get resume {
    CourseProgress? pick;
    for (final c in owned) {
      if (c.isComplete) continue;
      if (c.done > 0) {
        pick = c;
        break;
      }
      pick ??= c;
    }
    if (pick == null) return null;
    return (pick, pick.nextIndex!);
  }
}
