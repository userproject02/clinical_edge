import 'dart:async';

import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_event.dart';
import 'package:clinical_edge/core/logging/crash_reporter.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/logging/target_sanitizer.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

export 'activity_event.dart' show AuditAction, UsageAction;

part 'activity_logger.g.dart';

/// Takes every event and routes it to the audit or the usage store.
///
/// Callers pass only the action and a short target label; the logger fills
/// id, ts (from [Clock]), userId and role (from the session) and platform.
abstract interface class ActivityLogger {
  /// Appends an audit event. Throws [SensitiveTargetException] for targets
  /// that look like sensitive data.
  Future<void> audit(AuditAction action, {required String target});

  /// Records a usage event (best effort, never throws).
  void usage(UsageAction action, {required String target});
}

/// Who is acting.
typedef Actor = ({String userId, Role role});

/// Default [ActivityLogger].
class DefaultActivityLogger implements ActivityLogger {
  /// Creates the logger.
  new({
    required this.actor,
    required this.clock,
    required this.auditStore,
    required this.usageStore,
    required this.crashReporter,
    required this.platform,
    Uuid? uuid,
  }) : _uuid = uuid ?? const Uuid();

  /// Reads the current actor from the session.
  final Actor Function() actor;

  /// Time source.
  final Clock clock;

  /// Audit store.
  final AuditStore auditStore;

  /// Usage store.
  final UsageStore usageStore;

  /// Where usage failures are reported.
  final CrashReporter crashReporter;

  /// `ios` or `android`.
  final String platform;

  final Uuid _uuid;

  @override
  Future<void> audit(AuditAction action, {required String target}) async {
    final a = actor();
    await auditStore.append(
      AuditDraft(
        id: _uuid.v4(),
        ts: clock.now(),
        userId: a.userId,
        role: a.role,
        action: action,
        target: TargetSanitizer.clean(target),
        platform: platform,
      ),
    );
  }

  @override
  void usage(UsageAction action, {required String target}) {
    try {
      final a = actor();
      final event = ActivityEvent(
        id: _uuid.v4(),
        ts: clock.now(),
        userId: a.userId,
        role: a.role,
        action: action.wire,
        target: TargetSanitizer.clean(target),
        platform: platform,
        kind: EventKind.usage,
      );
      unawaited(
        usageStore.add(event).catchError((Object e, StackTrace s) {
          crashReporter.record(e, s, reason: 'usage store');
        }),
      );
    } on Object catch (e, s) {
      crashReporter.record(e, s, reason: 'usage ${action.wire}');
    }
  }
}

/// `ios` or `android` for the running device.
String currentPlatformName() =>
    defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';

/// Who is acting, read when an event is logged. Phase 1's session stub
/// provides it until Phase 3's auth feature (see mock overrides).
@Riverpod(keepAlive: true)
Actor Function() currentActor(Ref ref) =>
    () => (userId: 'unknown', role: Role.learner);

/// The app's activity logger.
@Riverpod(keepAlive: true)
ActivityLogger activityLogger(Ref ref) => DefaultActivityLogger(
  actor: ref.watch(currentActorProvider),
  clock: ref.watch(clockProvider),
  auditStore: ref.watch(auditStoreProvider),
  usageStore: ref.watch(usageStoreProvider),
  crashReporter: ref.watch(crashReporterProvider),
  platform: currentPlatformName(),
);
