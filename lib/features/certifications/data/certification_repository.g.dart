// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The certification repository.

@ProviderFor(certificationRepository)
final certificationRepositoryProvider = CertificationRepositoryProvider._();

/// The certification repository.

final class CertificationRepositoryProvider
    extends
        $FunctionalProvider<
          CertificationRepository,
          CertificationRepository,
          CertificationRepository
        >
    with $Provider<CertificationRepository> {
  /// The certification repository.
  CertificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'certificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$certificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<CertificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CertificationRepository create(Ref ref) {
    return certificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CertificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CertificationRepository>(value),
    );
  }
}

String _$certificationRepositoryHash() =>
    r'f936d1618a750e4a664161bec95127af9574700c';

/// The CPD repository.

@ProviderFor(cpdRepository)
final cpdRepositoryProvider = CpdRepositoryProvider._();

/// The CPD repository.

final class CpdRepositoryProvider
    extends $FunctionalProvider<CpdRepository, CpdRepository, CpdRepository>
    with $Provider<CpdRepository> {
  /// The CPD repository.
  CpdRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cpdRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cpdRepositoryHash();

  @$internal
  @override
  $ProviderElement<CpdRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CpdRepository create(Ref ref) {
    return cpdRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CpdRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CpdRepository>(value),
    );
  }
}

String _$cpdRepositoryHash() => r'69503c712bf7bfb7d7e4b70ecbd12a11696261a6';
