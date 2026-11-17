import 'dart:async';

import 'package:clinical_edge/core/logging/activity_event.dart';
import 'package:clinical_edge/core/logging/audit_chain.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stores.g.dart';

/// An audit event before the store chains it.
class AuditDraft {
  /// Creates a draft.
  const new({
    required this.id,
    required this.ts,
    required this.userId,
    required this.role,
    required this.action,
    required this.target,
    required this.platform,
  });

  /// Event id.
  final String id;

  /// When it happened (UTC).
  final DateTime ts;

  /// Who.
  final String userId;

  /// Acting role.
  final Role role;

  /// Audit action.
  final AuditAction action;

  /// Short sanitised label.
  final String target;

  /// `ios` or `android`.
  final String platform;
}

/// Append-only, hash-chained audit store. There is deliberately no update
/// or delete API.
abstract interface class AuditStore {
  /// Chains [draft] onto the newest event, persists and returns it.
  Future<ActivityEvent> append(AuditDraft draft);

  /// Every event, oldest first.
  Future<List<ActivityEvent>> list();
}

/// Usage (analytics) store, separate from audit; may drop events.
abstract interface class UsageStore {
  /// Records [event].
  Future<void> add(ActivityEvent event);

  /// Every event, oldest first.
  Future<List<ActivityEvent>> list();
}

/// [AuditStore] on [LocalDb]. Appends are serialised so concurrent calls
/// cannot fork the chain.
class LocalAuditStore implements AuditStore {
  /// Creates the store.
  new(this._db);

  final LocalDb _db;
  Future<void> _tail = Future<void>.value();

  @override
  Future<ActivityEvent> append(AuditDraft draft) {
    final done = Completer<ActivityEvent>();
    _tail = _tail.then((_) async {
      try {
        done.complete(await _append(draft));
      } on Object catch (e, s) {
        done.completeError(e, s);
      }
    });
    return done.future;
  }

  Future<ActivityEvent> _append(AuditDraft d) async {
    final col = await _db.open(Collections.audit);
    final all = await col.values();
    final prev = all.isEmpty
        ? AuditChain.genesis
        : ActivityEvent.fromJson(all.last).hash!;
    final hash = AuditChain.hashOf(
      prevHash: prev,
      ts: d.ts,
      userId: d.userId,
      role: d.role.name,
      action: d.action.wire,
      target: d.target,
      platform: d.platform,
    );
    final event = ActivityEvent(
      id: d.id,
      ts: d.ts.toUtc(),
      userId: d.userId,
      role: d.role,
      action: d.action.wire,
      target: d.target,
      platform: d.platform,
      kind: EventKind.audit,
      prevHash: prev,
      hash: hash,
    );
    await col.put(all.length.toString().padLeft(8, '0'), event.toJson());
    return event;
  }

  @override
  Future<List<ActivityEvent>> list() async {
    final col = await _db.open(Collections.audit);
    return (await col.values()).map(ActivityEvent.fromJson).toList();
  }
}

/// [UsageStore] on [LocalDb]. Keeps the newest [cap] events.
class LocalUsageStore implements UsageStore {
  /// Creates the store.
  new(this._db, {this.cap = 5000});

  final LocalDb _db;

  /// Maximum events kept (older ones are dropped: usage may be lossy).
  final int cap;
  int _seq = -1;

  @override
  Future<void> add(ActivityEvent event) async {
    final col = await _db.open(Collections.usage);
    if (_seq < 0) _seq = await col.count();
    final key = (_seq++).toString().padLeft(8, '0');
    await col.put(key, event.toJson());
    final drop = _seq - cap - 1;
    if (drop >= 0) await col.delete(drop.toString().padLeft(8, '0'));
  }

  @override
  Future<List<ActivityEvent>> list() async {
    final col = await _db.open(Collections.usage);
    return (await col.values()).map(ActivityEvent.fromJson).toList();
  }
}

/// The audit store (overridden with [LocalAuditStore] in mock overrides).
@Riverpod(keepAlive: true)
AuditStore auditStore(Ref ref) => LocalAuditStore(ref.watch(localDbProvider));

/// The usage store.
@Riverpod(keepAlive: true)
UsageStore usageStore(Ref ref) => LocalUsageStore(ref.watch(localDbProvider));
