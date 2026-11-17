// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "Push notifications" setting (expiry reminders and sign-off decisions),
/// persisted (SET-1). Defaults to on.

@ProviderFor(NotificationsEnabled)
final notificationsEnabledProvider = NotificationsEnabledProvider._();

/// "Push notifications" setting (expiry reminders and sign-off decisions),
/// persisted (SET-1). Defaults to on.
final class NotificationsEnabledProvider
    extends $NotifierProvider<NotificationsEnabled, bool> {
  /// "Push notifications" setting (expiry reminders and sign-off decisions),
  /// persisted (SET-1). Defaults to on.
  NotificationsEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsEnabledHash();

  @$internal
  @override
  NotificationsEnabled create() => NotificationsEnabled();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$notificationsEnabledHash() =>
    r'ec67679b14577b4483e38302ea3f69907832570a';

/// "Push notifications" setting (expiry reminders and sign-off decisions),
/// persisted (SET-1). Defaults to on.

abstract class _$NotificationsEnabled extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
