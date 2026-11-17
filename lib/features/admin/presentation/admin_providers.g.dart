// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Cohort aggregates (demo figures).

@ProviderFor(cohortStats)
final cohortStatsProvider = CohortStatsProvider._();

/// Cohort aggregates (demo figures).

final class CohortStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<CohortStats>,
          CohortStats,
          FutureOr<CohortStats>
        >
    with $FutureModifier<CohortStats>, $FutureProvider<CohortStats> {
  /// Cohort aggregates (demo figures).
  CohortStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cohortStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cohortStatsHash();

  @$internal
  @override
  $FutureProviderElement<CohortStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CohortStats> create(Ref ref) {
    return cohortStats(ref);
  }
}

String _$cohortStatsHash() => r'0d77c00016bf9e1ac87524044fa59aca79ca3346';

/// Cohort learners. The demo learner (Layla) uses live progress and her
/// live soonest certificate; others use seed demo figures.

@ProviderFor(cohortLearners)
final cohortLearnersProvider = CohortLearnersProvider._();

/// Cohort learners. The demo learner (Layla) uses live progress and her
/// live soonest certificate; others use seed demo figures.

final class CohortLearnersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LearnerRow>>,
          List<LearnerRow>,
          FutureOr<List<LearnerRow>>
        >
    with $FutureModifier<List<LearnerRow>>, $FutureProvider<List<LearnerRow>> {
  /// Cohort learners. The demo learner (Layla) uses live progress and her
  /// live soonest certificate; others use seed demo figures.
  CohortLearnersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cohortLearnersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cohortLearnersHash();

  @$internal
  @override
  $FutureProviderElement<List<LearnerRow>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LearnerRow>> create(Ref ref) {
    return cohortLearners(ref);
  }
}

String _$cohortLearnersHash() => r'14b824b70e8a9bdd533ef9f2e0cc066feaf865c8';

/// Audit events in chain order (oldest first).

@ProviderFor(auditEvents)
final auditEventsProvider = AuditEventsProvider._();

/// Audit events in chain order (oldest first).

final class AuditEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityEvent>>,
          List<ActivityEvent>,
          FutureOr<List<ActivityEvent>>
        >
    with
        $FutureModifier<List<ActivityEvent>>,
        $FutureProvider<List<ActivityEvent>> {
  /// Audit events in chain order (oldest first).
  AuditEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityEvent>> create(Ref ref) {
    return auditEvents(ref);
  }
}

String _$auditEventsHash() => r'76ea1558e44e7a66109b31bb6912b84330d215b7';

/// Usage events.

@ProviderFor(usageEvents)
final usageEventsProvider = UsageEventsProvider._();

/// Usage events.

final class UsageEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityEvent>>,
          List<ActivityEvent>,
          FutureOr<List<ActivityEvent>>
        >
    with
        $FutureModifier<List<ActivityEvent>>,
        $FutureProvider<List<ActivityEvent>> {
  /// Usage events.
  UsageEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usageEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usageEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityEvent>> create(Ref ref) {
    return usageEvents(ref);
  }
}

String _$usageEventsHash() => r'349292dd6d35e15a07477eb292406a5d68fb22f6';

/// Chain verification of the audit store.

@ProviderFor(chainResult)
final chainResultProvider = ChainResultProvider._();

/// Chain verification of the audit store.

final class ChainResultProvider
    extends
        $FunctionalProvider<
          AsyncValue<ChainResult>,
          ChainResult,
          FutureOr<ChainResult>
        >
    with $FutureModifier<ChainResult>, $FutureProvider<ChainResult> {
  /// Chain verification of the audit store.
  ChainResultProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chainResultProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chainResultHash();

  @$internal
  @override
  $FutureProviderElement<ChainResult> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ChainResult> create(Ref ref) {
    return chainResult(ref);
  }
}

String _$chainResultHash() => r'228d0829d53bd0dba7a7a0571e6bb6e50fd58fdc';

/// Current audit-log filters.

@ProviderFor(AuditFilterState)
final auditFilterStateProvider = AuditFilterStateProvider._();

/// Current audit-log filters.
final class AuditFilterStateProvider
    extends $NotifierProvider<AuditFilterState, AuditFilter> {
  /// Current audit-log filters.
  AuditFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditFilterStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditFilterStateHash();

  @$internal
  @override
  AuditFilterState create() => AuditFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuditFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuditFilter>(value),
    );
  }
}

