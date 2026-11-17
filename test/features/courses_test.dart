import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/courses/domain/course_progress.dart';
import 'package:clinical_edge/features/courses/presentation/course_detail_screen.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app_harness.dart';

String _loc(ProviderContainer c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

Future<void> _go(WidgetTester t, ProviderContainer c, String path) async {
  c.read(routerProvider).go(path);
  await settle(t);
}

Future<List<String>> _actions(WidgetTester t, ProviderContainer c) async =>
    <String>[
      ...(await t.runAsync(() => c.read(usageStoreProvider).list()))!
          .map((e) => e.action),
      ...(await t.runAsync(() => c.read(auditStoreProvider).list()))!
          .map((e) => e.action),
    ];

Finder _text(String s) => find.byWidgetPredicate(
  (w) =>
      w is Text &&
      (w.data ?? '').replaceAll(RegExp('[\u2066-\u2069]'), '').contains(s),
);

void main() {
  testWidgets('TC-HOME-1-01 home shows seed values', (tester) async {
    final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
    expect(_loc(c), '/home');
    expect(_text('55%'), findsWidgets);
    expect(find.text('6 of 11 lessons · 2 courses'), findsOneWidget);
    expect(_text('26 / 40'), findsOneWidget);
    expect(find.text('BLS expires in 56 days'), findsOneWidget);
    expect(find.text('Renew before 12 Jan 2027'), findsOneWidget);
    expect(_text('14 credits to go · cycle ends 31 Dec'), findsOneWidget);
    expect(find.text('Resume: Team dynamics in resuscitation'), findsOneWidget);
    expect(find.text('Lesson 5 of 6'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('home.scores')),
      200,
      scrollable: find
          .descendant(
            of: find.byKey(const Key('home.list')),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    expect(_text('63%'), findsOneWidget);
    expect(_text('75%'), findsOneWidget);
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
    expect(find.text('Not requested'), findsOneWidget);
    expect(find.text('Approved'), findsOneWidget);
  });

  testWidgets('TC-CRS-1-01 catalogue: chips, search (EN and AR), prices', (
    tester,
  ) async {
    final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
    await _go(tester, c, AppRoutes.learn);
    expect(find.byKey(const Key('course.c1')), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('course.c3')),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    expect(_text('AED 300.00'), findsOneWidget);
    expect(find.text('+5% VAT'), findsOneWidget);

    await tester.tap(find.text('Infection control').first);
    await settle(tester);
    expect(find.byKey(const Key('course.c2')), findsOneWidget);
    expect(find.byKey(const Key('course.c1')), findsNothing);

    await tester.tap(find.text('All').first);
    await settle(tester);
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('catalogue.search')),
        matching: find.byType(TextField),
      ),
      'medic',
    );
    await settle(tester);
    expect(find.byKey(const Key('course.c3')), findsOneWidget);
    expect(find.byKey(const Key('course.c1')), findsNothing);

    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('catalogue.search')),
        matching: find.byType(TextField),
      ),
      'zzz',
    );
    await settle(tester);
    expect(find.text('No courses match'), findsOneWidget);

    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('catalogue.search')),
        matching: find.byType(TextField),
      ),
      '',
    );
    await settle(tester);
    await tester.tap(find.byKey(const Key('course.c1')));
    await settle(tester);
    expect(_loc(c), '/learn/c1');
    expect(await _actions(tester, c), contains('course.view'));
  });

  testWidgets('TC-CRS-1-02 Arabic search matches Arabic titles', (
    tester,
  ) async {
    final c = await pumpClinicalEdge(
      tester,
      prefs: <String, Object>{PrefKeys.locale: 'ar'},
      signedInAs: Role.learner,
    );
    await _go(tester, c, AppRoutes.learn);
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('catalogue.search')),
        matching: find.byType(TextField),
      ),
      'الأدوية',
    );
    await settle(tester);
    expect(find.byKey(const Key('course.c3')), findsOneWidget);
    expect(find.byKey(const Key('course.c1')), findsNothing);
  });

  testWidgets('TC-CRS-2-01 CTA labels and locked lessons', (tester) async {
    final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
    await _go(tester, c, AppRoutes.course('c1'));
    expect(find.text('Continue · lesson 5'), findsOneWidget);
    expect(find.text('Now'), findsOneWidget);
    await _go(tester, c, AppRoutes.course('c2'));
    expect(find.text('Continue · lesson 3'), findsOneWidget);
    await _go(tester, c, AppRoutes.course('c3'));
    expect(_text('Buy · AED 315.00'), findsOneWidget);
    expect(find.text('Locked'), findsNWidgets(4));
    await tester.tap(find.byKey(const Key('lesson.row.0')));
    await settle(tester);
    expect(_loc(c), '/learn/c3/checkout');
  });

  testWidgets('TC-CRS-2-02 CTA rule: start, continue, review, buy', (
    tester,
  ) async {
    final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
    final l = lookupAppLocalizations(const Locale('en'));
    final list = c.read(courseProgressListProvider).value!;
    final c1 = list.firstWhere((p) => p.course.id == 'c1');
    final c3 = list.firstWhere((p) => p.course.id == 'c3');
    expect(courseCta(l, c1), 'Continue · lesson 5');
    expect(
      courseCta(
        l,
        CourseProgress(course: c1.course, owned: true, doneLessonIds: const {}),
      ),
      'Start course',
    );
    expect(
      courseCta(
        l,
        CourseProgress(
          course: c1.course,
          owned: true,
          doneLessonIds: {for (final x in c1.course.lessons) x.id},
        ),
      ),
      'Review course',
    );
    expect(
      courseCta(l, c3).replaceAll(RegExp('[\u2066-\u2069]'), ''),
      'Buy · AED 315.00',
    );
  });

  testWidgets('TC-CRS-3-01 mark complete advances and updates everywhere', (
    tester,
  ) async {
    final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
    await _go(tester, c, AppRoutes.lesson('c1', 5));
    expect(find.byKey(const Key('lesson.pdf')), findsOneWidget);
    expect(find.text('Lesson 5 of 6 · PDF'), findsOneWidget);
    await tester.tap(find.byKey(const Key('lesson.complete')));
    await settle(tester);
    expect(find.byKey(const Key('lesson.reading')), findsOneWidget);
    final acts = await _actions(tester, c);
    expect(acts, contains('lesson.view'));
    expect(acts, contains('lesson.complete'));
    await _go(tester, c, AppRoutes.home);
    expect(find.text('7 of 11 lessons · 2 courses'), findsOneWidget);
    expect(_text('64%'), findsWidgets);
    expect(find.text('Lesson 6 of 6'), findsOneWidget);
  });

  testWidgets('TC-CRS-4-01 finishing c1 awards 4 credits (26 → 30)', (
    tester,
  ) async {
    final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
    await _go(tester, c, AppRoutes.lesson('c1', 5));
    await tester.tap(find.byKey(const Key('lesson.complete')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('lesson.complete')));
    await settle(tester);
    expect(find.text('Course complete'), findsOneWidget);
    expect(find.text('+4 CPD/CME credits added'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
    final audit = (await tester.runAsync(
      () => c.read(auditStoreProvider).list(),
    ))!;
    expect(audit.last.action, 'course.complete');
    expect(audit.last.target, 'Basic Life Support Refresher · +4 CPD');
    await tester.pump(const Duration(seconds: 5));
    await _go(tester, c, AppRoutes.home);
    expect(_text('30 / 40'), findsOneWidget);
    await _go(tester, c, AppRoutes.course('c1'));
    expect(find.text('Review course'), findsOneWidget);
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
        ('home', AppRoutes.home),
        ('catalogue', AppRoutes.learn),
        ('course_detail', AppRoutes.course('c1')),
        ('lesson_video', AppRoutes.lesson('c1', 1)),
        ('lesson_reading', AppRoutes.lesson('c1', 3)),
        ('lesson_pdf', AppRoutes.lesson('c1', 5)),
      ]) {
        testWidgets('$name golden ($theme $dir)', (tester) async {
          final c = await pumpClinicalEdge(
            tester,
            prefs: <String, Object>{
              PrefKeys.themeMode: theme,
              PrefKeys.locale: locale,
            },
            signedInAs: Role.learner,
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
