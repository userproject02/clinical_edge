import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences.g.dart';

/// Keys used in [SharedPreferences]. Changing a key loses saved settings.
abstract final class PrefKeys {
  /// Theme mode: `system`, `light` or `dark`.
  static const String themeMode = 'settings.themeMode';

  /// Language code: `en` or `ar`.
  static const String locale = 'settings.locale';
}

/// The app's [SharedPreferences] instance.
///
/// It is loaded once in `main()` and injected with a `ProviderScope`
/// override, so reads are synchronous everywhere else.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main() and in tests.',
  );
}