String _$auditFilterStateHash() => r'd3b634196cd3bc6f443aeff67befe068ae798386';

/// Current audit-log filters.

abstract class _$AuditFilterState extends $Notifier<AuditFilter> {
  AuditFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AuditFilter, AuditFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuditFilter, AuditFilter>,
              AuditFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Audit + usage events after the filters, newest first.

@ProviderFor(filteredEvents)
final filteredEventsProvider = FilteredEventsProvider._();

/// Audit + usage events after the filters, newest first.

final class FilteredEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityEvent>>,
          List<ActivityEvent>,
          FutureOr<List<ActivityEvent>>
        >
    with
        $FutureModifier<List<ActivityEvent>>,
        $FutureProvider<List<ActivityEvent>> {
  /// Audit + usage events after the filters, newest first.
  FilteredEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityEvent>> create(Ref ref) {
    return filteredEvents(ref);
  }
}

String _$filteredEventsHash() => r'abec5c53781d7c8f4cee8c232505bb81b79c9d88';

/// Options for the User and Action dropdowns, built from the data.

@ProviderFor(auditFilterOptions)
final auditFilterOptionsProvider = AuditFilterOptionsProvider._();

/// Options for the User and Action dropdowns, built from the data.

final class AuditFilterOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<({List<String> actions, List<String> users})>,
          ({List<String> actions, List<String> users}),
          FutureOr<({List<String> actions, List<String> users})>
        >
    with
        $FutureModifier<({List<String> actions, List<String> users})>,
        $FutureProvider<({List<String> actions, List<String> users})> {
  /// Options for the User and Action dropdowns, built from the data.
  AuditFilterOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditFilterOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditFilterOptionsHash();

  @$internal
  @override
  $FutureProviderElement<({List<String> actions, List<String> users})>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<({List<String> actions, List<String> users})> create(Ref ref) {
    return auditFilterOptions(ref);
  }
}

String _$auditFilterOptionsHash() =>
    r'a065574b1a73ea5f14215f888b1f2c6d85e645f5';

/// Exports [events] as CSV through the share sheet and writes
/// `audit.export` ("CSV · N rows"). Returns the row count.

@ProviderFor(exportAuditCsv)
final exportAuditCsvProvider = ExportAuditCsvProvider._();

/// Exports [events] as CSV through the share sheet and writes
/// `audit.export` ("CSV · N rows"). Returns the row count.

final class ExportAuditCsvProvider
    extends
        $FunctionalProvider<
          Future<int> Function(List<ActivityEvent> events, {Rect? origin}),
          Future<int> Function(List<ActivityEvent> events, {Rect? origin}),
          Future<int> Function(List<ActivityEvent> events, {Rect? origin})
        >
    with
        $Provider<
          Future<int> Function(List<ActivityEvent> events, {Rect? origin})
        > {
  /// Exports [events] as CSV through the share sheet and writes
  /// `audit.export` ("CSV · N rows"). Returns the row count.
  ExportAuditCsvProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exportAuditCsvProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exportAuditCsvHash();

  @$internal
  @override
  $ProviderElement<
    Future<int> Function(List<ActivityEvent> events, {Rect? origin})
  >
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Future<int> Function(List<ActivityEvent> events, {Rect? origin}) create(
    Ref ref,
  ) {
    return exportAuditCsv(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Future<int> Function(List<ActivityEvent> events, {Rect? origin}) value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            Future<int> Function(List<ActivityEvent> events, {Rect? origin})
          >(value),
    );
  }
}

String _$exportAuditCsvHash() => r'91b888e2a8b941e2ffe46d01934ad772a954dbcc';

/// Usage insights from usage events and seed aggregates only (ADM-4).

@ProviderFor(insights)
final insightsProvider = InsightsProvider._();

/// Usage insights from usage events and seed aggregates only (ADM-4).

final class InsightsProvider
    extends
        $FunctionalProvider<
          AsyncValue<InsightsView>,
          InsightsView,
          FutureOr<InsightsView>
        >
    with $FutureModifier<InsightsView>, $FutureProvider<InsightsView> {
  /// Usage insights from usage events and seed aggregates only (ADM-4).
  InsightsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'insightsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$insightsHash();

  @$internal
  @override
  $FutureProviderElement<InsightsView> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<InsightsView> create(Ref ref) {
    return insights(ref);
  }
}

String _$insightsHash() => r'62f8bfcce52c9eb97cf63e42b92c56c649d92d18';
