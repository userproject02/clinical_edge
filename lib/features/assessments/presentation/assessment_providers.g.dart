// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Assess tab content: every quiz with lock state and history.
///
/// The first quiz (BLS) is always open; later quizzes unlock when their
/// course is complete.

@ProviderFor(quizCards)
final quizCardsProvider = QuizCardsProvider._();

/// Assess tab content: every quiz with lock state and history.
///
/// The first quiz (BLS) is always open; later quizzes unlock when their
/// course is complete.

final class QuizCardsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<QuizCardData>>,
          List<QuizCardData>,
          FutureOr<List<QuizCardData>>
        >
    with
        $FutureModifier<List<QuizCardData>>,
        $FutureProvider<List<QuizCardData>> {
  /// Assess tab content: every quiz with lock state and history.
  ///
  /// The first quiz (BLS) is always open; later quizzes unlock when their
  /// course is complete.
  QuizCardsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizCardsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quizCardsHash();

  @$internal
  @override
  $FutureProviderElement<List<QuizCardData>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<QuizCardData>> create(Ref ref) {
    return quizCards(ref);
  }
}

String _$quizCardsHash() => r'9e9b620697a27c43ac5f9cbe6a336400f2cd825e';

/// Attempt id source (overridable in tests).

@ProviderFor(attemptIdFactory)
final attemptIdFactoryProvider = AttemptIdFactoryProvider._();

/// Attempt id source (overridable in tests).

final class AttemptIdFactoryProvider
    extends
        $FunctionalProvider<
          String Function(),
          String Function(),
          String Function()
        >
    with $Provider<String Function()> {
  /// Attempt id source (overridable in tests).
  AttemptIdFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attemptIdFactoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attemptIdFactoryHash();

  @$internal
  @override
  $ProviderElement<String Function()> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  String Function() create(Ref ref) {
    return attemptIdFactory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String Function()>(value),
    );
  }
}

String _$attemptIdFactoryHash() => r'4db97728c0f9410a6faaeb5cf479b0783131b0cd';

/// One quiz run: answer, next, submit, retake.

@ProviderFor(QuizRun)
final quizRunProvider = QuizRunFamily._();

/// One quiz run: answer, next, submit, retake.
final class QuizRunProvider
    extends $AsyncNotifierProvider<QuizRun, QuizSession> {
  /// One quiz run: answer, next, submit, retake.
  QuizRunProvider._({
    required QuizRunFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'quizRunProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quizRunHash();

  @override
  String toString() {
    return r'quizRunProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  QuizRun create() => QuizRun();

  @override
  bool operator ==(Object other) {
    return other is QuizRunProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quizRunHash() => r'bd037b3a478813a8cbb4599f6828ff9466d64d46';

/// One quiz run: answer, next, submit, retake.

final class QuizRunFamily extends $Family
    with
        $ClassFamilyOverride<
          QuizRun,
          AsyncValue<QuizSession>,
          QuizSession,
          FutureOr<QuizSession>,
          String
        > {
  QuizRunFamily._()
    : super(
        retry: null,
        name: r'quizRunProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One quiz run: answer, next, submit, retake.

  QuizRunProvider call(String quizId) =>
      QuizRunProvider._(argument: quizId, from: this);

  @override
  String toString() => r'quizRunProvider';
}

/// One quiz run: answer, next, submit, retake.

abstract class _$QuizRun extends $AsyncNotifier<QuizSession> {
  late final _$args = ref.$arg as String;
  String get quizId => _$args;

  FutureOr<QuizSession> build(String quizId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<QuizSession>, QuizSession>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<QuizSession>, QuizSession>,
              AsyncValue<QuizSession>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
