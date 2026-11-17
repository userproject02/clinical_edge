import 'package:clinical_edge/core/json_converters.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cohort.freezed.dart';
part 'cohort.g.dart';

/// Admin cohort aggregates. Every figure is demo data ([demoFigures]).
@freezed
abstract class CohortStats with _$CohortStats {
  /// Creates the stats.
  const factory({
    required bool demoFigures,
    required LocalizedText demoLabel,
    @DateOnlyConverter() required DateTime asOf,
    required List<Department> departments,
    required CohortKpis kpis,
    required List<CoursePct> completionByCourse,
    required List<DepartmentPct> progressByDepartment,
    required List<MonthCount> expiriesByMonth,
    required List<CohortLearner> learners,
    required UsageInsights insights,
  }) = _CohortStats;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CohortStatsFromJson(json);
}

/// A department.
@freezed
abstract class Department with _$Department {
  /// Creates a department.
  const factory({required String id, required LocalizedText label}) =
      _Department;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$DepartmentFromJson(json);
}

/// Headline KPIs.
@freezed
abstract class CohortKpis with _$CohortKpis {
  /// Creates the KPIs.
  const factory({
    required int activeLearners,
    required int nursing,
    required int physicians,
    required int avgCompletionPct,
    required int avgCompletionDeltaPts,
    required LocalizedText deltaComparedTo,
    required int certsExpiringWithin90Days,

    /// Supervisors signing off (demo figure).
    @Default(0) int supervisors,
  }) = _CohortKpis;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CohortKpisFromJson(json);
}

/// Percentage per course.
@freezed
abstract class CoursePct with _$CoursePct {
  /// Creates the value.
  const factory({required String courseId, required int pct, int? attempts}) =
      _CoursePct;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CoursePctFromJson(json);
}

/// Percentage per department.
@freezed
abstract class DepartmentPct with _$DepartmentPct {
  /// Creates the value.
  const factory({required String departmentId, required int pct}) =
      _DepartmentPct;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$DepartmentPctFromJson(json);
}

/// Count per month (`yyyy-MM`).
@freezed
abstract class MonthCount with _$MonthCount {
  /// Creates the value.
  const factory({required String month, required int count}) = _MonthCount;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$MonthCountFromJson(json);
}

/// One learner row on the cohort dashboard.
@freezed
abstract class CohortLearner with _$CohortLearner {
  /// Creates the row.
  const factory({
    required String userId,
    required int completionPct,
    required int certsExpiringSoon,

    /// Code of the next certificate to expire ("BLS"), demo figure.
    String? nextExpiryCode,

    /// Days until that expiry, demo figure.
    int? nextExpiryDays,
  }) = _CohortLearner;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CohortLearnerFromJson(json);
}

/// Usage insights (ADM-4; demo figures until Phase 9 derives them from
/// usage events).
@freezed
abstract class UsageInsights with _$UsageInsights {
  /// Creates the insights.
  const factory({
    required List<CourseViews> lessonViewsByCourse,
    required DropOff dropOff,
    required List<CoursePct> firstAttemptPassRates,
    required List<PlatformPct> sessionsByPlatform,
  }) = _UsageInsights;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$UsageInsightsFromJson(json);
}

/// Lesson views per course.
@freezed
abstract class CourseViews with _$CourseViews {
  /// Creates the value.
  const factory({required String courseId, required int views}) = _CourseViews;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CourseViewsFromJson(json);
}

/// Share of learners still active at each lesson of a course.
@freezed
abstract class DropOff with _$DropOff {
  /// Creates the value.
  const factory({
    required String courseId,
    required List<int> retainedPctByLesson,
  }) = _DropOff;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$DropOffFromJson(json);
}

/// Share of sessions per platform.
@freezed
abstract class PlatformPct with _$PlatformPct {
  /// Creates the value.
  const factory({required String platform, required int pct}) = _PlatformPct;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$PlatformPctFromJson(json);
}
