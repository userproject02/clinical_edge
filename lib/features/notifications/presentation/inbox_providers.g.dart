// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifications for the signed-in role, most urgent first:
/// - learner: expired / expiring / verifying certificates, then sign-off
///   decisions (newest first);
/// - supervisor: pending sign-off requests (newest first);
/// - admin: cohort certificates in the renewal window (soonest first), then
///   sign-offs waiting for supervisors.

@ProviderFor(inbox)
final inboxProvider = InboxProvider._();

/// Notifications for the signed-in role, most urgent first:
/// - learner: expired / expiring / verifying certificates, then sign-off
///   decisions (newest first);
/// - supervisor: pending sign-off requests (newest first);
/// - admin: cohort certificates in the renewal window (soonest first), then
///   sign-offs waiting for supervisors.

final class InboxProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InboxItem>>,
          List<InboxItem>,
          FutureOr<List<InboxItem>>
        >
    with $FutureModifier<List<InboxItem>>, $FutureProvider<List<InboxItem>> {
  /// Notifications for the signed-in role, most urgent first:
  /// - learner: expired / expiring / verifying certificates, then sign-off
  ///   decisions (newest first);
  /// - supervisor: pending sign-off requests (newest first);
  /// - admin: cohort certificates in the renewal window (soonest first), then
  ///   sign-offs waiting for supervisors.
  InboxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inboxProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inboxHash();

  @$internal
  @override
  $FutureProviderElement<List<InboxItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<InboxItem>> create(Ref ref) {
    return inbox(ref);
  }
}

String _$inboxHash() => r'd382edca1a03e1006dc9f4f128e370c5236db7b7';

/// Ids of notifications already shown in the sheet (this app session).

@ProviderFor(InboxSeen)
final inboxSeenProvider = InboxSeenProvider._();

/// Ids of notifications already shown in the sheet (this app session).
final class InboxSeenProvider
    extends $NotifierProvider<InboxSeen, Set<String>> {
  /// Ids of notifications already shown in the sheet (this app session).
  InboxSeenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inboxSeenProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inboxSeenHash();

  @$internal
  @override
  InboxSeen create() => InboxSeen();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$inboxSeenHash() => r'b6cb0c585e665e4b347f523654f5ecd347eddaf9';

/// Ids of notifications already shown in the sheet (this app session).

abstract class _$InboxSeen extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Whether the bell shows its unread dot.

@ProviderFor(inboxUnread)
final inboxUnreadProvider = InboxUnreadProvider._();

/// Whether the bell shows its unread dot.

final class InboxUnreadProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Whether the bell shows its unread dot.
  InboxUnreadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inboxUnreadProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inboxUnreadHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return inboxUnread(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$inboxUnreadHash() => r'bff61cff368dd53bb6cdae0ad361b7863fa24620';
