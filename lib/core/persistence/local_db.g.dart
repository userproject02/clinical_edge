// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_db.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's [LocalDb]. Overridden in `main.dart` (Hive) and tests
/// (in memory).

@ProviderFor(localDb)
final localDbProvider = LocalDbProvider._();

/// The app's [LocalDb]. Overridden in `main.dart` (Hive) and tests
/// (in memory).

final class LocalDbProvider
    extends $FunctionalProvider<LocalDb, LocalDb, LocalDb>
    with $Provider<LocalDb> {
  /// The app's [LocalDb]. Overridden in `main.dart` (Hive) and tests
  /// (in memory).
  LocalDbProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localDbProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localDbHash();

  @$internal
  @override
  $ProviderElement<LocalDb> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalDb create(Ref ref) {
    return localDb(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalDb value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalDb>(value),
    );
  }
}

String _$localDbHash() => r'e7d001ef7158edffa19439600dca01239f8d3036';
