// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's [GoRouter].
///
/// One `StatefulShellRoute.indexedStack` per role keeps each tab's back
/// stack. `/learn` belongs to both the learner and supervisor shells, so the
/// active role's shell is listed first (go_router matches in order); the
/// router is rebuilt when the role changes. Session changes re-run the
/// redirect: signed out → `/sign-in`; a route of another role → own home.

@ProviderFor(router)
final routerProvider = RouterProvider._();

/// The app's [GoRouter].
///
/// One `StatefulShellRoute.indexedStack` per role keeps each tab's back
/// stack. `/learn` belongs to both the learner and supervisor shells, so the
/// active role's shell is listed first (go_router matches in order); the
/// router is rebuilt when the role changes. Session changes re-run the
/// redirect: signed out → `/sign-in`; a route of another role → own home.

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// The app's [GoRouter].
  ///
  /// One `StatefulShellRoute.indexedStack` per role keeps each tab's back
  /// stack. `/learn` belongs to both the learner and supervisor shells, so the
  /// active role's shell is listed first (go_router matches in order); the
  /// router is rebuilt when the role changes. Session changes re-run the
  /// redirect: signed out → `/sign-in`; a route of another role → own home.
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'e2ca92d2dcf06f2142fd5f9ec2c4a58ff6c91ece';
