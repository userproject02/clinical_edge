// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The device notifier (overridden in `main.dart` and tests).

@ProviderFor(localNotifications)
final localNotificationsProvider = LocalNotificationsProvider._();

/// The device notifier (overridden in `main.dart` and tests).

final class LocalNotificationsProvider
    extends $FunctionalProvider<LocalNotifier, LocalNotifier, LocalNotifier>
    with $Provider<LocalNotifier> {
  /// The device notifier (overridden in `main.dart` and tests).
  LocalNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotificationsHash();

  @$internal
  @override
  $ProviderElement<LocalNotifier> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalNotifier create(Ref ref) {
    return localNotifications(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalNotifier>(value),
    );
  }
}

String _$localNotificationsHash() =>
    r'3d8d5af84282f10b9603267dd2d3238ff64a86b2';
