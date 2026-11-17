// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_seeder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The demo seeder (shared by every mock repository).

@ProviderFor(demoSeeder)
final demoSeederProvider = DemoSeederProvider._();

/// The demo seeder (shared by every mock repository).

final class DemoSeederProvider
    extends $FunctionalProvider<DemoSeeder, DemoSeeder, DemoSeeder>
    with $Provider<DemoSeeder> {
  /// The demo seeder (shared by every mock repository).
  DemoSeederProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'demoSeederProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$demoSeederHash();

  @$internal
  @override
  $ProviderElement<DemoSeeder> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DemoSeeder create(Ref ref) {
    return demoSeeder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DemoSeeder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DemoSeeder>(value),
    );
  }
}

String _$demoSeederHash() => r'b1f6267d9ded2a3ac6cd7b73e8ee5a3496303225';
