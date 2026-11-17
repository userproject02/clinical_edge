// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseCategory _$CourseCategoryFromJson(Map<String, dynamic> json) =>
    _CourseCategory(
      id: json['id'] as String,
      label: LocalizedText.fromJson(json['label'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseCategoryToJson(_CourseCategory instance) =>
    <String, dynamic>{'id': instance.id, 'label': instance.label.toJson()};

_Lesson _$LessonFromJson(Map<String, dynamic> json) => _Lesson(
  id: json['id'] as String,
  order: (json['order'] as num).toInt(),
  title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
  type: $enumDecode(_$LessonTypeEnumMap, json['type']),
  minutes: (json['minutes'] as num).toInt(),
  assetRef: json['assetRef'] as String,
);

Map<String, dynamic> _$LessonToJson(_Lesson instance) => <String, dynamic>{
  'id': instance.id,
  'order': instance.order,
  'title': instance.title.toJson(),
  'type': _$LessonTypeEnumMap[instance.type]!,
  'minutes': instance.minutes,
  'assetRef': instance.assetRef,
};

const _$LessonTypeEnumMap = {
  LessonType.video: 'video',
  LessonType.pdf: 'pdf',
  LessonType.reading: 'reading',
};

_Course _$CourseFromJson(Map<String, dynamic> json) => _Course(
  id: json['id'] as String,
  title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
  category: json['category'] as String,
  cover: $enumDecode(_$CourseCoverEnumMap, json['cover']),
  durationMin: (json['durationMin'] as num).toInt(),
  cpdCredits: (json['cpdCredits'] as num).toInt(),
  priceFils: (json['priceFils'] as num).toInt(),
  lessons: (json['lessons'] as List<dynamic>)
      .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CourseToJson(_Course instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title.toJson(),
  'category': instance.category,
  'cover': _$CourseCoverEnumMap[instance.cover]!,
  'durationMin': instance.durationMin,
  'cpdCredits': instance.cpdCredits,
  'priceFils': instance.priceFils,
  'lessons': instance.lessons.map((e) => e.toJson()).toList(),
};

const _$CourseCoverEnumMap = {
  CourseCover.bls: 'bls',
  CourseCover.ipc: 'ipc',
  CourseCover.medication: 'medication',
};

_LessonProgress _$LessonProgressFromJson(Map<String, dynamic> json) =>
    _LessonProgress(
      userId: json['userId'] as String,
      lessonId: json['lessonId'] as String,
      completedAt: const UtcDateTimeConverter().fromJson(
        json['completedAt'] as String,
      ),
    );

Map<String, dynamic> _$LessonProgressToJson(_LessonProgress instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'lessonId': instance.lessonId,
      'completedAt': const UtcDateTimeConverter().toJson(instance.completedAt),
    };
