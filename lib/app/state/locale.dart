import 'package:clinical_edge/app/state/preferences.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale.g.dart';

/// Locales the app ships. Arabic switches the whole app to RTL.
const List<Locale> supportedAppLocales = <Locale>[Locale('en'), Locale('ar')];

/// The app language (English or Arabic), persisted with shared_preferences.
@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    final saved = ref
        .watch(sharedPreferencesProvider)
        .getString(PrefKeys.locale);
    return supportedAppLocales.firstWhere(
      (l) => l.languageCode == saved,
      orElse: () => supportedAppLocales.first,
    );
  }

  /// Applies [locale] at once and saves it.
  Future<void> set(Locale locale) async {
    assert(
      supportedAppLocales.any((l) => l.languageCode == locale.languageCode),
      'Unsupported locale $locale',
    );
    state = Locale(locale.languageCode);
    await ref
        .read(sharedPreferencesProvider)
        .setString(PrefKeys.locale, locale.languageCode);
  }

  /// Switches between English and Arabic.
  Future<void> toggle() =>
      set(state.languageCode == 'ar' ? const Locale('en') : const Locale('ar'));
}
