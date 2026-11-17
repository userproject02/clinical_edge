// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_logger.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Who is acting, read when an event is logged. Phase 1's session stub
/// provides it until Phase 3's auth feature (see mock overrides).

@ProviderFor(currentActor)
final currentActorProvider = CurrentActorProvider._();

/// Who is acting, read when an event is logged. Phase 1's session stub
/// provides it until Phase 3's auth feature (see mock overrides).

final class CurrentActorProvider
    extends
        $FunctionalProvider<
          Actor Function(),
          Actor Function(),
          Actor Function()
        >
    with $Provider<Actor Function()> {
  /// Who is acting, read when an event is logged. Phase 1's session stub
  /// provides it until Phase 3's auth feature (see mock overrides).
  CurrentActorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentActorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentActorHash();

  @$internal
  @override
  $ProviderElement<Actor Function()> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Actor Function() create(Ref ref) {
    return currentActor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Actor Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Actor Function()>(value),
    );
  }
}

String _$currentActorHash() => r'b79f32c11cb691b28b9a00b980b3a592c58efb08';

/// The app's activity logger.

@ProviderFor(activityLogger)
final activityLoggerProvider = ActivityLoggerProvider._();

/// The app's activity logger.

final class ActivityLoggerProvider
    extends $FunctionalProvider<ActivityLogger, ActivityLogger, ActivityLogger>
    with $Provider<ActivityLogger> {
  /// The app's activity logger.
  ActivityLoggerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityLoggerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityLoggerHash();

  @$internal
  @override
  $ProviderElement<ActivityLogger> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ActivityLogger create(Ref ref) {
    return activityLogger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActivityLogger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActivityLogger>(value),
    );
  }
}

String _$activityLoggerHash() => r'0a271b7f232c98df1bb56561206ab03f01bc79cf';
