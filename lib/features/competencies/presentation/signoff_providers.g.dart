// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signoff_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Users by id (names and initials on sign-off cards).

@ProviderFor(usersById)
final usersByIdProvider = UsersByIdProvider._();

/// Users by id (names and initials on sign-off cards).

final class UsersByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, AppUser>>,
          Map<String, AppUser>,
          FutureOr<Map<String, AppUser>>
        >
    with
        $FutureModifier<Map<String, AppUser>>,
        $FutureProvider<Map<String, AppUser>> {
  /// Users by id (names and initials on sign-off cards).
  UsersByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersByIdHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, AppUser>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, AppUser>> create(Ref ref) {
    return usersById(ref);
  }
}

String _$usersByIdHash() => r'097a899ac75219f3be9151f0b32151b935dba5c5';

/// The supervisor learners' requests go to (first seed supervisor).

@ProviderFor(signOffSupervisor)
final signOffSupervisorProvider = SignOffSupervisorProvider._();

/// The supervisor learners' requests go to (first seed supervisor).

final class SignOffSupervisorProvider
    extends
        $FunctionalProvider<AsyncValue<AppUser?>, AppUser?, FutureOr<AppUser?>>
    with $FutureModifier<AppUser?>, $FutureProvider<AppUser?> {
  /// The supervisor learners' requests go to (first seed supervisor).
  SignOffSupervisorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signOffSupervisorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signOffSupervisorHash();

  @$internal
  @override
  $FutureProviderElement<AppUser?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppUser?> create(Ref ref) {
    return signOffSupervisor(ref);
  }
}

String _$signOffSupervisorHash() => r'35f23eedb2c392e7b9528e2f817a3539dc09bcc8';

/// Checklists by id.

@ProviderFor(checklistsById)
final checklistsByIdProvider = ChecklistsByIdProvider._();

/// Checklists by id.

final class ChecklistsByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, CompetencyChecklist>>,
          Map<String, CompetencyChecklist>,
          FutureOr<Map<String, CompetencyChecklist>>
        >
    with
        $FutureModifier<Map<String, CompetencyChecklist>>,
        $FutureProvider<Map<String, CompetencyChecklist>> {
  /// Checklists by id.
  ChecklistsByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checklistsByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checklistsByIdHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, CompetencyChecklist>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, CompetencyChecklist>> create(Ref ref) {
    return checklistsById(ref);
  }
}

String _$checklistsByIdHash() => r'ed099a14dd967c56277ffd487c4c28bec6da207a';

/// Pending requests, oldest first (supervisor queue).

@ProviderFor(signOffQueue)
final signOffQueueProvider = SignOffQueueProvider._();

/// Pending requests, oldest first (supervisor queue).

final class SignOffQueueProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SignOffRequest>>,
          List<SignOffRequest>,
          FutureOr<List<SignOffRequest>>
        >
    with
        $FutureModifier<List<SignOffRequest>>,
        $FutureProvider<List<SignOffRequest>> {
  /// Pending requests, oldest first (supervisor queue).
  SignOffQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signOffQueueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signOffQueueHash();

  @$internal
  @override
  $FutureProviderElement<List<SignOffRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SignOffRequest>> create(Ref ref) {
    return signOffQueue(ref);
  }
}

String _$signOffQueueHash() => r'3f840097a2768c912c0a0eba1a60c283cf75abba';

/// Decided requests, newest decision first.

@ProviderFor(decidedSignOffs)
final decidedSignOffsProvider = DecidedSignOffsProvider._();

/// Decided requests, newest decision first.

final class DecidedSignOffsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SignOffRequest>>,
          List<SignOffRequest>,
          FutureOr<List<SignOffRequest>>
        >
    with
        $FutureModifier<List<SignOffRequest>>,
        $FutureProvider<List<SignOffRequest>> {
  /// Decided requests, newest decision first.
  DecidedSignOffsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'decidedSignOffsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$decidedSignOffsHash();

  @$internal
  @override
  $FutureProviderElement<List<SignOffRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SignOffRequest>> create(Ref ref) {
    return decidedSignOffs(ref);
  }
}

String _$decidedSignOffsHash() => r'a01e4979c1276a424c80e8dd100f6e0718964218';

/// One request.

@ProviderFor(signOffRequest)
final signOffRequestProvider = SignOffRequestFamily._();

/// One request.

