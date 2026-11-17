import 'dart:convert';

import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_event.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/sharing/file_sharer.dart';
import 'package:clinical_edge/features/admin/data/cohort_repository.dart';
import 'package:clinical_edge/features/admin/domain/audit_log.dart';
import 'package:clinical_edge/features/admin/domain/insights.dart';
import 'package:clinical_edge/features/admin/presentation/admin_providers.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/competencies/data/competency_repository.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_providers.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app_harness.dart';
import '../helpers/test_container.dart';

Finder _t(String s) => find.byWidgetPredicate(
  (w) =>
      w is Text &&
      (w.data ?? '').replaceAll(RegExp(r'[\u2066-\u2069]'), '').contains(s),
);

String _loc(ProviderContainer c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

Future<void> _go(WidgetTester t, ProviderContainer c, String path) async {
  c.read(routerProvider).go(path);
  await settle(t);
}

/// Scrolls the cohort list until [f] is built and visible.
Future<void> _scrollTo(WidgetTester t, Finder f) => t.scrollUntilVisible(
  f,
  300,
  scrollable: find
      .descendant(
        of: find.byKey(const Key('cohort.list')),
        matching: find.byType(Scrollable),
      )
      .first,
);

Future<void> _tap(WidgetTester t, Finder f) async {
  await t.ensureVisible(f);
  await t.tap(f);
  await settle(t);
}

ActivityEvent _e(
  String id,
  String action,
  EventKind kind, {
  String user = 'u-layla',
  String target = 'x',
  DateTime? ts,
  String platform = 'ios',
}) => ActivityEvent(
  id: id,
  ts: ts ?? DateTime.utc(2026, 11, 17, 4),
  userId: user,
  role: Role.learner,
  action: action,
  target: target,
  platform: platform,
  kind: kind,
);

void main() {
  final clock = FixedClock(demoNow);

  group('ADM-1 cohort', () {
    testWidgets('TC-ADM-1-03 KPIs, live pending count, learners', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.admin);
      await _go(tester, c, AppRoutes.cohort);
      expect(_loc(c), AppRoutes.cohort);
      final active = find.byKey(const Key('cohort.kpi.active'));
      expect(find.descendant(of: active, matching: _t('142')), findsOneWidget);
      expect(
        find.descendant(of: active, matching: _t('96 nursing · 46 physicians')),
        findsOneWidget,
      );
      final completion = find.byKey(const Key('cohort.kpi.completion'));
      expect(
        find.descendant(of: completion, matching: _t('68%')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: completion, matching: _t('+6 pts vs Oct')),
        findsOneWidget,
      );
      final pending = find.byKey(const Key('cohort.kpi.pending'));
      expect(find.descendant(of: pending, matching: _t('2')), findsOneWidget);
      expect(
        find.descendant(of: pending, matching: _t('3 supervisors')),
        findsOneWidget,
      );
      await _scrollTo(tester, find.byKey(const Key('cohort.expiries')));
      expect(_t('34 total'), findsOneWidget);

      final layla = find.byKey(const Key('cohort.learner.u-layla'));
      await _scrollTo(tester, layla);
      expect(
        find.descendant(of: layla, matching: _t('55% · Internal Medicine')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: layla, matching: _t('BLS 56d')),
        findsOneWidget,
      );
      final yousef = find.byKey(const Key('cohort.learner.u-yousef'));
      expect(
        find.descendant(of: yousef, matching: _t('BLS 12d')),
        findsOneWidget,
      );

      // Live: deciding a request drops the pending count.
      await tester.runAsync(
        () => c
            .read(competencyRepositoryProvider)
            .decide('so-003', approve: true, supervisorId: 'u-omar'),
      );
      // Live: Layla finishing a lesson moves her row.
      await tester.runAsync(
        () =>
            c.read(progressRepositoryProvider).markComplete('u-layla', 'c1-l5'),
      );
      c
        ..invalidate(signOffQueueProvider)
        ..invalidate(cohortLearnersProvider);
      await settle(tester);
      expect(
        find.descendant(of: layla, matching: _t('64% · Internal Medicine')),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        pending,
        -300,
        scrollable: find
            .descendant(
              of: find.byKey(const Key('cohort.list')),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      expect(find.descendant(of: pending, matching: _t('1')), findsOneWidget);
    });

    testWidgets('TC-ADM-1-04 only admins reach /cohort, /audit, /insights', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      for (final p in [AppRoutes.cohort, AppRoutes.audit, AppRoutes.insights]) {
        await _go(tester, c, p);
        expect(_loc(c), AppRoutes.home, reason: p);
      }
    });
  });

  group('ADM-2 audit log', () {
    test(
      'TC-ADM-2-03 filters combine (kind, period, user, action, search)',
      () {
        final events = [
          _e(
            '1',
            'quiz.score',
            EventKind.audit,
            target: 'BLS Assessment · 88%',
          ),
          _e('2', 'course.view', EventKind.usage, target: 'BLS Refresher'),
          _e('3', 'purchase', EventKind.audit, user: 'u-aisha', target: 'IPC'),
          _e(
            '4',
            'course.view',
            EventKind.usage,
            ts: DateTime.utc(2026, 11, 13, 4),
            target: 'BLS old',
          ),
          _e(
            '5',
            'quiz.score',
            EventKind.audit,
            ts: DateTime.utc(2026, 11, 1, 4),
          ),
        ];
        List<String> ids(AuditFilter f) =>
            f.apply(events, clock).map((e) => e.id).toList();
        expect(ids(const AuditFilter()), ['1', '2', '3', '4', '5']);
        expect(ids(const AuditFilter(kind: KindFilter.audit)), ['1', '3', '5']);
        expect(ids(const AuditFilter(kind: KindFilter.usage)), ['2', '4']);
        expect(ids(const AuditFilter(period: PeriodFilter.today)), [
          '1',
          '2',
          '3',
        ]);
        expect(ids(const AuditFilter(period: PeriodFilter.week)), [
          '1',
          '2',
          '3',
          '4',
        ]);
        expect(ids(const AuditFilter(userId: 'u-aisha')), ['3']);
        expect(ids(const AuditFilter(action: 'quiz.score')), ['1', '5']);
        expect(ids(const AuditFilter(query: 'bls')), ['1', '2', '4']);
        expect(
          ids(
            const AuditFilter(
              kind: KindFilter.usage,
              period: PeriodFilter.today,
              query: 'bls',
            ),
          ),
          ['2'],
        );
        expect(
          ids(
            const AuditFilter(action: 'quiz.score', period: PeriodFilter.week),
          ),
          ['1'],
        );
      },
    );

    testWidgets('TC-ADM-2-04 chain banner verified, live events, filters in '
        'the UI', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await tester.runAsync(() async {
        c
            .read(activityLoggerProvider)
            .usage(UsageAction.courseView, target: 'Basic Life Support');
        await Future<void>.delayed(const Duration(milliseconds: 20));
      });
      await tester.runAsync(
        () => c
            .read(sessionProvider.notifier)
            .signIn(email: 'x@y', password: 'x', role: Role.admin),
      );
      await settle(tester);
      await _go(tester, c, AppRoutes.audit);
      final audit = (await tester.runAsync(
        () => c.read(auditStoreProvider).list(),
      ))!;
      final usage = (await tester.runAsync(
        () => c.read(usageStoreProvider).list(),
      ))!;
      expect(find.byKey(const Key('audit.chain.ok')), findsOneWidget);
      expect(
        _t(
          'Hash chain verified · ${audit.length} append-only events · '
          'head ${audit.last.hash!.substring(0, 8)}',
        ),
        findsOneWidget,
      );
      expect(
        _t(
          '${audit.length + usage.length} events · newest first · no patient '
          'data, passwords or card details',
        ),
        findsOneWidget,
      );
      // Every logged action is in the list (cards build lazily, so check
      // the data, then what is on screen).
      final listed = c.read(filteredEventsProvider).value!.map((e) => e.action);
      expect(listed, containsAll(<String>['course.view', 'auth.signin']));
      expect(listed, containsAll(audit.map((e) => e.action)));
      expect(_t('auth.signin'), findsWidgets);
      expect(_t('usage analytics · not chained'), findsWidgets);
      await _tap(
        tester,
        find.descendant(
          of: find.byKey(const Key('audit.kind')),
          matching: find.text('Audit'),
        ),
      );
      expect(_t('prev '), findsWidgets);
      await _tap(
        tester,
        find.descendant(
          of: find.byKey(const Key('audit.kind')),
          matching: find.text('All events'),
        ),
      );

      await _tap(
        tester,
        find.descendant(
          of: find.byKey(const Key('audit.kind')),
          matching: find.text('Usage'),
        ),
      );
      expect(_t('${usage.length} events'), findsOneWidget);
      await tester.enterText(
        find.byKey(const Key('audit.search')),
        'Basic Life',
      );
      await settle(tester);
      expect(_t('1 events'), findsOneWidget);
    });

    testWidgets('TC-ADM-2-05 tampered event → broken banner', (tester) async {
      final db = InMemoryLocalDb();
      final c = await pumpClinicalEdge(tester, db: db, signedInAs: Role.admin);
      await tester.runAsync(() async {
        // Keys are the zero-padded append sequence (Collections contract).
        final col = await db.open(Collections.audit);
        const key = '00000002';
        final row = (await col.get(key))!;
        await col.put(key, {...row, 'target': 'tampered'});
      });
      c.invalidate(auditEventsProvider);
      await _go(tester, c, AppRoutes.audit);
      expect(find.byKey(const Key('audit.chain.bad')), findsOneWidget);
      expect(_t('Hash chain broken at event 3'), findsOneWidget);
    });
  });

  group('ADM-3 CSV export', () {
    test('TC-ADM-3-03 RFC 4180 quoting and row count', () {
      final csv = auditCsv([
        _e('1', 'cert.upload', EventKind.audit, target: 'NRP, "Neonatal"'),
        _e('2', 'course.view', EventKind.usage, target: 'two\nlines'),
        _e('3', 'auth.signin', EventKind.usage, target: 'plain'),
      ]);
      final lines = csv.split('\r\n');
      expect(
        lines.first,
        'ts,user,role,action,target,platform,kind,prevHash,hash',
      );
      expect(csv, contains('"NRP, ""Neonatal"""'));
      expect(csv, contains('"two\nlines"'));
      expect(lines.last, '', reason: 'ends with CRLF');
      expect(csv.split('\r\n').where((l) => l.isNotEmpty), hasLength(4));
    });

    testWidgets('TC-ADM-3-04 export shares the filtered CSV and writes '
        'audit.export', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.admin);
      await _go(tester, c, AppRoutes.audit);
      await _tap(
        tester,
        find.descendant(
          of: find.byKey(const Key('audit.kind')),
          matching: find.text('Audit'),
        ),
      );
      final shown = c.read(filteredEventsProvider).value!;
      await _tap(tester, find.byKey(const Key('audit.export')));
      final sharer = c.read(fileSharerProvider) as RecordingFileSharer;
      expect(sharer.shared, hasLength(1));
      final file = sharer.shared.single;
      expect(file.name, 'clinicaledge-audit-2026-11-17.csv');
      expect(file.mimeType, 'text/csv');
      final rows = utf8
          .decode(file.bytes)
          .split('\r\n')
          .where((l) => l.isNotEmpty);
      expect(rows, hasLength(shown.length + 1));
      expect(find.text('Export ready'), findsOneWidget);
      final audit = await tester.runAsync(
        () => c.read(auditStoreProvider).list(),
      );
      expect(audit!.last.action, 'audit.export');
      expect(audit.last.target, 'CSV · ${shown.length} rows');
      await tester.pump(const Duration(seconds: 5));
    });
  });

  group('ADM-4 insights', () {
    test('TC-ADM-4-03 built only from usage events', () async {
      final c = await mockContainer();
      final stats = await c.read(cohortRepositoryProvider).stats();
      final courses = await c.read(courseRepositoryProvider).catalogue();
      expect(
        () => InsightsView.build(
          insights: stats.insights,
          usage: [_e('a', 'quiz.score', EventKind.audit)],
          courses: courses,
        ),
        throwsArgumentError,
      );
      final base = InsightsView.build(
        insights: stats.insights,
        usage: const [],
        courses: courses,
      );
      expect(base.courseViews.first.views, 412);
      expect(base.biggestDropLesson, 4);
      expect(base.iosPct, 58);
      final live = InsightsView.build(
        insights: stats.insights,
        usage: [
          _e('u1', 'course.view', EventKind.usage, target: courses[0].title.en),
          _e(
            'u2',
            'lesson.view',
            EventKind.usage,
            target: '${courses[0].title.en} · Lesson 1',
          ),
          for (var i = 0; i < 10; i++)
            _e('s$i', 'auth.signin', EventKind.usage, platform: 'android'),
        ],
        courses: courses,
      );
      expect(live.courseViews.first.views, 414);
      expect(live.androidPct, 47); // (42 + 10) / 110
    });

    testWidgets('TC-ADM-4-04 audit events never change insights', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.admin);
      await _go(tester, c, AppRoutes.insights);
      final before = c.read(insightsProvider).value!;
      await tester.runAsync(
        () => c
            .read(activityLoggerProvider)
            .audit(AuditAction.quizScore, target: 'BLS Assessment · 100%'),
      );
      c.invalidate(insightsProvider);
      await _go(tester, c, AppRoutes.insights);
      final after = c.read(insightsProvider).value!;
      expect(
        after.courseViews.map((x) => x.views),
        before.courseViews.map((x) => x.views),
      );
      expect(after.iosPct, before.iosPct);
      expect(_t('Lesson 4'), findsOneWidget);
      expect(
        find.text('Share of enrolled learners reaching each lesson.'),
        findsOneWidget,
      );
    });
  });

  group('Screen goldens', () {
    for (final (theme, locale) in <(String, String)>[
      ('light', 'en'),
      ('dark', 'en'),
      ('light', 'ar'),
      ('dark', 'ar'),
    ]) {
      final dir = locale == 'ar' ? 'rtl' : 'ltr';
      for (final (name, path) in <(String, String)>[
        ('cohort', AppRoutes.cohort),
        ('audit', AppRoutes.audit),
        ('insights', AppRoutes.insights),
      ]) {
        testWidgets('$name golden ($theme $dir)', (tester) async {
          final c = await pumpClinicalEdge(
            tester,
            prefs: <String, Object>{
              PrefKeys.themeMode: theme,
              PrefKeys.locale: locale,
            },
            signedInAs: Role.admin,
          );
          await _go(tester, c, path);
          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile('goldens/${name}_${theme}_$dir.png'),
          );
        }, tags: <String>['golden']);
      }
    }
  });
}
