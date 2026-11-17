import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/mock_overrides.dart';
import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/core/logging/audit_chain.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/sharing/file_sharer.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/certifications/data/certification_repository.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/checkout/data/checkout_repository.dart';
import 'package:clinical_edge/features/competencies/data/competency_repository.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// TC-E2E-01: the full demo journey across the three roles, run on a
/// device: `flutter test integration_test/demo_journey_test.dart -d <id>`.
/// Runs twice: English + light and Arabic + dark. Assertions read stored
/// data, so they hold in both languages.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const layla = 'u-layla';
  const blsKey = <int>[2, 2, 1, 0, 3, 0, 0, 1];

  Future<void> wait(WidgetTester t, [int ms = 120]) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
    await t.pump();
  }

  Future<void> waitFor(WidgetTester t, Finder f, {int seconds = 15}) async {
    for (var i = 0; i < seconds * 8 && f.evaluate().isEmpty; i++) {
      await wait(t);
    }
    expect(f, findsWidgets);
  }

  Future<void> tap(WidgetTester t, Finder f) async {
    await waitFor(t, f);
    await t.ensureVisible(f.first);
    await wait(t);
    await t.tap(f.first);
    await wait(t, 400);
  }

  for (final (locale, theme) in <(String, String)>[
    ('en', 'light'),
    ('ar', 'dark'),
  ]) {
    testWidgets('TC-E2E-01 demo journey ($locale, $theme)', (tester) async {
      // The test, not the device keyboard, owns text input; otherwise the
      // Android IME can overwrite entered text when focus changes.
      tester.testTextInput.register();
      addTearDown(tester.testTextInput.unregister);
      SharedPreferences.setMockInitialValues(<String, Object>{
        PrefKeys.locale: locale,
        PrefKeys.themeMode: theme,
      });
      final sharer = RecordingFileSharer();
      final c = ProviderContainer(
        overrides: mockOverrides(
          db: InMemoryLocalDb(),
          prefs: await SharedPreferences.getInstance(),
          sharer: sharer,
        ),
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: const ClinicalEdgeApp(showDebugMenu: false),
        ),
      );
      await c.read(sessionProvider.future);
      Future<void> go(String path) async {
        c.read(routerProvider).go(path);
        await wait(tester, 600);
      }

      // 1. Learner signs in.
      await waitFor(tester, find.byKey(const Key('signIn.submit')));
      await tap(tester, find.byKey(const Key('signIn.submit')));
      await waitFor(tester, find.byType(NavigationBar));
      expect(c.read(sessionProvider).value!.role, Role.learner);

      // 2. Finish c1 lessons 5–6: credits 26 → 30.
      final cpd = c.read(cpdRepositoryProvider);
      expect(await cpd.total(layla), 26);
      for (final n in [5, 6]) {
        await go(AppRoutes.lesson('c1', n));
        await tap(tester, find.byKey(const Key('lesson.complete')));
        await wait(tester, 800);
      }
      expect(await cpd.total(layla), 30);

      // 3. BLS quiz, 7/8 → pass.
      await go(AppRoutes.quiz('bls'));
      for (var q = 0; q < 8; q++) {
        final pick = q == 7 ? (blsKey[q] + 1) % 4 : blsKey[q];
        await tap(tester, find.byKey(Key('quiz.option.$pick')));
        await tap(tester, find.byKey(const Key('quiz.next')));
      }
      await waitFor(tester, find.byKey(const Key('quiz.result')));
      await tap(tester, find.byKey(const Key('result.done')));

      // 4. Upload NRP → Verifying.
      await go(AppRoutes.certs);
      await tap(tester, find.byKey(const Key('certs.upload')));
      await tap(tester, find.byKey(const Key('upload.dropZone')));
      await tester.enterText(
        find.byKey(const Key('upload.name')),
        'Neonatal Resuscitation Program (NRP)',
      );
      FocusManager.instance.primaryFocus?.unfocus();
      await wait(tester, 800);
      await tap(tester, find.byKey(const Key('upload.expires')));
      // Date picker confirm button (last action, any language).
      await tap(tester, find.byType(TextButton).last);
      await tap(tester, find.byKey(const Key('upload.submit')));
      await wait(tester, 4500);
      final certs = await c.read(certificationRepositoryProvider).list(layla);
      expect(
        certs.where((x) => x.verification == Verification.pending),
        hasLength(1),
      );

      // 5. Request IV cannulation sign-off.
      await go(AppRoutes.signoffs);
      await tap(tester, find.byKey(const Key('signoff.cl1.request')));
      // Let the snackbar leave before the next screen's bottom button.
      await wait(tester, 4500);
      final comp = c.read(competencyRepositoryProvider);
      expect((await comp.byId('so-001'))!.status, SignOffStatus.pending);

      // 6. Buy Medication Safety (AED 315.00) by card.
      await go(AppRoutes.checkout('c3'));
      await waitFor(tester, find.byKey(const Key('checkout.number')));
      await tester.enterText(
        find.byKey(const Key('checkout.number')),
        '4242424242424242',
      );
      await tester.enterText(find.byKey(const Key('checkout.expiry')), '1228');
      await tester.enterText(find.byKey(const Key('checkout.cvc')), '123');
      // Close the soft keyboard first (Android resizes the page under it).
      FocusManager.instance.primaryFocus?.unfocus();
      await wait(tester, 1200);
      await tap(tester, find.byKey(const Key('checkout.pay')));
      await waitFor(tester, find.byKey(const Key('receipt.list')));
      final orders = await c.read(checkoutRepositoryProvider).receipts(layla);
      expect(orders.single.totalFils, 31500);
      expect(
        await c.read(courseRepositoryProvider).isOwned(layla, 'c3'),
        isTrue,
      );

      // 7. Switch language and back.
      final other = locale == 'en' ? 'ar' : 'en';
      await c.read(localeProvider.notifier).set(Locale(other));
      await wait(tester, 800);
      await c.read(localeProvider.notifier).set(Locale(locale));
      await wait(tester, 800);

      // 8. Supervisor: reject without comment is blocked, then approve.
      await c.read(sessionProvider.notifier).switchRole(Role.supervisor);
      await wait(tester, 1200);
      await go(AppRoutes.review('so-001'));
      await tap(tester, find.byKey(const Key('review.reject')));
      expect((await comp.byId('so-001'))!.status, SignOffStatus.pending);
      await tap(tester, find.byKey(const Key('review.approve')));
      await wait(tester, 1500);
      expect((await comp.byId('so-001'))!.status, SignOffStatus.approved);

      // 9. Admin: every journey audit action is in a verified chain;
      // export CSV.
      await c.read(sessionProvider.notifier).switchRole(Role.admin);
      await wait(tester, 1200);
      await go(AppRoutes.audit);
      await waitFor(tester, find.byKey(const Key('audit.chain.ok')));
      await tap(tester, find.byKey(const Key('audit.export')));
      await wait(tester, 1500);
      expect(sharer.shared, hasLength(1));
      final audit = await c.read(auditStoreProvider).list();
      expect(AuditChain.verify(audit), isA<ChainOk>());
      final actions = audit.map((e) => e.action).toSet();
      expect(
        actions,
        containsAll(<String>[
          'course.complete',
          'quiz.score',
          'cert.upload',
          'signoff.request',
          'purchase',
          'role.change',
          'signoff.decision',
          'audit.export',
        ]),
      );
      final usage = (await c.read(usageStoreProvider).list())
          .map((e) => e.action)
          .toSet();
      expect(
        usage,
        containsAll(<String>[
          'auth.signin',
          'lesson.view',
          'lesson.complete',
          'checkout.start',
        ]),
      );
      debugPrint(
        'TC-E2E-01 ($locale, $theme) OK: ${audit.length} audit events',
      );
    });
  }
}
