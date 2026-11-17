// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competency_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The competency repository.

@ProviderFor(competencyRepository)
final competencyRepositoryProvider = CompetencyRepositoryProvider._();

/// The competency repository.

final class CompetencyRepositoryProvider
    extends
        $FunctionalProvider<
          CompetencyRepository,
          CompetencyRepository,
          CompetencyRepository
        >
    with $Provider<CompetencyRepository> {
  /// The competency repository.
  CompetencyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'competencyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$competencyRepositoryHash();

  @$internal
  @override
  $ProviderElement<CompetencyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompetencyRepository create(Ref ref) {
    return competencyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompetencyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompetencyRepository>(value),
    );
  }
}

String _$competencyRepositoryHash() =>
    r'd53a0bafe8faf1b7c81ae425fcfaddd2458f425a';
