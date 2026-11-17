import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/logging/audit_chain.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/payments/payment_gateway.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/admin/data/cohort_repository.dart';
import 'package:clinical_edge/features/assessments/data/assessment_repository.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/features/auth/data/auth_repository.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/certifications/data/certification_repository.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/checkout/data/checkout_repository.dart';
import 'package:clinical_edge/features/competencies/data/competency_repository.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:clinical_edge/seed/demo_seeder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_container.dart';

void main() {
  const layla = 'u-layla';

  test(
    'TC-SEED-06 seeding loads the demo state and a valid audit chain',
    () async {
      final c = await mockContainer();
      await c.read(demoSeederProvider).ready;
      final events = await c.read(auditStoreProvider).list();
      expect(events, hasLength(10));
      expect(AuditChain.verify(events), isA<ChainOk>());
      expect(events.first.action, 'purchase');
      expect(events.last.action, 'audit.export');
    },
  );

  test(
    'TC-AUTH-1-03 mock sign-in: empty fields rejected, any password ok',
    () async {
      final c = await mockContainer();
      final auth = c.read(authRepositoryProvider);
      expect(await auth.currentUser(), isNull);
      await expectLater(
        auth.signIn(email: '', password: '', role: Role.learner),
        throwsA(
          isA<InvalidCredentialsException>()
              .having((e) => e.emailEmpty, 'email', isTrue)
              .having((e) => e.passwordEmpty, 'password', isTrue),
        ),
      );
      final u = await auth.signIn(
        email: 'layla.haddad@demo-hospital.example',
        password: 'x',
        role: Role.learner,
      );
      expect(u.name.en, 'Dr. Layla Haddad');
      expect(u.name.ar, 'د. ليلى حداد');
      expect((await auth.currentUser())!.id, layla);
      expect((await auth.switchRole(Role.admin)).name.en, 'Sara Khan');
      await auth.signOut();
      expect(await auth.currentUser(), isNull);
      expect((await auth.tenant()).en, 'Demo Health Network · Dubai');
    },
  );

  test(
    'TC-HOME-1-02 learner progress: 6 of 11 owned lessons, c3 unowned',
    () async {
      final c = await mockContainer();
      final courses = c.read(courseRepositoryProvider);
      final progress = c.read(progressRepositoryProvider);
      expect(await courses.ownedCourseIds(layla), <String>{'c1', 'c2'});
      final done = await progress.forUser(layla);
      expect(done, hasLength(6));
      final owned = (await courses.catalogue()).where((x) => x.id != 'c3');
      expect(owned.fold<int>(0, (s, x) => s + x.lessons.length), 11);

      final again = await progress.markComplete(layla, 'c1-l1');
      expect(
        again.completedAt,
        done.firstWhere((p) => p.lessonId == 'c1-l1').completedAt,
      );
      final fresh = await progress.markComplete(layla, 'c1-l5');
      expect(fresh.completedAt, demoNow);
      expect(await progress.forUser(layla), hasLength(7));
    },
  );

  test(
    'TC-QZ-1-02 BLS quiz draws the 8 resuscitation questions in order',
    () async {
      final c = await mockContainer();
      final repo = c.read(assessmentRepositoryProvider);
      final quiz = await repo.quiz('bls');
      expect(quiz.passMarkPct, QuizRules.passMarkPct);
      final qs = await repo.drawQuiz('bls');
      expect(qs, hasLength(8));
      expect(qs.every((q) => q.topic == 'resuscitation'), isTrue);
      expect(qs.map((q) => q.id), <String>[
        'q01',
        'q02',
        'q03',
        'q04',
        'q05',
        'q06',
        'q07',
        'q08',
      ]);
      expect(await repo.drawQuiz('bls'), qs, reason: 'stable demo order');
    },
  );

  test('TC-QZ-2-02 scoring rule: 7/8 = 88% pass, 6/8 = 75% fail', () {
    expect(QuizRules.scorePct(7, 8), 88);
    expect(QuizRules.passed(88), isTrue);
    expect(QuizRules.scorePct(6, 8), 75);
    expect(QuizRules.passed(75), isFalse);
    expect(QuizRules.scorePct(5, 8), 63);
    expect(QuizRules.passed(80), isTrue);
  });

  test('TC-QZ-3-02 history is newest first and grows with attempts', () async {
    final c = await mockContainer();
    final repo = c.read(assessmentRepositoryProvider);
    final history = await repo.history(layla);
    expect(history.map((a) => a.scorePct), <int>[75, 63]);
    await repo.submitAttempt(
      QuizAttempt(
        id: 'att-new',
        userId: layla,
        quizId: 'bls',
        answers: const <int>[2, 2, 1, 0, 3, 0, 0, 0],
        scorePct: 88,
        passed: true,
        submittedAt: demoNow,
      ),
    );
    expect((await repo.history(layla)).map((a) => a.scorePct), <int>[
      88,
      75,
      63,
    ]);
  });

  group('TC-CERT-1-01 expiry status from the clock', () {
    test('demo date: BLS renew soon (56 days), ACLS valid (317)', () async {
      final c = await mockContainer();
      final clock = c.read(clockProvider);
      final certs = await c.read(certificationRepositoryProvider).list(layla);
      final bls = certs.firstWhere((x) => x.id == 'cert-bls');
      final acls = certs.firstWhere((x) => x.id == 'cert-acls');
      expect(bls.daysLeft(clock), 56);
      expect(bls.status(clock), CertStatus.renewSoon);
      expect(acls.daysLeft(clock), 317);
      expect(acls.status(clock), CertStatus.valid);
      expect(certs.first.id, 'cert-bls', reason: 'soonest expiry first');
    });

    test('boundaries at 91 / 90 / 1 / 0 days and verifying', () {
      CertStatus s(int d, [Verification v = Verification.verified]) =>
          CertRules.status(daysLeft: d, verification: v);
      expect(s(91), CertStatus.valid);
      expect(s(90), CertStatus.renewSoon);
      expect(s(1), CertStatus.renewSoon);
      expect(s(0), CertStatus.expired);
      expect(s(-10), CertStatus.expired);
      expect(s(400, Verification.pending), CertStatus.verifying);
    });

    test('reminders at 90 / 60 / 30 / 7 days before expiry', () async {
      final c = await mockContainer();
      final bls = (await c.read(certificationRepositoryProvider).list(layla))
          .first;
      expect(bls.reminderDates(), <DateTime>[
        DateTime.utc(2026, 10, 14),
        DateTime.utc(2026, 11, 13),
        DateTime.utc(2026, 12, 13),
        DateTime.utc(2027, 1, 5),
      ]);
    });
  });

  test('TC-CERT-3-02 upload stores the certificate as verifying', () async {
    final c = await mockContainer();
    final repo = c.read(certificationRepositoryProvider);
    final cert = await repo.upload(
      userId: layla,
      name: const LocalizedText(
        en: 'NRP Provider',
        ar: 'مقدّم برنامج إنعاش حديثي الولادة',
      ),
      issuer: const LocalizedText(
        en: 'American Academy of Pediatrics',
        ar: 'الأكاديمية الأمريكية لطب الأطفال',
      ),
      issuedOn: DateTime.utc(2026, 11, 2),
      expiresOn: DateTime.utc(2028, 11, 2),
    );
    expect(cert.status(c.read(clockProvider)), CertStatus.verifying);
    expect(await repo.list(layla), hasLength(3));
  });

  test(
    'TC-CERT-2-01 CPD total equals the ledger; target from config',
    () async {
      final c = await mockContainer();
      final cpd = c.read(cpdRepositoryProvider);
      final ledger = await cpd.ledger(layla);
      expect(
        ledger.first.date,
        DateTime.utc(2026, 11, 4),
        reason: 'newest first',
      );
      expect(await cpd.total(layla), 26);
      expect(
        await cpd.total(layla),
        ledger.fold<int>(0, (s, e) => s + e.credits),
      );
      final config = await cpd.config();
      expect(config.target, 40);
      expect(config.targetIsDemo, isTrue);
    },
  );

  test(
    'TC-COMP-1-02 request moves none → pending and joins the queue',
    () async {
      final c = await mockContainer();
      final repo = c.read(competencyRepositoryProvider);
      expect((await repo.queue()).map((r) => r.learnerId), <String>[
        'u-mariam',
        'u-aisha',
      ]);
      final mine = await repo.requestsFor(layla);
      expect(
        mine.firstWhere((r) => r.checklistId == 'cl1').status,
        SignOffStatus.none,
      );
      final req = await repo.request(layla, 'cl1');
      expect(req.status, SignOffStatus.pending);
      expect(req.requestedAt, demoNow);
      expect((await repo.queue()).last.learnerId, layla);
      await expectLater(
        repo.request(layla, 'cl1'),
        throwsA(isA<SignOffStateException>()),
      );
      await expectLater(
        repo.request(layla, 'cl2'),
        throwsA(isA<SignOffStateException>()),
      );
    },
  );

  test('TC-COMP-2-02 reject needs a comment; decisions are recorded', () async {
    final c = await mockContainer();
    final repo = c.read(competencyRepositoryProvider);
    await expectLater(
      repo.decide('so-003', approve: false, supervisorId: 'u-omar'),
      throwsA(isA<CommentRequiredException>()),
    );
    await expectLater(
      repo.decide(
        'so-003',
        approve: false,
        supervisorId: 'u-omar',
        comment: const LocalizedText(en: '  ', ar: ''),
      ),
      throwsA(isA<CommentRequiredException>()),
    );
    final ok = await repo.decide(
      'so-003',
      approve: true,
      supervisorId: 'u-omar',
    );
    expect(ok.status, SignOffStatus.approved);
    expect(ok.decidedAt, demoNow);
    expect((await repo.decided()).first.id, 'so-003');
    expect((await repo.queue()).map((r) => r.id), <String>['so-004']);
    await expectLater(
      repo.decide('so-003', approve: true, supervisorId: 'u-omar'),
      throwsA(isA<SignOffStateException>()),
    );
  });

  test('TC-PAY-2-02 order totals and invoice number sequence', () async {
    final c = await mockContainer();
    final courses = c.read(courseRepositoryProvider);
    final checkout = c.read(checkoutRepositoryProvider);
    final c3 = (await courses.byId('c3'))!;
    final order = await checkout.createOrder(layla, c3);
    expect(
      (order.subtotalFils, order.vatFils, order.totalFils),
      (30000, 1500, 31500),
    );
    final paid = await checkout.completeOrder(
      order,
      method: const CardMethod('tok'),
      reference: 'mock_pi',
    );
    expect(paid.invoiceNo, 'CE-2026-001041');
    expect(paid.paidAt, demoNow);
    expect(paid.method, 'card');
    final second = await checkout.completeOrder(
      await checkout.createOrder(layla, c3),
      method: const ApplePayMethod('tok'),
      reference: 'mock_pi2',
    );
    expect(second.invoiceNo, 'CE-2026-001042');
    expect((await checkout.receipts(layla)).length, 2);
    expect((await checkout.seller()).trn, '[YOUR TRN]');
    await courses.grantOwnership(layla, 'c3');
    expect(await courses.isOwned(layla, 'c3'), isTrue);
  });

  test('TC-ADM-1-02 cohort stats are labelled demo figures', () async {
    final c = await mockContainer();
    final s = await c.read(cohortRepositoryProvider).stats();
    expect(s.demoFigures, isTrue);
    expect(s.kpis.avgCompletionPct, 68);
    expect(s.completionByCourse.map((x) => x.pct), <int>[74, 66, 41]);
    expect(s.insights.sessionsByPlatform.map((x) => x.pct), <int>[58, 42]);
  });

  test('TC-PH2-04 logger uses the session actor and the demo clock', () async {
    final c = await mockContainer();
    await c
        .read(sessionProvider.notifier)
        .signIn(
          email: 'omar@demo-hospital.example',
          password: 'x',
          role: Role.supervisor,
        );
    await c.read(demoSeederProvider).ready;
    await c
        .read(activityLoggerProvider)
        .audit(
          AuditAction.signoffDecision,
          target: 'Peripheral IV cannulation · approved',
        );
    final last = (await c.read(auditStoreProvider).list()).last;
    expect(last.userId, 'u-omar');
    expect(last.role, Role.supervisor);
    expect(last.ts, demoNow);
    expect(
      AuditChain.verify(await c.read(auditStoreProvider).list()),
      isA<ChainOk>(),
    );
  });

  test('TC-PH2-05 state survives a restart; reset restores the seed', () async {
    final db = InMemoryLocalDb();
    final first = await mockContainer(db: db);
    await first.read(progressRepositoryProvider).markComplete(layla, 'c1-l5');
    await first.read(competencyRepositoryProvider).request(layla, 'cl1');

    final restarted = await mockContainer(db: db);
    expect(
      await restarted.read(progressRepositoryProvider).forUser(layla),
      hasLength(7),
    );
    expect(
      await restarted.read(competencyRepositoryProvider).queue(),
      hasLength(3),
    );

    await restarted.read(demoSeederProvider).reset();
    expect(
      await restarted.read(progressRepositoryProvider).forUser(layla),
      hasLength(6),
    );
    expect(
      await restarted.read(competencyRepositoryProvider).queue(),
      hasLength(2),
    );
    final audit = await restarted.read(auditStoreProvider).list();
    expect(audit, hasLength(10));
    expect(AuditChain.verify(audit), isA<ChainOk>());
  });

  test('TC-PH2-06 clock mode switches to the device clock', () async {
    final c = await mockContainer();
    expect(c.read(clockProvider).now(), demoNow);
    await c.read(clockModeProvider.notifier).set(ClockMode.system);
    expect(c.read(clockProvider), isA<SystemClock>());
  });
}
