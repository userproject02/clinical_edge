import 'dart:convert';

import 'package:clinical_edge/core/logging/activity_event.dart';
import 'package:crypto/crypto.dart';

/// Hash chain over audit events (tamper evidence).
///
/// `hash = SHA-256(prevHash|ts|userId|role|action|target|platform)` as lower
/// hex, where `ts` is ISO-8601 UTC and `role` is the role's enum name. The
/// first event's `prevHash` is 64 zeros. This formula is a contract.
abstract final class AuditChain {
  /// `prevHash` of the first event.
  static final String genesis = '0' * 64;

  /// Hash of one event given its predecessor's hash.
  static String hashOf({
    required String prevHash,
    required DateTime ts,
    required String userId,
    required String role,
    required String action,
    required String target,
    required String platform,
  }) {
    final input = <String>[
      prevHash,
      ts.toUtc().toIso8601String(),
      userId,
      role,
      action,
      target,
      platform,
    ].join('|');
    return sha256.convert(utf8.encode(input)).toString();
  }

  /// Recomputes [event]'s hash from its own fields.
  static String recompute(ActivityEvent event) => hashOf(
    prevHash: event.prevHash ?? '',
    ts: event.ts,
    userId: event.userId,
    role: event.role.name,
    action: event.action,
    target: event.target,
    platform: event.platform,
  );

  /// Checks every link and hash, oldest first.
  static ChainResult verify(List<ActivityEvent> events) {
    var expectedPrev = genesis;
    for (var i = 0; i < events.length; i++) {
      final e = events[i];
      if (e.prevHash != expectedPrev) {
        return ChainBroken(index: i, event: e, reason: ChainBreak.link);
      }
      if (e.hash != recompute(e)) {
        return ChainBroken(index: i, event: e, reason: ChainBreak.content);
      }
      expectedPrev = e.hash!;
    }
    return ChainOk(count: events.length, head: expectedPrev);
  }
}

/// Outcome of [AuditChain.verify].
sealed class ChainResult {
  const new();
}

/// Every event links to its predecessor and its hash matches its fields.
final class ChainOk extends ChainResult {
  /// Creates the result.
  const new({required this.count, required this.head});

  /// Number of events verified.
  final int count;

  /// Hash of the newest event (genesis when empty).
  final String head;
}

/// Why the chain broke.
enum ChainBreak {
  /// `prevHash` does not match the previous event's hash (inserted,
  /// removed or reordered event).
  link,

  /// The event's fields no longer produce its stored hash (edited event).
  content,
}

/// The first event where the chain breaks.
final class ChainBroken extends ChainResult {
  /// Creates the result.
  const new({required this.index, required this.event, required this.reason});

  /// Position of the broken event, oldest first.
  final int index;

  /// The broken event.
  final ActivityEvent event;

  /// What failed.
  final ChainBreak reason;
}
