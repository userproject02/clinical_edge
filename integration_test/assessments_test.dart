import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/mock_overrides.dart';
import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Phase 5 device check: run with
/// `flutter test integration_test -d <iOS simulator | Android emulator>`.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> wait(WidgetTester t, [int ms = 900]) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
    await t.pump();
  }

  /// Pumps real time until [f] appears (data loads asynchronously).
  Future<void> waitFor(WidgetTester t, Finder f) async {
    for (var i = 0; i < 100 && f.evaluate().isEmpty; i++) {
      await wait(t, 100);
    }
    expect(f, findsWidgets);
  }

  testWidgets('TC-QZ-E2E-01 BLS quiz on device: 7/8 → 88% passed', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();
    final c = ProviderContainer(
      overrides: mockOverrides(db: InMemoryLocalDb(), prefs: prefs),
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: const ClinicalEdgeApp(showDebugMenu: false),
      ),
    );
    await c.read(sessionProvider.future);
    await c
        .read(sessionProvider.notifier)
        .signIn(
          email: 'demo@demo-hospital.example',
          password: 'x',
          role: Role.learner,
        );
    await wait(tester, 1500);
    c.read(routerProvider).go(AppRoutes.assess);
    await wait(tester, 1500);
    await waitFor(tester, find.byKey(const Key('assess.start.bls')));
    await tester.tap(find.byKey(const Key('assess.start.bls')));
    await wait(tester);
    expect(find.byType(NavigationBar), findsNothing);

    const key = <int>[2, 2, 1, 0, 3, 0, 0, 1];
    for (var q = 0; q < 8; q++) {
      final pick = q == 7 ? (key[q] + 1) % 4 : key[q];
      final option = find.byKey(Key('quiz.option.$pick'));
      await waitFor(tester, option);
      await tester.ensureVisible(option);
      await tester.tap(option);
      await wait(tester);
      await tester.tap(find.byKey(const Key('quiz.next')));
      await wait(tester, 1500);
    }
    await waitFor(tester, find.text('Assessment passed'));
    expect(find.text('Passed'), findsOneWidget);

    await tester.tap(find.byKey(const Key('result.done')));
    await wait(tester, 1500);
    await waitFor(tester, find.text('Attempt 3'));
    expect(find.text('Attempt 3'), findsOneWidget);
  });
}
