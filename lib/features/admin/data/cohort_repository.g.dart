// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cohort_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The cohort repository.

@ProviderFor(cohortRepository)
final cohortRepositoryProvider = CohortRepositoryProvider._();

/// The cohort repository.

final class CohortRepositoryProvider
    extends
        $FunctionalProvider<
          CohortRepository,
          CohortRepository,
          CohortRepository
        >
    with $Provider<CohortRepository> {
  /// The cohort repository.
  CohortRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cohortRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cohortRepositoryHash();

  @$internal
  @override
  $ProviderElement<CohortRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CohortRepository create(Ref ref) {
    return cohortRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CohortRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CohortRepository>(value),
    );
  }
}

String _$cohortRepositoryHash() => r'865c90c7064ed8e4d9664f84a129803420ff7754';
