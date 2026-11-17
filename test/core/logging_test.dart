import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_event.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/logging/audit_chain.dart';
import 'package:clinical_edge/core/logging/crash_reporter.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/logging/target_sanitizer.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:flutter_test/flutter_test.dart';

class _Crashes implements CrashReporter {
  final List<Object> errors = <Object>[];
  @override
  void record(Object error, StackTrace stack, {String? reason}) =>
      errors.add(error);
}

AuditDraft _draft(int i, {String target = 'BLS Assessment · 88% · pass'}) =>
    AuditDraft(
      id: 'e$i',
      ts: DateTime.utc(2026, 11, 17, 5, i),
      userId: 'u-layla',
      role: Role.learner,
      action: AuditAction.quizScore,
      target: target,
      platform: 'ios',
    );

void main() {
  group('TargetSanitizer', () {
    test('TC-LOG-02 rejects card numbers, CVC, emails and passwords', () {
      for (final bad in <String>[
        '4111111111111111',
        '4111 1111 1111 1111',
        '4111-1111-1111-1111',
        'card 5500005555555559 used',
        'CVC 123',
        'cvv: 999',
        'layla.haddad@demo-hospital.example',
        'password hunter2',
        'reset pwd',
      ]) {
        expect(
          () => TargetSanitizer.clean(bad),
          throwsA(isA<SensitiveTargetException>()),
          reason: bad,
        );
      }
    });

    test('TC-LOG-03 allows short labels and caps length at 120', () {
      for (final ok in <String>[
        'Basic Life Support Refresher · AED 367.50 · CE-2026-001041',
        'BLS Assessment · 88% · pass',
        'Neonatal resuscitation skills · Dr. Layla Haddad · approved',
        'learner → admin',
        'CSV · 9 events',
        '123456789012', // 12 digits: below card length
      ]) {
        expect(TargetSanitizer.clean(ok), ok.trim());
      }
      final long = 'x' * 300;
      expect(TargetSanitizer.clean(long).length, 120);
      const rejected = SensitiveTargetException('card number');
      expect(rejected.toString(), isNot(contains('4111')));
    });
  });

  group('AuditChain', () {
    test('TC-LOG-01 append, verify and detect tampering', () async {
      final db = InMemoryLocalDb();
      final store = LocalAuditStore(db);
      for (var i = 0; i < 5; i++) {
        await store.append(_draft(i));
      }
      final events = await store.list();
      expect(events, hasLength(5));
      expect(events.first.prevHash, '0' * 64);
      for (var i = 1; i < events.length; i++) {
        expect(events[i].prevHash, events[i - 1].hash);
      }
      final ok = AuditChain.verify(events);
      expect(ok, isA<ChainOk>());
      expect((ok as ChainOk).head, events.last.hash);

      // Edit a stored event's target behind the store's back.
      final col = await db.open(Collections.audit);
      final raw = await col.get('00000002');
      await col.put('00000002', <String, Object?>{
        ...raw!,
        'target': 'BLS Assessment · 100% · pass',
      });
      final edited = AuditChain.verify(await store.list());
      expect(edited, isA<ChainBroken>());
      expect((edited as ChainBroken).index, 2);
      expect(edited.reason, ChainBreak.content);

      // Remove an event entirely: the next link breaks.
      final events2 = List<ActivityEvent>.of(events)..removeAt(1);
      final removed = AuditChain.verify(events2) as ChainBroken;
      expect(removed.index, 1);
      expect(removed.reason, ChainBreak.link);
    });

    test('TC-LOG-04 hash formula is SHA-256 of the pipe-joined fields', () {
      final h = AuditChain.hashOf(
        prevHash: '0' * 64,
        ts: DateTime.utc(2026, 11, 17, 5),
        userId: 'u-layla',
        role: 'learner',
        action: 'quiz.score',
        target: 'BLS Assessment · 88% · pass',
        platform: 'ios',
      );
      expect(h, hasLength(64));
      expect(h, matches(RegExp(r'^[0-9a-f]{64}$')));
      expect(
        h,
        AuditChain.hashOf(
          prevHash: '0' * 64,
          ts: DateTime.parse('2026-11-17T09:00:00+04:00'),
          userId: 'u-layla',
          role: 'learner',
          action: 'quiz.score',
          target: 'BLS Assessment · 88% · pass',
          platform: 'ios',
        ),
        reason: 'ts is normalised to UTC',
      );
      expect(AuditChain.verify(const <ActivityEvent>[]), isA<ChainOk>());
    });

    test('TC-LOG-05 concurrent appends keep one chain', () async {
      final store = LocalAuditStore(InMemoryLocalDb());
      await Future.wait(<Future<ActivityEvent>>[
        for (var i = 0; i < 10; i++) store.append(_draft(i)),
      ]);
      expect(AuditChain.verify(await store.list()), isA<ChainOk>());
    });
  });

  group('ActivityLogger', () {
    late InMemoryLocalDb db;
    late _Crashes crashes;
    late DefaultActivityLogger logger;

    setUp(() {
      db = InMemoryLocalDb();
      crashes = _Crashes();
      logger = DefaultActivityLogger(
        actor: () => (userId: 'u-omar', role: Role.supervisor),
        clock: FixedClock(demoNow),
        auditStore: LocalAuditStore(db),
        usageStore: LocalUsageStore(db),
        crashReporter: crashes,
        platform: 'android',
      );
    });

    test(
      'TC-LOG-06 stamps id, ts, user, role, platform; stores split',
      () async {
        await logger.audit(
          AuditAction.signoffDecision,
          target: 'Peripheral IV cannulation · approved',
        );
        logger.usage(
          UsageAction.courseView,
          target: 'Basic Life Support Refresher',
        );
        await Future<void>.delayed(Duration.zero);

        final audit = await LocalAuditStore(db).list();
        final usage = await LocalUsageStore(db).list();
        expect(audit, hasLength(1));
        expect(usage, hasLength(1));
        final a = audit.single;
        expect(a.id, isNotEmpty);
        expect(a.ts, demoNow);
        expect(a.userId, 'u-omar');
        expect(a.role, Role.supervisor);
        expect(a.platform, 'android');
        expect(a.action, 'signoff.decision');
        expect(a.kind, EventKind.audit);
        expect(usage.single.kind, EventKind.usage);
        expect(usage.single.action, 'course.view');
        expect(usage.single.hash, isNull);
      },
    );

    test('TC-LOG-07 sensitive targets: audit throws, usage drops', () async {
      await expectLater(
        logger.audit(AuditAction.purchase, target: '4111 1111 1111 1111'),
        throwsA(isA<SensitiveTargetException>()),
      );
      logger.usage(UsageAction.authSignin, target: 'password: secret');
      await Future<void>.delayed(Duration.zero);
      expect(await LocalAuditStore(db).list(), isEmpty);
      expect(await LocalUsageStore(db).list(), isEmpty);
      expect(crashes.errors.single, isA<SensitiveTargetException>());
    });

    test('TC-LOG-08 action wire names are the contract', () {
      expect(AuditAction.values.map((a) => a.wire), <String>[
        'role.change',
        'quiz.score',
        'signoff.request',
        'signoff.decision',
        'purchase',
        'cert.upload',
        'course.complete',
        'audit.export',
      ]);
      expect(UsageAction.values.map((a) => a.wire), <String>[
        'auth.signin',
        'auth.signout',
        'course.view',
        'lesson.view',
        'lesson.complete',
        'checkout.start',
        'notify.reminder',
      ]);
    });

    test('TC-LOG-09 usage store is capped (lossy by design)', () async {
      final store = LocalUsageStore(InMemoryLocalDb(), cap: 3);
      for (var i = 0; i < 5; i++) {
        await store.add(
          ActivityEvent(
            id: 'u$i',
            ts: demoNow,
            userId: 'u-layla',
            role: Role.learner,
            action: 'lesson.view',
            target: 'L$i',
            platform: 'ios',
            kind: EventKind.usage,
          ),
        );
      }
      final kept = await store.list();
      expect(kept.map((e) => e.target), <String>['L2', 'L3', 'L4']);
    });
  });
}
