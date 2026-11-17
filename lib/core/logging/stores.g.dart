// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The audit store (overridden with [LocalAuditStore] in mock overrides).

@ProviderFor(auditStore)
final auditStoreProvider = AuditStoreProvider._();

/// The audit store (overridden with [LocalAuditStore] in mock overrides).

final class AuditStoreProvider
    extends $FunctionalProvider<AuditStore, AuditStore, AuditStore>
    with $Provider<AuditStore> {
  /// The audit store (overridden with [LocalAuditStore] in mock overrides).
  AuditStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditStoreHash();

  @$internal
  @override
  $ProviderElement<AuditStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuditStore create(Ref ref) {
    return auditStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuditStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuditStore>(value),
    );
  }
}

String _$auditStoreHash() => r'16756c31de2483a17d5cc182fc5b65528c3280ca';

/// The usage store.

@ProviderFor(usageStore)
final usageStoreProvider = UsageStoreProvider._();

/// The usage store.

final class UsageStoreProvider
    extends $FunctionalProvider<UsageStore, UsageStore, UsageStore>
    with $Provider<UsageStore> {
  /// The usage store.
  UsageStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usageStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usageStoreHash();

  @$internal
  @override
  $ProviderElement<UsageStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UsageStore create(Ref ref) {
    return usageStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UsageStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UsageStore>(value),
    );
  }
}

String _$usageStoreHash() => r'0db0bc04b2c4a188ef6abe8af4a03e2cd9eb4083';
