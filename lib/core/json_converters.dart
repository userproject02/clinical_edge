import 'package:freezed_annotation/freezed_annotation.dart';

/// JSON converter for instants: ISO-8601 in UTC.
class UtcDateTimeConverter implements JsonConverter<DateTime, String> {
  /// Creates the converter.
  const new();

  @override
  DateTime fromJson(String json) => DateTime.parse(json).toUtc();

  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}

/// JSON converter for calendar dates (`yyyy-MM-dd`) as UTC midnight, so a
/// date never shifts with the device time zone.
class DateOnlyConverter implements JsonConverter<DateTime, String> {
  /// Creates the converter.
  const new();

  @override
  DateTime fromJson(String json) {
    final d = DateTime.parse(json);
    return DateTime.utc(d.year, d.month, d.day);
  }

  @override
  String toJson(DateTime object) =>
      '${object.year.toString().padLeft(4, '0')}-'
      '${object.month.toString().padLeft(2, '0')}-'
      '${object.day.toString().padLeft(2, '0')}';
}

/// Nullable variant of [UtcDateTimeConverter].
class NullableUtcDateTimeConverter
    implements JsonConverter<DateTime?, String?> {
  /// Creates the converter.
  const new();

  @override
  DateTime? fromJson(String? json) =>
      json == null ? null : DateTime.parse(json).toUtc();

  @override
  String? toJson(DateTime? object) => object?.toUtc().toIso8601String();
}

/// Nullable variant of [DateOnlyConverter].
class NullableDateOnlyConverter implements JsonConverter<DateTime?, String?> {
  /// Creates the converter.
  const new();

  @override
  DateTime? fromJson(String? json) =>
      json == null ? null : const DateOnlyConverter().fromJson(json);

  @override
  String? toJson(DateTime? object) =>
      object == null ? null : const DateOnlyConverter().toJson(object);
}
