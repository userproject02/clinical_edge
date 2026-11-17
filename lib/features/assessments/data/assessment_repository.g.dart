// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The assessment repository.

@ProviderFor(assessmentRepository)
final assessmentRepositoryProvider = AssessmentRepositoryProvider._();

/// The assessment repository.

final class AssessmentRepositoryProvider
    extends
        $FunctionalProvider<
          AssessmentRepository,
          AssessmentRepository,
          AssessmentRepository
        >
    with $Provider<AssessmentRepository> {
  /// The assessment repository.
  AssessmentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assessmentRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assessmentRepositoryHash();

  @$internal
  @override
  $ProviderElement<AssessmentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssessmentRepository create(Ref ref) {
    return assessmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssessmentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssessmentRepository>(value),
    );
  }
}

String _$assessmentRepositoryHash() =>
    r'298fb8e13db594d1926aab2cf90b433646446ac3';
