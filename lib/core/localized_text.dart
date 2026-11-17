import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart'
    show BuildContext, Locale, Localizations;

part 'localized_text.freezed.dart';
part 'localized_text.g.dart';

/// A user-facing string from seed data, in English and Arabic.
@freezed
abstract class LocalizedText with _$LocalizedText {
  /// Creates the pair.
  const factory({required String en, required String ar}) = _LocalizedText;

  const new _();

  /// Decodes `{"en": …, "ar": …}`.
  factory fromJson(Map<String, Object?> json) => _$LocalizedTextFromJson(json);

  /// The text for [locale] (Arabic for `ar`, English otherwise).
  String forLocale(Locale locale) => locale.languageCode == 'ar' ? ar : en;

  /// The text for the current app locale.
  String of(BuildContext context) => forLocale(Localizations.localeOf(context));
}