final class SignOffRequestProvider
    extends
        $FunctionalProvider<
          AsyncValue<SignOffRequest?>,
          SignOffRequest?,
          FutureOr<SignOffRequest?>
        >
    with $FutureModifier<SignOffRequest?>, $FutureProvider<SignOffRequest?> {
  /// One request.
  SignOffRequestProvider._({
    required SignOffRequestFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'signOffRequestProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$signOffRequestHash();

  @override
  String toString() {
    return r'signOffRequestProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SignOffRequest?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SignOffRequest?> create(Ref ref) {
    final argument = this.argument as String;
    return signOffRequest(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SignOffRequestProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$signOffRequestHash() => r'25bdd8b341ba9a8c44a2cb599f17e364acc67795';

/// One request.

final class SignOffRequestFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SignOffRequest?>, String> {
  SignOffRequestFamily._()
    : super(
        retry: null,
        name: r'signOffRequestProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One request.

  SignOffRequestProvider call(String requestId) =>
      SignOffRequestProvider._(argument: requestId, from: this);

  @override
  String toString() => r'signOffRequestProvider';
}

/// Pending count, requests received this calendar month (Dubai) and the
/// mean request → decision time in days over decided requests.

@ProviderFor(queueStats)
final queueStatsProvider = QueueStatsProvider._();

/// Pending count, requests received this calendar month (Dubai) and the
/// mean request → decision time in days over decided requests.

final class QueueStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<QueueStats>,
          QueueStats,
          FutureOr<QueueStats>
        >
    with $FutureModifier<QueueStats>, $FutureProvider<QueueStats> {
  /// Pending count, requests received this calendar month (Dubai) and the
  /// mean request → decision time in days over decided requests.
  QueueStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'queueStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$queueStatsHash();

  @$internal
  @override
  $FutureProviderElement<QueueStats> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<QueueStats> create(Ref ref) {
    return queueStats(ref);
  }
}

String _$queueStatsHash() => r'e6042126fd8ff58d54f1a6287416758bbfd54086';

/// Requests sign-off for a checklist as the signed-in learner (COMP-1).

@ProviderFor(requestSignOff)
final requestSignOffProvider = RequestSignOffProvider._();

/// Requests sign-off for a checklist as the signed-in learner (COMP-1).

final class RequestSignOffProvider
    extends
        $FunctionalProvider<
          Future<SignOffRequest> Function(CompetencyChecklist checklist),
          Future<SignOffRequest> Function(CompetencyChecklist checklist),
          Future<SignOffRequest> Function(CompetencyChecklist checklist)
        >
    with
        $Provider<
          Future<SignOffRequest> Function(CompetencyChecklist checklist)
        > {
  /// Requests sign-off for a checklist as the signed-in learner (COMP-1).
  RequestSignOffProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestSignOffProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestSignOffHash();

  @$internal
  @override
  $ProviderElement<
    Future<SignOffRequest> Function(CompetencyChecklist checklist)
  >
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Future<SignOffRequest> Function(CompetencyChecklist checklist) create(
    Ref ref,
  ) {
    return requestSignOff(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Future<SignOffRequest> Function(CompetencyChecklist checklist) value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            Future<SignOffRequest> Function(CompetencyChecklist checklist)
          >(value),
    );
  }
}

String _$requestSignOffHash() => r'fbf0c180cf869e0f6c42bd572896ba67aa6110de';

/// Approves or rejects a request as the signed-in supervisor (COMP-2).
/// Throws `CommentRequiredException` for a reject without a comment.

@ProviderFor(decideSignOff)
final decideSignOffProvider = DecideSignOffProvider._();

/// Approves or rejects a request as the signed-in supervisor (COMP-2).
/// Throws `CommentRequiredException` for a reject without a comment.

final class DecideSignOffProvider
    extends
        $FunctionalProvider<
          Future<SignOffRequest> Function(
            SignOffRequest request, {
            required bool approve,
            required String comment,
          }),
          Future<SignOffRequest> Function(
            SignOffRequest request, {
            required bool approve,
            required String comment,
          }),
          Future<SignOffRequest> Function(
            SignOffRequest request, {
            required bool approve,
            required String comment,
          })
        >
    with
        $Provider<
          Future<SignOffRequest> Function(
            SignOffRequest request, {
            required bool approve,
            required String comment,
          })
        > {
  /// Approves or rejects a request as the signed-in supervisor (COMP-2).
  /// Throws `CommentRequiredException` for a reject without a comment.
  DecideSignOffProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'decideSignOffProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$decideSignOffHash();

  @$internal
  @override
  $ProviderElement<
    Future<SignOffRequest> Function(
      SignOffRequest request, {
      required bool approve,
      required String comment,
    })
  >
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Future<SignOffRequest> Function(
    SignOffRequest request, {
    required bool approve,
    required String comment,
  })
  create(Ref ref) {
    return decideSignOff(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Future<SignOffRequest> Function(
      SignOffRequest request, {
      required bool approve,
      required String comment,
    })
    value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            Future<SignOffRequest> Function(
              SignOffRequest request, {
              required bool approve,
              required String comment,
            })
          >(value),
    );
  }
}

String _$decideSignOffHash() => r'1eb699532d4a5fbbe401a3250d7f490543b03e77';
