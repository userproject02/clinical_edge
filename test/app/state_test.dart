import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/app/state/theme_mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container([
  Map<String, Object> values = const <String, Object>{},
]) async {
  SharedPreferences.setMockInitialValues(values);
  final prefs = await SharedPreferences.getInstance();
  final c = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );
  addTearDown(c.dispose);
  return c;
}

void main() {
  test('TC-PH1-35 theme mode defaults to system and persists', () async {
    final c = await _container();
    expect(c.read(themeModeProvider), ThemeMode.system);
    await c.read(themeModeProvider.notifier).set(ThemeMode.dark);
    expect(c.read(themeModeProvider), ThemeMode.dark);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(PrefKeys.themeMode), 'dark');
    final restarted = await _container(<String, Object>{
      PrefKeys.themeMode: 'dark',
    });
    expect(restarted.read(themeModeProvider), ThemeMode.dark);
  });

  test('TC-PH1-36 locale defaults to English, toggles and persists', () async {
    final c = await _container();
    expect(c.read(localeProvider), const Locale('en'));
    await c.read(localeProvider.notifier).toggle();
    expect(c.read(localeProvider), const Locale('ar'));
    final restarted = await _container(<String, Object>{PrefKeys.locale: 'ar'});
    expect(restarted.read(localeProvider), const Locale('ar'));
    final junk = await _container(<String, Object>{PrefKeys.locale: 'fr'});
    expect(junk.read(localeProvider), const Locale('en'));
  });
}
