import 'package:clinical_edge/core/json_converters.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/money.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

/// Lesson media type.
enum LessonType {
  /// Video player placeholder.
  video,

  /// PDF viewer placeholder.
  pdf,

  /// Reading (rich text) placeholder.
  reading,
}

/// Course cover colour token (see `AppColors.courseBls` etc.).
enum CourseCover {
  /// Basic Life Support teal.
  bls,

  /// Infection control blue.
  ipc,

  /// Medication safety amber.
  medication,
}

/// A catalogue category.
@freezed
abstract class CourseCategory with _$CourseCategory {
  /// Creates a category.
  const factory({required String id, required LocalizedText label}) =
      _CourseCategory;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CourseCategoryFromJson(json);
}

/// One lesson of a course.
@freezed
abstract class Lesson with _$Lesson {
  /// Creates a lesson.
  const factory({
    required String id,
    required int order,
    required LocalizedText title,
    required LessonType type,
    required int minutes,
    required String assetRef,
  }) = _Lesson;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$LessonFromJson(json);
}

/// A course. Prices in integer fils.
@freezed
abstract class Course with _$Course {
  /// Creates a course.
  const factory({
    required String id,
    required LocalizedText title,
    required LocalizedText blurb,
    required String category,
    required CourseCover cover,
    required int durationMin,
    required int cpdCredits,
    required int priceFils,
    required List<Lesson> lessons,
  }) = _Course;

  const new _();

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CourseFromJson(json);

  /// Price before VAT.
  Money get price => Money(priceFils);
}

/// A completed lesson.
@freezed
abstract class LessonProgress with _$LessonProgress {
  /// Creates a record.
  const factory({
    required String userId,
    required String lessonId,
    @UtcDateTimeConverter() required DateTime completedAt,
  }) = _LessonProgress;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$LessonProgressFromJson(json);
}
