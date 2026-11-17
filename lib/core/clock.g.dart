// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Clock mode, persisted; switchable from the debug menu.

@ProviderFor(ClockModeNotifier)
final clockModeProvider = ClockModeNotifierProvider._();

/// Clock mode, persisted; switchable from the debug menu.
final class ClockModeNotifierProvider
    extends $NotifierProvider<ClockModeNotifier, ClockMode> {
  /// Clock mode, persisted; switchable from the debug menu.
  ClockModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockModeNotifierHash();

  @$internal
  @override
  ClockModeNotifier create() => ClockModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClockMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClockMode>(value),
    );
  }
}

String _$clockModeNotifierHash() => r'7b8d6acdec83264a8822e771c43c31e87357f30e';

/// Clock mode, persisted; switchable from the debug menu.

abstract class _$ClockModeNotifier extends $Notifier<ClockMode> {
  ClockMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ClockMode, ClockMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ClockMode, ClockMode>,
              ClockMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The app clock.

@ProviderFor(clock)
final clockProvider = ClockProvider._();

/// The app clock.

final class ClockProvider extends $FunctionalProvider<Clock, Clock, Clock>
    with $Provider<Clock> {
  /// The app clock.
  ClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockHash();

  @$internal
  @override
  $ProviderElement<Clock> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Clock create(Ref ref) {
    return clock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Clock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Clock>(value),
    );
  }
}

String _$clockHash() => r'6b02dd24f424ad2a4a3624f1e984866b29b50877';
