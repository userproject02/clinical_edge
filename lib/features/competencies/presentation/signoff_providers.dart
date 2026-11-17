import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/data/auth_repository.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/competencies/data/competency_repository.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/competencies/domain/signoff_use_cases.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:material_ui/material_ui.dart' show Locale;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signoff_providers.g.dart';

/// Users by id (names and initials on sign-off cards).
@riverpod
Future<Map<String, AppUser>> usersById(Ref ref) async => {
  for (final u in await ref.watch(authRepositoryProvider).users()) u.id: u,
};

/// The supervisor learners' requests go to (first seed supervisor).
@riverpod
Future<AppUser?> signOffSupervisor(Ref ref) async =>
    (await ref.watch(usersByIdProvider.future)).values
        .where((u) => u.role == Role.supervisor)
        .firstOrNull;

/// Checklists by id.
@riverpod
Future<Map<String, CompetencyChecklist>> checklistsById(Ref ref) async => {
  for (final c in await ref.watch(checklistsProvider.future)) c.id: c,
};

/// Pending requests, oldest first (supervisor queue).
@riverpod
Future<List<SignOffRequest>> signOffQueue(Ref ref) =>
    ref.watch(competencyRepositoryProvider).queue();

/// Decided requests, newest decision first.
@riverpod
Future<List<SignOffRequest>> decidedSignOffs(Ref ref) =>
    ref.watch(competencyRepositoryProvider).decided();

/// One request.
@riverpod
Future<SignOffRequest?> signOffRequest(Ref ref, String requestId) =>
    ref.watch(competencyRepositoryProvider).byId(requestId);

/// Supervisor queue stats.
typedef QueueStats = ({int pending, int thisMonth, double? turnaroundDays});

/// Pending count, requests received this calendar month (Dubai) and the
/// mean request → decision time in days over decided requests.
@riverpod
Future<QueueStats> queueStats(Ref ref) async {
  final pending = await ref.watch(signOffQueueProvider.future);
  final decided = await ref.watch(decidedSignOffsProvider.future);
  final today = ref.watch(clockProvider).today();
  final thisMonth = <SignOffRequest>[...pending, ...decided].where((r) {
    final at = r.requestedAt;
    if (at == null) return false;
    final d = dubaiDate(at);
    return d.year == today.year && d.month == today.month;
  }).length;
  final spans = <Duration>[
    for (final r in decided)
      if (r.requestedAt != null && r.decidedAt != null)
        r.decidedAt!.difference(r.requestedAt!),
  ];
  final turnaround = spans.isEmpty
      ? null
      : spans.fold(0, (s, d) => s + d.inMinutes) / spans.length / (60 * 24);
  return (
    pending: pending.length,
    thisMonth: thisMonth,
    turnaroundDays: turnaround,
  );
}

void _refresh(Ref ref) => ref
  ..invalidate(mySignOffsProvider)
  ..invalidate(signOffQueueProvider)
  ..invalidate(decidedSignOffsProvider)
  ..invalidate(signOffRequestProvider);

/// Requests sign-off for a checklist as the signed-in learner (COMP-1).
@Riverpod(keepAlive: true)
Future<SignOffRequest> Function(CompetencyChecklist checklist) requestSignOff(
  Ref ref,
) => (checklist) async {
  final s = ref.read(sessionProvider).value;
  final r =
      await RequestSignOff(
        repository: ref.read(competencyRepositoryProvider),
        logger: ref.read(activityLoggerProvider),
      )(
        learnerId: s?.user.id ?? '',
        role: s?.role ?? Role.learner,
        checklist: checklist,
      );
  _refresh(ref);
  return r;
};

/// Approves or rejects a request as the signed-in supervisor (COMP-2).
/// Throws `CommentRequiredException` for a reject without a comment.
@Riverpod(keepAlive: true)
Future<SignOffRequest> Function(
  SignOffRequest request, {
  required bool approve,
  required String comment,
})
decideSignOff(Ref ref) =>
    (request, {required approve, required comment}) async {
      final s = ref.read(sessionProvider).value;
      final checklist = (await ref.read(
        checklistsByIdProvider.future,
      ))[request.checklistId]!;
      final learner = (await ref.read(
        usersByIdProvider.future,
      ))[request.learnerId];
      final en = lookupAppLocalizations(const Locale('en'));
      final ar = lookupAppLocalizations(const Locale('ar'));
      final r =
          await DecideSignOff(
            repository: ref.read(competencyRepositoryProvider),
            logger: ref.read(activityLoggerProvider),
          )(
            request: request,
            checklist: checklist,
            learnerName: learner?.name.en ?? request.learnerId,
            supervisorId: s?.user.id ?? '',
            role: s?.role ?? Role.learner,
            approve: approve,
            comment: comment,
            defaultApproval: LocalizedText(
              en: en.reviewDefaultApproval,
              ar: ar.reviewDefaultApproval,
            ),
          );
      _refresh(ref);
      return r;
    };
