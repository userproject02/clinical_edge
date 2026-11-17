import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/seed/demo_seeder.dart';
import 'package:clinical_edge/seed/seed_loader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'competency_repository.g.dart';

/// Thrown when a sign-off is rejected without a comment (COMP-2).
class CommentRequiredException implements Exception {
  /// Creates the exception.
  const new();
}

/// Thrown when a request is not in the state an action needs.
class SignOffStateException implements Exception {
  /// Creates the exception.
  const new(this.message);

  /// What went wrong.
  final String message;

  @override
  String toString() => 'SignOffStateException: $message';
}

/// Checklists and sign-off requests.
abstract interface class CompetencyRepository {
  /// Every checklist.
  Future<List<CompetencyChecklist>> checklists();

  /// Requests of [learnerId] (one per checklist at most).
  Future<List<SignOffRequest>> requestsFor(String learnerId);

  /// Pending requests, oldest first (supervisor queue).
  Future<List<SignOffRequest>> queue();

  /// Approved or rejected requests, newest decision first.
  Future<List<SignOffRequest>> decided();

  /// Request by id.
  Future<SignOffRequest?> byId(String requestId);

  /// Moves [learnerId]'s request for [checklistId] to pending (creates it
  /// if needed). Pending or approved requests cannot be re-requested.
  Future<SignOffRequest> request(String learnerId, String checklistId);

  /// Approves or rejects a pending request. Rejecting needs a non-empty
  /// [comment] ([CommentRequiredException]).
  Future<SignOffRequest> decide(
    String requestId, {
    required bool approve,
    required String supervisorId,
    LocalizedText? comment,
  });
}

/// Mock [CompetencyRepository]: checklists from seed, requests in
/// [LocalDb].
class MockCompetencyRepository implements CompetencyRepository {
  /// Creates the repository.
  new({
    required this.seed,
    required this.db,
    required this.seeder,
    required this.clock,
    Uuid? uuid,
  }) : _uuid = uuid ?? const Uuid();

  /// Seed source.
  final SeedLoader seed;

  /// Persistence.
  final LocalDb db;

  /// Ensures demo data exists.
  final DemoSeeder seeder;

  /// Time source.
  final Clock clock;

  final Uuid _uuid;

  @override
  Future<List<CompetencyChecklist>> checklists() async =>
      (await seed.load(SeedFile.checklists))
          .objects('checklists')
          .map(CompetencyChecklist.fromJson)
          .toList();

  Future<List<SignOffRequest>> _all() async {
    await seeder.ready;
    return (await (await db.open(
      Collections.signoffs,
    )).values()).map(SignOffRequest.fromJson).toList();
  }

  @override
  Future<List<SignOffRequest>> requestsFor(String learnerId) async =>
      (await _all()).where((r) => r.learnerId == learnerId).toList();

  @override
  Future<List<SignOffRequest>> queue() async =>
      (await _all()).where((r) => r.status == SignOffStatus.pending).toList()
        ..sort((a, b) => a.requestedAt!.compareTo(b.requestedAt!));

  @override
  Future<List<SignOffRequest>> decided() async =>
      (await _all())
          .where(
            (r) =>
                r.status == SignOffStatus.approved ||
                r.status == SignOffStatus.rejected,
          )
          .toList()
        ..sort((a, b) => b.decidedAt!.compareTo(a.decidedAt!));

  @override
  Future<SignOffRequest?> byId(String requestId) async {
    await seeder.ready;
    final row = await (await db.open(Collections.signoffs)).get(requestId);
    return row == null ? null : SignOffRequest.fromJson(row);
  }

  @override
  Future<SignOffRequest> request(String learnerId, String checklistId) async {
    final existing = (await requestsFor(learnerId))
        .where((r) => r.checklistId == checklistId)
        .firstOrNull;
    if (existing != null &&
        (existing.status == SignOffStatus.pending ||
            existing.status == SignOffStatus.approved)) {
      throw SignOffStateException('already ${existing.status.name}');
    }
    final updated = SignOffRequest(
      id: existing?.id ?? 'so-${_uuid.v4()}',
      learnerId: learnerId,
      checklistId: checklistId,
      status: SignOffStatus.pending,
      requestedAt: clock.now(),
    );
    await _save(updated);
    return updated;
  }

  @override
  Future<SignOffRequest> decide(
    String requestId, {
    required bool approve,
    required String supervisorId,
    LocalizedText? comment,
  }) async {
    final r = await byId(requestId);
    if (r == null) throw SignOffStateException('no request $requestId');
    if (r.status != SignOffStatus.pending) {
      throw SignOffStateException('request is ${r.status.name}');
    }
    final hasComment =
        comment != null &&
        (comment.en.trim().isNotEmpty || comment.ar.trim().isNotEmpty);
    if (!approve && !hasComment) throw const CommentRequiredException();
    // "Newest first" must stay strict under the fixed demo clock: keep each
    // decision after the latest one.
    var at = clock.now();
    final latest = (await decided()).firstOrNull?.decidedAt;
    if (latest != null && !at.isAfter(latest)) {
      at = latest.add(const Duration(seconds: 1));
    }
    final updated = r.copyWith(
      status: approve ? SignOffStatus.approved : SignOffStatus.rejected,
      decidedBy: supervisorId,
      decidedAt: at,
      comment: hasComment ? comment : null,
    );
    await _save(updated);
    return updated;
  }

  Future<void> _save(SignOffRequest r) async {
    await (await db.open(Collections.signoffs)).put(r.id, r.toJson());
  }
}

/// The competency repository.
@Riverpod(keepAlive: true)
CompetencyRepository competencyRepository(Ref ref) =>
    throw UnimplementedError('Override competencyRepositoryProvider.');
