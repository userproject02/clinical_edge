import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/assessments/data/assessment_repository.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/features/assessments/domain/submit_attempt.dart';
import 'package:clinical_edge/features/assessments/presentation/assessment_providers.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app_harness.dart';
import '../helpers/test_container.dart';

const _layla = 'u-layla';

/// Correct option of q01–q08 (BLS draw order).
const _blsKey = <int>[2, 2, 1, 0, 3, 0, 0, 1];

String _loc(ProviderContainer c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

Future<void> _go(WidgetTester t, ProviderContainer c, String path) async {
  c.read(routerProvider).go(path);
  await settle(t);
}

Finder _text(String s) => find.byWidgetPredicate(
  (w) =>
      w is Text &&
      (w.data ?? '').replaceAll(RegExp('[\u2066-\u2069]'), '').contains(s),
);

Future<void> _tap(WidgetTester t, Finder f) async {
  await t.ensureVisible(f);
  await t.tap(f);
  await settle(t);
}

/// Answers the current question with option [i].
Future<void> _answer(WidgetTester t, int i) =>
    _tap(t, find.byKey(Key('quiz.option.$i')));

Future<void> _next(WidgetTester t) =>
    _tap(t, find.byKey(const Key('quiz.next')));

/// Answers every BLS question, getting [wrong] of them wrong.
Future<void> _runBls(WidgetTester t, {required Set<int> wrong}) async {
  for (var q = 0; q < 8; q++) {
    final right = _blsKey[q];
    await _answer(t, wrong.contains(q) ? (right + 1) % 4 : right);
    await _next(t);
  }
}

bool _enabled(WidgetTester t, Finder f) =>
    t.widget<PrimaryButton>(f).onPressed != null;

void main() {
  group('scoring (QZ-2)', () {
    test('TC-QZ-2-03 7/8 = 88% pass and 6/8 = 75% fail via SubmitAttempt '
        'with a quiz.score audit event', () async {
      final c = await mockContainer();
      final repo = c.read(assessmentRepositoryProvider);
      final quiz = await repo.quiz('bls');
      final qs = await repo.drawQuiz('bls');
      var n = 0;
      final submit = SubmitAttempt(
        repository: repo,
        logger: c.read(activityLoggerProvider),
        clock: c.read(clockProvider),
        newId: () => 'att-test-${n++}',
      );
      final seven = [..._blsKey]..[7] = 0;
      final pass = await submit(
        userId: _layla,
        quiz: quiz,
        questions: qs,
        answers: seven,
      );
      expect(pass.scorePct, 88);
      expect(pass.passed, isTrue);
      expect(pass.answers, seven);
      expect(pass.submittedAt, c.read(clockProvider).now().toUtc());

      final six = [..._blsKey]
        ..[6] = 1
        ..[7] = 0;
      final fail = await submit(
        userId: _layla,
        quiz: quiz,
        questions: qs,
        answers: six,
      );
      expect(fail.scorePct, 75);
      expect(fail.passed, isFalse);

      final history = await repo.history(_layla);
      expect(history.first.id, 'att-test-1');
      expect(history.map((a) => a.scorePct).take(2), <int>[75, 88]);

      final audit = (await c.read(auditStoreProvider).list())
          .where((e) => e.action == AuditAction.quizScore.wire)
          .map((e) => e.target)
          .toList();
      expect(
        audit,
        containsAll(<String>[
          'BLS Assessment · 88% (pass)',
          'BLS Assessment · 75% (fail)',
        ]),
      );
    });

    test('TC-QZ-2-04 all wrong = 0%, all right = 100%', () {
      expect(QuizRules.scorePct(0, 8), 0);
      expect(QuizRules.scorePct(8, 8), 100);
      expect(QuizRules.passed(0), isFalse);
      expect(QuizRules.scorePct(6, 7), 86);
    });
  });

  group('Assess tab (QZ-3)', () {
    test('TC-QZ-3-03 best score, attempt count and Attempt N numbering', () {
      QuizAttempt a(String id, int score, int day) => QuizAttempt(
        id: id,
        userId: _layla,
        quizId: 'bls',
        answers: const <int>[],
        scorePct: score,
        passed: QuizRules.passed(score),
        submittedAt: DateTime.utc(2026, 10, day),
      );
      final history = [a('c', 63, 30), a('b', 88, 20), a('a', 75, 2)];
      final card = QuizCardData(
        quiz: const Quiz(
          id: 'bls',
          courseId: 'c1',
          title: .new(en: 'BLS', ar: 'BLS'),
          subject: .new(en: 'BLS', ar: 'BLS'),
          topicOrder: <String>[],
          size: 8,
          passMarkPct: 80,
        ),
        bankSize: 20,
        unlocked: true,
        lessonsToUnlock: 6,
        attempts: history,
      );
      expect(card.best, 88);
      expect(attemptNumber(history, history[0]), 3);
      expect(attemptNumber(history, history[2]), 1);
    });

    testWidgets('TC-QZ-3-04 card, stats, history newest first, IPC locked', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.assess);
      expect(find.text('Basic Life Support'), findsOneWidget);
      expect(_text('8 questions · from a 20-question bank'), findsOneWidget);
      expect(find.text('Pass mark'), findsOneWidget);
      expect(_text('80%'), findsWidgets);
      final best = find.byKey(const Key('assess.best.bls'));
      expect(find.descendant(of: best, matching: _text('75%')), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(const Key('assess.attempts.bls')),
          matching: _text('2'),
        ),
        findsOneWidget,
      );
      final row0 = find.byKey(const Key('assess.history.0'));
      final row1 = find.byKey(const Key('assess.history.1'));
      await tester.ensureVisible(row1);
      expect(
        find.descendant(of: row0, matching: find.text('Attempt 2')),
        findsOneWidget,
      );
      expect(find.descendant(of: row0, matching: _text('75%')), findsWidgets);
      expect(
        find.descendant(of: row0, matching: _text('20 Oct 2026')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: row1, matching: find.text('Attempt 1')),
        findsOneWidget,
      );
      expect(find.descendant(of: row1, matching: _text('63%')), findsWidgets);
      await tester.ensureVisible(find.byKey(const Key('assess.locked.ipc')));
      expect(find.text('Infection Prevention & Control'), findsOneWidget);
      expect(find.text('Unlocks after all 5 lessons'), findsOneWidget);
      expect(find.byKey(const Key('assess.start.ipc')), findsNothing);
    });

    testWidgets('TC-QZ-3-05 IPC unlocks when c2 is complete and runs 7 '
        'infection-control questions', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await tester.runAsync(() async {
        final progress = c.read(progressRepositoryProvider);
        for (var i = 1; i <= 5; i++) {
          await progress.markComplete(_layla, 'c2-l$i');
        }
      });
      c.invalidate(lessonProgressProvider);
      await _go(tester, c, AppRoutes.assess);
      expect(find.byKey(const Key('assess.locked.ipc')), findsNothing);
      await _tap(tester, find.byKey(const Key('assess.start.ipc')));
      expect(_loc(c), '/assess/ipc/run');
      expect(_text('Question 1 of 7'), findsOneWidget);
      expect(find.byKey(const Key('quiz.prompt.q09')), findsOneWidget);
    });
  });

  group('Quiz (QZ-1) and result (QZ-2)', () {
    testWidgets('TC-QZ-1-03 header, no bottom nav, answer locks on first tap, '
        'explanation shows, Next enabled only after answering', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.assess);
      await _tap(tester, find.byKey(const Key('assess.start.bls')));
      expect(_loc(c), '/assess/bls/run');
      expect(find.byType(NavigationBar), findsNothing);
      expect(_text('Question 1 of 8'), findsOneWidget);
      expect(_text('Pass 80%'), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('D'), findsOneWidget);
      final next = find.byKey(const Key('quiz.next'));
      expect(_enabled(tester, next), isFalse);
      expect(find.byKey(const Key('quiz.explanation.q01')), findsNothing);

      await _answer(tester, 0); // wrong (correct is C)
      expect(find.text('Not quite'), findsOneWidget);
      expect(
        _text('Explanation: Compress at 100–120 per minute.'),
        findsOneWidget,
      );
      expect(_enabled(tester, next), isTrue);
      final run = c.read(quizRunProvider('bls')).value!;
      expect(run.answers.first, 0);

      await _answer(tester, 2); // ignored: the answer is locked
      expect(c.read(quizRunProvider('bls')).value!.answers.first, 0);
      expect(find.text('Not quite'), findsOneWidget);
      expect(find.text('Correct'), findsNothing);

      await _next(tester);
      expect(_text('Question 2 of 8'), findsOneWidget);
      await _answer(tester, _blsKey[1]);
      expect(find.text('Correct'), findsOneWidget);
      expect(find.byKey(const Key('quiz.check')), findsOneWidget);
    });

    testWidgets('TC-QZ-2-05 7/8 → 88% passed; history, best and Home update; '
        'quiz.score audit; Done and Retake', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.assess);
      await _tap(tester, find.byKey(const Key('assess.start.bls')));
      for (var q = 0; q < 7; q++) {
        await _answer(tester, _blsKey[q]);
        await _next(tester);
      }
      await _answer(tester, (_blsKey[7] + 1) % 4);
      expect(find.text('See results'), findsOneWidget);
      await _next(tester);

      expect(find.byKey(const Key('quiz.result')), findsOneWidget);
      expect(_text('88%'), findsWidgets);
      expect(_text('7 / 8 correct'), findsOneWidget);
      expect(find.text('Passed'), findsOneWidget);
      expect(find.text('Assessment passed'), findsOneWidget);
      expect(find.text('Recorded to audit trail'), findsOneWidget);
      expect(_text('quiz.score'), findsOneWidget);

      final audit = await tester.runAsync(
        () => c.read(auditStoreProvider).list(),
      );
      expect(
        audit!.where((e) => e.action == 'quiz.score').map((e) => e.target),
        contains('BLS Assessment · 88% (pass)'),
      );

      await _tap(tester, find.byKey(const Key('result.done')));
      expect(_loc(c), '/assess');
      final best = find.byKey(const Key('assess.best.bls'));
      expect(find.descendant(of: best, matching: _text('88%')), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(const Key('assess.attempts.bls')),
          matching: _text('3'),
        ),
        findsOneWidget,
      );
      final row0 = find.byKey(const Key('assess.history.0'));
      await tester.ensureVisible(row0);
      expect(
        find.descendant(of: row0, matching: find.text('Attempt 3')),
        findsOneWidget,
      );
      expect(find.descendant(of: row0, matching: _text('88%')), findsWidgets);

      await _go(tester, c, AppRoutes.home);
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
      expect(
        find.descendant(
          of: find.byKey(const Key('home.scores')),
          matching: _text('88%'),
        ),
        findsWidgets,
      );

      // Retake starts a fresh attempt.
      await _go(tester, c, AppRoutes.quiz('bls'));
      await _runBls(tester, wrong: <int>{0, 1});
      expect(_text('75%'), findsWidgets);
      expect(find.text('Below pass mark'), findsOneWidget);
      expect(find.text('Not passed this time'), findsOneWidget);
      await _tap(tester, find.byKey(const Key('result.retake')));
      expect(_text('Question 1 of 8'), findsOneWidget);
      expect(_enabled(tester, find.byKey(const Key('quiz.next'))), isFalse);
    });

    testWidgets('TC-QZ-1-04 leaving mid-quiz asks for confirmation', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.assess);
      await _tap(tester, find.byKey(const Key('assess.start.bls')));
      await _answer(tester, 2);
      await _tap(tester, find.byTooltip('Back'));
      expect(find.text('Leave assessment?'), findsOneWidget);
      expect(find.text('Your answers will be lost.'), findsOneWidget);
      await _tap(tester, find.byKey(const Key('quiz.leave.stay')));
      expect(_loc(c), '/assess/bls/run');
      expect(find.text('Leave assessment?'), findsNothing);

      await _tap(tester, find.byTooltip('Back'));
      await _tap(tester, find.byKey(const Key('quiz.leave.confirm')));
      expect(_loc(c), '/assess');
      final history = await tester.runAsync(
        () => c.read(assessmentRepositoryProvider).history(_layla),
      );
      expect(history, hasLength(2), reason: 'nothing saved');
    });

    testWidgets('TC-QZ-1-05 Arabic: questions from seed and أ ب ج د badges', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(
        tester,
        signedInAs: Role.learner,
        locale: 'ar',
      );
      await _go(tester, c, AppRoutes.quiz('bls'));
      expect(
        find.text(
          'ما معدل الضغطات الصدرية الموصى به للبالغ المصاب بسكتة قلبية؟',
        ),
        findsOneWidget,
      );
      for (final letter in <String>['أ', 'ب', 'ج', 'د']) {
        expect(find.text(letter), findsOneWidget);
      }
      await _answer(tester, 2);
      expect(find.text('إجابة صحيحة'), findsOneWidget);
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
      for (final (name, play)
          in <(String, Future<void> Function(WidgetTester))>[
            ('assess', (_) async {}),
            ('quiz_unanswered', (_) async {}),
            ('quiz_correct', (t) => _answer(t, _blsKey[0])),
            ('quiz_wrong', (t) => _answer(t, 0)),
            ('result_pass', (t) => _runBls(t, wrong: <int>{7})),
            ('result_fail', (t) => _runBls(t, wrong: <int>{6, 7})),
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
          await _go(
            tester,
            c,
            name == 'assess' ? AppRoutes.assess : AppRoutes.quiz('bls'),
          );
          await play(tester);
          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile('goldens/${name}_${theme}_$dir.png'),
          );
        }, tags: <String>['golden']);
      }
    }
  });
}
