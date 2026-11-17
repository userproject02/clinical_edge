import 'package:clinical_edge/core/logging/activity_event.dart';
import 'package:clinical_edge/features/admin/domain/cohort.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';

/// Usage insights (ADM-4) built only from usage events and seed
/// aggregates. Audit events are rejected (never counted).
class InsightsView {
  /// Creates the view.
  const new({
    required this.courseViews,
    required this.dropOffCourseId,
    required this.retainedPct,
    required this.biggestDropLesson,
    required this.passRates,
    required this.iosPct,
    required this.androidPct,
  });

  /// Merges seed [insights] with live [usage] events. [courses] maps the
  /// English course titles in event targets to course ids. Seed shares
  /// count as [seedSessions] sessions when merging live sign-ins.
  factory build({
    required UsageInsights insights,
    required List<ActivityEvent> usage,
    required List<Course> courses,
    int seedSessions = 100,
  }) {
    if (usage.any((e) => e.kind != EventKind.usage)) {
      throw ArgumentError('Insights must be built from usage events only.');
    }
    final views = <String, int>{
      for (final v in insights.lessonViewsByCourse) v.courseId: v.views,
    };
    for (final e in usage) {
      if (e.action != UsageAction.courseView.wire &&
          e.action != UsageAction.lessonView.wire) {
        continue;
      }
      final course = courses
          .where((c) => e.target.startsWith(c.title.en))
          .firstOrNull;
      if (course != null) views[course.id] = (views[course.id] ?? 0) + 1;
    }
    final retained = insights.dropOff.retainedPctByLesson;
    var biggest = 1;
    var drop = -1;
    for (var i = 1; i < retained.length; i++) {
      final d = retained[i - 1] - retained[i];
      if (d > drop) {
        drop = d;
        biggest = i + 1;
      }
    }
    double seedShare(String p) =>
        insights.sessionsByPlatform
            .where((x) => x.platform == p)
            .firstOrNull
            ?.pct
            .toDouble() ??
        0;
    final signIns = usage.where((e) => e.action == UsageAction.authSignin.wire);
    final ios =
        seedShare('ios') / 100 * seedSessions +
        signIns.where((e) => e.platform == 'ios').length;
    final android =
        seedShare('android') / 100 * seedSessions +
        signIns.where((e) => e.platform == 'android').length;
    final total = ios + android;
    final iosPct = total == 0 ? 0 : (ios / total * 100).round();
    return InsightsView(
      courseViews: [
        for (final e in views.entries)
          CourseViews(courseId: e.key, views: e.value),
      ]..sort((a, b) => b.views.compareTo(a.views)),
      dropOffCourseId: insights.dropOff.courseId,
      retainedPct: retained,
      biggestDropLesson: biggest,
      passRates: insights.firstAttemptPassRates,
      iosPct: iosPct,
      androidPct: total == 0 ? 0 : 100 - iosPct,
    );
  }

  /// Views per course id (seed + live), most viewed first.
  final List<CourseViews> courseViews;

  /// Course of the drop-off chart.
  final String dropOffCourseId;

  /// Share of enrolled learners reaching each lesson.
  final List<int> retainedPct;

  /// 1-based lesson with the largest drop from the previous lesson.
  final int biggestDropLesson;

  /// First-attempt pass rates (seed; quiz scores are audit events).
  final List<CoursePct> passRates;

  /// Sessions on iOS, percent (seed weighted with live sign-ins).
  final int iosPct;

  /// Sessions on Android, percent.
  final int androidPct;
}
