import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/competencies/data/competency_repository.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/competencies/domain/signoff_use_cases.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app_harness.dart';
import '../helpers/test_container.dart';

const _layla = 'u-layla';
const _omar = 'u-omar';
const _iv = 'Peripheral IV cannulation';

Finder _t(String s) => find.byWidgetPredicate(
  (w) =>
      w is Text &&
      (w.data ?? '').replaceAll(RegExp('[\u2066-\u2069]'), '').contains(s),
);

String _loc(ProviderContainer c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

Future<void> _go(WidgetTester t, ProviderContainer c, String path) async {
  c.read(routerProvider).go(path);
  await settle(t);
}

Future<void> _tap(WidgetTester t, Finder f) async {
  await t.ensureVisible(f);
  await t.tap(f);
  await settle(t);
}

/// Switches the demo role (as the router tests do: sign in as that role's
/// seed user).
Future<void> _switch(WidgetTester t, ProviderContainer c, Role role) async {
  await t.runAsync(
    () => c
        .read(sessionProvider.notifier)
        .signIn(email: 'x@demo-hospital.example', password: 'x', role: role),
  );
  c.read(firstHomeLoadProvider.notifier).done();
  await settle(t);
}

Future<void> _drain(WidgetTester t) async {
  await t.pump(const Duration(seconds: 5));
  await t.pump(const Duration(seconds: 1));
}

Future<List<({String action, String target})>> _audit(
  WidgetTester t,
  ProviderContainer c,
) async => [
  for (final e in (await t.runAsync(() => c.read(auditStoreProvider).list()))!)
    (action: e.action, target: e.target),
];

void main() {
  group('COMP-1 request', () {
    testWidgets('TC-COMP-1-03 learner cards; request → Pending, audit, '
        'snackbar', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.signoffs);
      final cl1 = find.byKey(const Key('signoff.cl1'));
      expect(
        find.descendant(of: cl1, matching: find.text(_iv)),
        findsOneWidget,
      );
      expect(
        find.descendant(of: cl1, matching: find.text('Not requested')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cl1,
          matching: find.text(
            'Goes to Dr. Omar Al Mansoori · Emergency Medicine',
          ),
        ),
        findsOneWidget,
      );
      final cl2 = find.byKey(const Key('signoff.cl2'));
      await tester.ensureVisible(cl2);
      expect(
        find.descendant(of: cl2, matching: find.text('Approved')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cl2,
          matching: _t('Approved by Dr. Omar Al Mansoori · 28 Oct 2026'),
        ),
        findsOneWidget,
      );
      expect(
        find.text('Confident PPV technique and clear team communication.'),
        findsOneWidget,
      );

      await _tap(tester, find.byKey(const Key('signoff.cl1.request')));
      expect(find.text('Sign-off requested'), findsOneWidget);
      expect(find.text('Sent to Dr. Omar Al Mansoori'), findsOneWidget);
      expect(
        find.descendant(of: cl1, matching: find.text('Pending')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cl1,
          matching: _t('Waiting for supervisor · requested 17 Nov 2026'),
        ),
        findsOneWidget,
      );
      expect(find.byKey(const Key('signoff.cl1.request')), findsNothing);
      expect(
        await _audit(tester, c),
        contains((action: 'signoff.request', target: _iv)),
      );
      await _drain(tester);
    });

    test('TC-COMP-1-04 permission rules: learners request, only '
        'supervisors decide, never their own request', () async {
      final c = await mockContainer();
      final repo = c.read(competencyRepositoryProvider);
      final logger = c.read(activityLoggerProvider);
      final cl1 = (await repo.checklists()).first;
      expect(
        () => RequestSignOff(repository: repo, logger: logger)(
          learnerId: _omar,
          role: Role.supervisor,
          checklist: cl1,
        ),
        throwsA(isA<SignOffPermissionException>()),
      );
      final r = await RequestSignOff(repository: repo, logger: logger)(
        learnerId: _layla,
        role: Role.learner,
        checklist: cl1,
      );
      Future<SignOffRequest> decide({required String by, required Role role}) =>
          DecideSignOff(repository: repo, logger: logger)(
            request: r,
            checklist: cl1,
            learnerName: 'Dr. Layla Haddad',
            supervisorId: by,
            role: role,
            approve: true,
            comment: '',
            defaultApproval: const LocalizedText(en: 'ok', ar: 'ok'),
          );
      expect(
        () => decide(by: _layla, role: Role.learner),
        throwsA(isA<SignOffPermissionException>()),
      );
      expect(
        () => decide(by: _layla, role: Role.supervisor),
        throwsA(isA<SignOffPermissionException>()),
      );
      expect((await repo.byId(r.id))!.status, SignOffStatus.pending);
      final ok = await decide(by: _omar, role: Role.supervisor);
      expect(ok.status, SignOffStatus.approved);
      expect(ok.decidedBy, _omar);
    });
  });

  group('COMP-2 decide', () {
    testWidgets('TC-COMP-2-03 queue: stats, oldest first, badge', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.supervisor);
      expect(_loc(c), AppRoutes.queue);
      expect(
        find.descendant(
          of: find.byKey(const Key('queue.stat.pending')),
          matching: _t('2'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('queue.stat.month')),
          matching: _t('2'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('queue.stat.turnaround')),
          matching: _t('1.7d'),
        ),
        findsOneWidget,
      );
      final mariam = tester.getTopLeft(find.byKey(const Key('queue.so-004')));
      final aisha = tester.getTopLeft(find.byKey(const Key('queue.so-003')));
      expect(mariam.dy, lessThan(aisha.dy), reason: 'oldest first');
      expect(find.text('Aisha Rahman'), findsOneWidget);
      expect(find.text('Registered Nurse · ICU'), findsOneWidget);
      expect(_t('4 skills · requested 16 Nov 2026'), findsOneWidget);
      final nav = tester.widget<BottomNavBar>(find.byType(BottomNavBar));
      expect(nav.items.first.badge, 2);
    });

    testWidgets('TC-COMP-2-04 reject needs a comment; approve stores the '
        'default comment; audit never has the comment', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.supervisor);
      final decisionsBefore = (await _audit(
        tester,
        c,
      )).where((e) => e.action == 'signoff.decision').length;
      await _tap(tester, find.byKey(const Key('queue.so-003')));
      expect(_loc(c), AppRoutes.review('so-003'));
      expect(find.text('Aisha Rahman'), findsOneWidget);
      expect(find.text('Observed'), findsNWidgets(4));
      expect(
        find.text('Your decision is written to the append-only audit chain.'),
        findsOneWidget,
      );

      await _tap(tester, find.byKey(const Key('review.reject')));
      expect(find.text('A comment is required to reject.'), findsOneWidget);
      expect(_loc(c), AppRoutes.review('so-003'));
      final repo = c.read(competencyRepositoryProvider);
      expect(
        (await tester.runAsync(() => repo.byId('so-003')))!.status,
        SignOffStatus.pending,
      );
      expect(
        (await _audit(tester, c)).where((e) => e.action == 'signoff.decision'),
        hasLength(decisionsBefore),
        reason: 'nothing written',
      );

      await _tap(tester, find.byKey(const Key('review.approve')));
      expect(_loc(c), AppRoutes.queue);
      expect(find.text('Competency approved'), findsOneWidget);
      final decided = (await tester.runAsync(() => repo.byId('so-003')))!;
      expect(decided.status, SignOffStatus.approved);
      expect(decided.decidedBy, _omar);
      expect(decided.comment!.en, 'Competent. Observed and signed off.');
      expect(
        await _audit(tester, c),
        contains((
          action: 'signoff.decision',
          target: '$_iv · Aisha Rahman · approved',
        )),
      );
      expect(find.byKey(const Key('queue.so-003')), findsNothing);
      await _drain(tester);

      await _tap(tester, find.byKey(const Key('queue.so-004')));
      await tester.enterText(
        find.byKey(const Key('review.comment')),
        'Practise the inflation breaths on the manikin.',
      );
      await _tap(tester, find.byKey(const Key('review.reject')));
      expect(find.text('Returned with comments'), findsOneWidget);
      final rejected = (await tester.runAsync(() => repo.byId('so-004')))!;
      expect(rejected.status, SignOffStatus.rejected);
      expect(
        rejected.comment!.en,
        'Practise the inflation breaths on the manikin.',
      );
      final targets = (await _audit(tester, c)).map((e) => e.target);
      expect(
        targets,
        contains('Neonatal resuscitation skills · Mariam Saeed · rejected'),
      );
      expect(targets.any((t) => t.contains('manikin')), isFalse);
      expect(find.byKey(const Key('queue.empty')), findsOneWidget);
      expect(find.text('All caught up'), findsOneWidget);
      await _drain(tester);

      await _go(tester, c, AppRoutes.decided);
      final first = find.byKey(const Key('decided.0'));
      expect(
        find.descendant(of: first, matching: find.text('Mariam Saeed')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: first, matching: find.text('Changes requested')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('decided.1')),
          matching: find.text('Aisha Rahman'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('TC-COMP-2-05 cross-role round trip: Layla requests, Omar '
        'returns, Layla sees it on Sign-offs and Home', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.signoffs);
      await _tap(tester, find.byKey(const Key('signoff.cl1.request')));
      await _drain(tester);

      await _switch(tester, c, Role.supervisor);
      final pending = await tester.runAsync(
        () => c.read(competencyRepositoryProvider).queue(),
      );
      final mine = pending!.singleWhere((r) => r.learnerId == _layla);
      await _go(tester, c, AppRoutes.queue);
      expect(find.text('Dr. Layla Haddad'), findsOneWidget);
      await _tap(tester, find.byKey(Key('queue.${mine.id}')));
      await tester.enterText(
        find.byKey(const Key('review.comment')),
        'Practise vein selection, then resubmit.',
      );
      await _tap(tester, find.byKey(const Key('review.reject')));
      await _drain(tester);

      await _switch(tester, c, Role.learner);
      await _go(tester, c, AppRoutes.signoffs);
      final cl1 = find.byKey(const Key('signoff.cl1'));
      expect(
        find.descendant(of: cl1, matching: find.text('Changes requested')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cl1,
          matching: _t('Returned by Dr. Omar Al Mansoori · 17 Nov 2026'),
        ),
        findsOneWidget,
      );
      expect(
        find.text('Practise vein selection, then resubmit.'),
        findsOneWidget,
      );
      expect(
        find.descendant(of: cl1, matching: find.text('Request sign-off')),
        findsOneWidget,
        reason: 'can resubmit',
      );

      await _go(tester, c, AppRoutes.home);
      await tester.scrollUntilVisible(
        find.byKey(const Key('home.signoffs')),
        200,
        scrollable: find
            .descendant(
              of: find.byKey(const Key('home.list')),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('home.signoffs')),
          matching: find.text('Changes requested'),
        ),
        findsOneWidget,
      );
      expect(c.read(mySignOffsProvider).value, isNotNull);
    });

    testWidgets('TC-COMP-2-06 guard: a learner cannot open /queue or a '
        'review', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.queue);
      expect(_loc(c), AppRoutes.home);
      await _go(tester, c, AppRoutes.review('so-003'));
      expect(_loc(c), AppRoutes.home);
      expect(find.byKey(const Key('review.approve')), findsNothing);
    });
  });

  group('Screen goldens', () {
    Future<void> pendingAndRejected(
      WidgetTester t,
      ProviderContainer c,
      InMemoryLocalDb db,
    ) async {
      await t.runAsync(() async {
        await c.read(competencyRepositoryProvider).request(_layla, 'cl1');
        final col = await db.open(Collections.signoffs);
        final so2 = SignOffRequest.fromJson((await col.get('so-002'))!);
        await col.put(
          'so-002',
          so2
              .copyWith(
                status: SignOffStatus.rejected,
                comment: const LocalizedText(
                  en: 'Repeat the PPV sequence with the team, then resubmit.',
                  ar:
                      'كرّر تسلسل التهوية بالضغط الإيجابي مع الفريق ثم أعد '
                      'التقديم.',
                ),
              )
              .toJson(),
        );
      });
      c.invalidate(mySignOffsProvider);
    }

    Future<void> emptyQueue(WidgetTester t, ProviderContainer c) async {
      await t.runAsync(() async {
        final repo = c.read(competencyRepositoryProvider);
        for (final id in ['so-003', 'so-004']) {
          await repo.decide(id, approve: true, supervisorId: _omar);
        }
      });
      c.read(routerProvider).refresh();
    }

    for (final (theme, locale) in <(String, String)>[
      ('light', 'en'),
      ('dark', 'en'),
      ('light', 'ar'),
      ('dark', 'ar'),
    ]) {
      final dir = locale == 'ar' ? 'rtl' : 'ltr';
      for (final name in <String>[
        'signoffs_none_approved',
        'signoffs_pending_rejected',
        'queue',
        'queue_empty',
        'review_error',
        'decided',
      ]) {
        testWidgets('$name golden ($theme $dir)', (tester) async {
          final db = InMemoryLocalDb();
          final learner = name.startsWith('signoffs');
          final c = await pumpClinicalEdge(
            tester,
            db: db,
            prefs: <String, Object>{
              PrefKeys.themeMode: theme,
              PrefKeys.locale: locale,
            },
            signedInAs: learner ? Role.learner : Role.supervisor,
          );
          switch (name) {
            case 'signoffs_none_approved':
              await _go(tester, c, AppRoutes.signoffs);
            case 'signoffs_pending_rejected':
              await pendingAndRejected(tester, c, db);
              await _go(tester, c, AppRoutes.signoffs);
            case 'queue':
              await settle(tester);
            case 'queue_empty':
              await emptyQueue(tester, c);
              await _go(tester, c, AppRoutes.decided);
              await _go(tester, c, AppRoutes.queue);
            case 'review_error':
              await _go(tester, c, AppRoutes.review('so-003'));
              await _tap(tester, find.byKey(const Key('review.reject')));
            case 'decided':
              await _go(tester, c, AppRoutes.decided);
          }
          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile('goldens/${name}_${theme}_$dir.png'),
          );
        }, tags: <String>['golden']);
      }
    }
  });
}
