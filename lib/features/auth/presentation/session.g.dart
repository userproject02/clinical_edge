// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The session: null when signed out. Persisted by [AuthRepository], so a
/// restart keeps the user signed in. The router redirect reads it.

@ProviderFor(SessionNotifier)
final sessionProvider = SessionNotifierProvider._();

/// The session: null when signed out. Persisted by [AuthRepository], so a
/// restart keeps the user signed in. The router redirect reads it.
final class SessionNotifierProvider
    extends $AsyncNotifierProvider<SessionNotifier, Session?> {
  /// The session: null when signed out. Persisted by [AuthRepository], so a
  /// restart keeps the user signed in. The router redirect reads it.
  SessionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionNotifierHash();

  @$internal
  @override
  SessionNotifier create() => SessionNotifier();
}

String _$sessionNotifierHash() => r'be3beacd79b140dae7b47313d9497cfa623cd735';

/// The session: null when signed out. Persisted by [AuthRepository], so a
/// restart keeps the user signed in. The router redirect reads it.

abstract class _$SessionNotifier extends $AsyncNotifier<Session?> {
  FutureOr<Session?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Session?>, Session?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Session?>, Session?>,
              AsyncValue<Session?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// True between sign-in and the end of the first home load's skeleton.

@ProviderFor(FirstHomeLoad)
final firstHomeLoadProvider = FirstHomeLoadProvider._();

/// True between sign-in and the end of the first home load's skeleton.
final class FirstHomeLoadProvider
    extends $NotifierProvider<FirstHomeLoad, bool> {
  /// True between sign-in and the end of the first home load's skeleton.
  FirstHomeLoadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firstHomeLoadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firstHomeLoadHash();

  @$internal
  @override
  FirstHomeLoad create() => FirstHomeLoad();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$firstHomeLoadHash() => r'2f057a1a1fe245682d8806c0df74c388a4f1b4f4';

/// True between sign-in and the end of the first home load's skeleton.

abstract class _$FirstHomeLoad extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Where the router should land after it is rebuilt for a role switch
/// (e.g. stay on `/profile`). Consumed once.

@ProviderFor(ResumeLocation)
final resumeLocationProvider = ResumeLocationProvider._();

/// Where the router should land after it is rebuilt for a role switch
/// (e.g. stay on `/profile`). Consumed once.
final class ResumeLocationProvider
    extends $NotifierProvider<ResumeLocation, String?> {
  /// Where the router should land after it is rebuilt for a role switch
  /// (e.g. stay on `/profile`). Consumed once.
  ResumeLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeLocationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeLocationHash();

  @$internal
  @override
  ResumeLocation create() => ResumeLocation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$resumeLocationHash() => r'3b60583efa14bf648cf52e08a5a51bffffc15f46';

/// Where the router should land after it is rebuilt for a role switch
/// (e.g. stay on `/profile`). Consumed once.

abstract class _$ResumeLocation extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The demo account for each role (sign-in pre-fills its email).

@ProviderFor(demoAccounts)
final demoAccountsProvider = DemoAccountsProvider._();

/// The demo account for each role (sign-in pre-fills its email).

final class DemoAccountsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<Role, AppUser>>,
          Map<Role, AppUser>,
          FutureOr<Map<Role, AppUser>>
        >
    with
        $FutureModifier<Map<Role, AppUser>>,
        $FutureProvider<Map<Role, AppUser>> {
  /// The demo account for each role (sign-in pre-fills its email).
  DemoAccountsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'demoAccountsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$demoAccountsHash();

  @$internal
  @override
  $FutureProviderElement<Map<Role, AppUser>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<Role, AppUser>> create(Ref ref) {
    return demoAccounts(ref);
  }
}

String _$demoAccountsHash() => r'a9ff954cb643dc7dc4cb4cbdcad70eb495e0788e';

/// Organisation name shown under the user on Profile and as the tab app
/// bar subtitle.

@ProviderFor(tenant)
final tenantProvider = TenantProvider._();

/// Organisation name shown under the user on Profile and as the tab app
/// bar subtitle.

final class TenantProvider
    extends
        $FunctionalProvider<
          AsyncValue<LocalizedText>,
          LocalizedText,
          FutureOr<LocalizedText>
        >
    with $FutureModifier<LocalizedText>, $FutureProvider<LocalizedText> {
  /// Organisation name shown under the user on Profile and as the tab app
  /// bar subtitle.
  TenantProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tenantProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tenantHash();

  @$internal
  @override
  $FutureProviderElement<LocalizedText> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LocalizedText> create(Ref ref) {
    return tenant(ref);
  }
}

String _$tenantHash() => r'b219dc9d099a0a0a22573afca930b0e41c578765';
