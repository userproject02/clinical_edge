// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cohort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CohortStats _$CohortStatsFromJson(Map<String, dynamic> json) => _CohortStats(
  demoFigures: json['demoFigures'] as bool,
  demoLabel: LocalizedText.fromJson(json['demoLabel'] as Map<String, dynamic>),
  asOf: const DateOnlyConverter().fromJson(json['asOf'] as String),
  departments: (json['departments'] as List<dynamic>)
      .map((e) => Department.fromJson(e as Map<String, dynamic>))
      .toList(),
  kpis: CohortKpis.fromJson(json['kpis'] as Map<String, dynamic>),
  completionByCourse: (json['completionByCourse'] as List<dynamic>)
      .map((e) => CoursePct.fromJson(e as Map<String, dynamic>))
      .toList(),
  progressByDepartment: (json['progressByDepartment'] as List<dynamic>)
      .map((e) => DepartmentPct.fromJson(e as Map<String, dynamic>))
      .toList(),
  expiriesByMonth: (json['expiriesByMonth'] as List<dynamic>)
      .map((e) => MonthCount.fromJson(e as Map<String, dynamic>))
      .toList(),
  learners: (json['learners'] as List<dynamic>)
      .map((e) => CohortLearner.fromJson(e as Map<String, dynamic>))
      .toList(),
  insights: UsageInsights.fromJson(json['insights'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CohortStatsToJson(
  _CohortStats instance,
) => <String, dynamic>{
  'demoFigures': instance.demoFigures,
  'demoLabel': instance.demoLabel.toJson(),
  'asOf': const DateOnlyConverter().toJson(instance.asOf),
  'departments': instance.departments.map((e) => e.toJson()).toList(),
  'kpis': instance.kpis.toJson(),
  'completionByCourse': instance.completionByCourse
      .map((e) => e.toJson())
      .toList(),
  'progressByDepartment': instance.progressByDepartment
      .map((e) => e.toJson())
      .toList(),
  'expiriesByMonth': instance.expiriesByMonth.map((e) => e.toJson()).toList(),
  'learners': instance.learners.map((e) => e.toJson()).toList(),
  'insights': instance.insights.toJson(),
};

_Department _$DepartmentFromJson(Map<String, dynamic> json) => _Department(
  id: json['id'] as String,
  label: LocalizedText.fromJson(json['label'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DepartmentToJson(_Department instance) =>
    <String, dynamic>{'id': instance.id, 'label': instance.label.toJson()};

_CohortKpis _$CohortKpisFromJson(Map<String, dynamic> json) => _CohortKpis(
  activeLearners: (json['activeLearners'] as num).toInt(),
  nursing: (json['nursing'] as num).toInt(),
  physicians: (json['physicians'] as num).toInt(),
  avgCompletionPct: (json['avgCompletionPct'] as num).toInt(),
  avgCompletionDeltaPts: (json['avgCompletionDeltaPts'] as num).toInt(),
  deltaComparedTo: LocalizedText.fromJson(
    json['deltaComparedTo'] as Map<String, dynamic>,
  ),
  certsExpiringWithin90Days: (json['certsExpiringWithin90Days'] as num).toInt(),
  supervisors: (json['supervisors'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CohortKpisToJson(_CohortKpis instance) =>
    <String, dynamic>{
      'activeLearners': instance.activeLearners,
      'nursing': instance.nursing,
      'physicians': instance.physicians,
      'avgCompletionPct': instance.avgCompletionPct,
      'avgCompletionDeltaPts': instance.avgCompletionDeltaPts,
      'deltaComparedTo': instance.deltaComparedTo.toJson(),
      'certsExpiringWithin90Days': instance.certsExpiringWithin90Days,
      'supervisors': instance.supervisors,
    };

_CoursePct _$CoursePctFromJson(Map<String, dynamic> json) => _CoursePct(
  courseId: json['courseId'] as String,
  pct: (json['pct'] as num).toInt(),
  attempts: (json['attempts'] as num?)?.toInt(),
);

Map<String, dynamic> _$CoursePctToJson(_CoursePct instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'pct': instance.pct,
      'attempts': instance.attempts,
    };

_DepartmentPct _$DepartmentPctFromJson(Map<String, dynamic> json) =>
    _DepartmentPct(
      departmentId: json['departmentId'] as String,
      pct: (json['pct'] as num).toInt(),
    );

Map<String, dynamic> _$DepartmentPctToJson(_DepartmentPct instance) =>
    <String, dynamic>{
      'departmentId': instance.departmentId,
      'pct': instance.pct,
    };

_MonthCount _$MonthCountFromJson(Map<String, dynamic> json) => _MonthCount(
  month: json['month'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$MonthCountToJson(_MonthCount instance) =>
    <String, dynamic>{'month': instance.month, 'count': instance.count};

_CohortLearner _$CohortLearnerFromJson(Map<String, dynamic> json) =>
    _CohortLearner(
      userId: json['userId'] as String,
      completionPct: (json['completionPct'] as num).toInt(),
      certsExpiringSoon: (json['certsExpiringSoon'] as num).toInt(),
      nextExpiryCode: json['nextExpiryCode'] as String?,
      nextExpiryDays: (json['nextExpiryDays'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CohortLearnerToJson(_CohortLearner instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'completionPct': instance.completionPct,
      'certsExpiringSoon': instance.certsExpiringSoon,
      'nextExpiryCode': instance.nextExpiryCode,
      'nextExpiryDays': instance.nextExpiryDays,
    };

_UsageInsights _$UsageInsightsFromJson(Map<String, dynamic> json) =>
    _UsageInsights(
      lessonViewsByCourse: (json['lessonViewsByCourse'] as List<dynamic>)
          .map((e) => CourseViews.fromJson(e as Map<String, dynamic>))
          .toList(),
      dropOff: DropOff.fromJson(json['dropOff'] as Map<String, dynamic>),
      firstAttemptPassRates: (json['firstAttemptPassRates'] as List<dynamic>)
          .map((e) => CoursePct.fromJson(e as Map<String, dynamic>))
          .toList(),
      sessionsByPlatform: (json['sessionsByPlatform'] as List<dynamic>)
          .map((e) => PlatformPct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsageInsightsToJson(_UsageInsights instance) =>
    <String, dynamic>{
      'lessonViewsByCourse': instance.lessonViewsByCourse
          .map((e) => e.toJson())
          .toList(),
      'dropOff': instance.dropOff.toJson(),
      'firstAttemptPassRates': instance.firstAttemptPassRates
          .map((e) => e.toJson())
          .toList(),
      'sessionsByPlatform': instance.sessionsByPlatform
          .map((e) => e.toJson())
          .toList(),
    };

_CourseViews _$CourseViewsFromJson(Map<String, dynamic> json) => _CourseViews(
  courseId: json['courseId'] as String,
  views: (json['views'] as num).toInt(),
);

Map<String, dynamic> _$CourseViewsToJson(_CourseViews instance) =>
    <String, dynamic>{'courseId': instance.courseId, 'views': instance.views};

_DropOff _$DropOffFromJson(Map<String, dynamic> json) => _DropOff(
  courseId: json['courseId'] as String,
  retainedPctByLesson: (json['retainedPctByLesson'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$DropOffToJson(_DropOff instance) => <String, dynamic>{
  'courseId': instance.courseId,
  'retainedPctByLesson': instance.retainedPctByLesson,
};

_PlatformPct _$PlatformPctFromJson(Map<String, dynamic> json) => _PlatformPct(
  platform: json['platform'] as String,
  pct: (json['pct'] as num).toInt(),
);

Map<String, dynamic> _$PlatformPctToJson(_PlatformPct instance) =>
    <String, dynamic>{'platform': instance.platform, 'pct': instance.pct};
