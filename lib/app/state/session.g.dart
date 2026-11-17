// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the stub [Session]. Not persisted: the app starts signed out.

@ProviderFor(SessionNotifier)
final sessionProvider = SessionNotifierProvider._();

/// Holds the stub [Session]. Not persisted: the app starts signed out.
final class SessionNotifierProvider
    extends $NotifierProvider<SessionNotifier, Session> {
  /// Holds the stub [Session]. Not persisted: the app starts signed out.
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Session value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Session>(value),
    );
  }
}

String _$sessionNotifierHash() => r'f91049a51ed22fc6295e8937b797ed3f1ca29fc3';

/// Holds the stub [Session]. Not persisted: the app starts signed out.

abstract class _$SessionNotifier extends $Notifier<Session> {
  Session build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Session, Session>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Session, Session>,
              Session,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
