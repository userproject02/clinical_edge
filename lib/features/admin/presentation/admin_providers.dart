import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' show Rect;

import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_event.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/logging/audit_chain.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/sharing/file_sharer.dart';
import 'package:clinical_edge/features/admin/data/cohort_repository.dart';
import 'package:clinical_edge/features/admin/domain/audit_log.dart';
import 'package:clinical_edge/features/admin/domain/cohort.dart';
import 'package:clinical_edge/features/admin/domain/insights.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/features/certifications/data/certification_repository.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_providers.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:clinical_edge/features/courses/domain/course_progress.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_providers.g.dart';

/// Cohort aggregates (demo figures).
@riverpod
Future<CohortStats> cohortStats(Ref ref) =>
    ref.watch(cohortRepositoryProvider).stats();

/// One row of the cohort learner list.
typedef LearnerRow = ({
  AppUser user,
  int pct,
  bool live,
  String? expiryCode,
  int? expiryDays,
});

/// Live overall progress of [userId] (owned courses, done lessons).
Future<int> _livePct(Ref ref, String userId) async {
  final courses = await ref.watch(catalogueProvider.future);
  final owned = await ref
      .watch(courseRepositoryProvider)
      .ownedCourseIds(userId);
  final done = {
    for (final p in await ref.watch(progressRepositoryProvider).forUser(userId))
      p.lessonId,
  };
  return LearnerOverview(<CourseProgress>[
    for (final c in courses)
      if (owned.contains(c.id))
        CourseProgress(course: c, owned: true, doneLessonIds: done),
  ]).pct;
}

/// Cohort learners. The demo learner (Layla) uses live progress and her
/// live soonest certificate; others use seed demo figures.
@riverpod
Future<List<LearnerRow>> cohortLearners(Ref ref) async {
  final stats = await ref.watch(cohortStatsProvider.future);
  final users = await ref.watch(usersByIdProvider.future);
  final clock = ref.watch(clockProvider);
  final rows = <LearnerRow>[];
  for (final l in stats.learners) {
    final user = users[l.userId];
    if (user == null) continue;
    if (l.userId == SeedUsers.learner) {
      final certs = await ref
          .watch(certificationRepositoryProvider)
          .list(l.userId);
      final next = certs
          .where((c) => c.verification == Verification.verified)
          .where((c) => c.daysLeft(clock) > 0)
          .firstOrNull;
      rows.add((
        user: user,
        pct: await _livePct(ref, l.userId),
        live: true,
        expiryCode: next?.code,
        expiryDays: next?.daysLeft(clock),
      ));
    } else {
      rows.add((
        user: user,
        pct: l.completionPct,
        live: false,
        expiryCode: l.nextExpiryCode,
        expiryDays: l.nextExpiryDays,
      ));
    }
  }
  return rows;
}

/// Audit events in chain order (oldest first).
@riverpod
Future<List<ActivityEvent>> auditEvents(Ref ref) =>
    ref.watch(auditStoreProvider).list();

/// Usage events.
@riverpod
Future<List<ActivityEvent>> usageEvents(Ref ref) =>
    ref.watch(usageStoreProvider).list();

/// Chain verification of the audit store.
@riverpod
Future<ChainResult> chainResult(Ref ref) async =>
    AuditChain.verify(await ref.watch(auditEventsProvider.future));

/// Current audit-log filters.
@riverpod
class AuditFilterState extends _$AuditFilterState {
  @override
  AuditFilter build() => const AuditFilter();

  /// Replaces the filter.
  // ignore: use_setters_to_change_properties
  void set(AuditFilter filter) => state = filter;
}

/// Audit + usage events after the filters, newest first.
@riverpod
Future<List<ActivityEvent>> filteredEvents(Ref ref) async {
  final all = <ActivityEvent>[
    ...await ref.watch(auditEventsProvider.future),
    ...await ref.watch(usageEventsProvider.future),
  ];
  return ref
      .watch(auditFilterStateProvider)
      .apply(all, ref.watch(clockProvider));
}

/// Options for the User and Action dropdowns, built from the data.
@riverpod
Future<({List<String> users, List<String> actions})> auditFilterOptions(
  Ref ref,
) async {
  final all = <ActivityEvent>[
    ...await ref.watch(auditEventsProvider.future),
    ...await ref.watch(usageEventsProvider.future),
  ];
  return (
    users: (all.map((e) => e.userId).toSet().toList()..sort()),
    actions: (all.map((e) => e.action).toSet().toList()..sort()),
  );
}

/// Exports events as CSV through the share sheet and writes
/// `audit.export` ("CSV · N rows"). Returns the row count.
@Riverpod(keepAlive: true)
Future<int> Function(List<ActivityEvent> events, {Rect? origin}) exportAuditCsv(
  Ref ref,
) => (events, {origin}) async {
  final csv = auditCsv(events);
  final today = ref.read(clockProvider).today();
  final date =
      '${today.year}-${today.month.toString().padLeft(2, '0')}-'
      '${today.day.toString().padLeft(2, '0')}';
  await ref
      .read(fileSharerProvider)
      .shareFile(
        bytes: Uint8List.fromList(utf8.encode(csv)),
        name: 'clinicaledge-audit-$date.csv',
        mimeType: 'text/csv',
        origin: origin,
      );
  await ref
      .read(activityLoggerProvider)
      .audit(AuditAction.auditExport, target: 'CSV · ${events.length} rows');
  ref.invalidate(auditEventsProvider);
  return events.length;
};

/// Usage insights from usage events and seed aggregates only (ADM-4).
@riverpod
Future<InsightsView> insights(Ref ref) async {
  final stats = await ref.watch(cohortStatsProvider.future);
  final usage = await ref.watch(usageEventsProvider.future);
  final courses = await ref.watch(catalogueProvider.future);
  return InsightsView.build(
    insights: stats.insights,
    usage: usage,
    courses: courses,
  );
}
