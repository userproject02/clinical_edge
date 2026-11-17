import 'package:clinical_edge/app/state/preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications.g.dart';

/// "Push notifications" setting (expiry reminders and sign-off decisions),
/// persisted (SET-1). Defaults to on.
@Riverpod(keepAlive: true)
class NotificationsEnabled extends _$NotificationsEnabled {
  @override
  bool build() =>
      ref.watch(sharedPreferencesProvider).getBool(PrefKeys.notifications) ??
      true;

  /// Applies and saves.
  Future<void> set({required bool enabled}) async {
    state = enabled;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(PrefKeys.notifications, enabled);
  }
}
