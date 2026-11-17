import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/mock_overrides.dart';
import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/core/notifications/local_notifier.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Phase 6 device check with the real notification plugin. Grant the
/// notification permission first (Android: `adb shell pm grant
/// ae.clinicaledge.clinical_edge android.permission.POST_NOTIFICATIONS`;
/// iOS: allow the prompt once), then run
/// `flutter test integration_test/reminders_test.dart -d <device>`.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> wait(WidgetTester t, [int ms = 100]) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
    await t.pump();
  }

  Future<void> waitFor(WidgetTester t, Finder f) async {
    for (var i = 0; i < 100 && f.evaluate().isEmpty; i++) {
      await wait(t);
    }
    expect(f, findsWidgets);
  }

  testWidgets('TC-CERT-E2E-01 simulate reminder posts a real local '
      'notification', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final c = ProviderContainer(
      overrides: mockOverrides(
        db: InMemoryLocalDb(),
        prefs: await SharedPreferences.getInstance(),
        notifier: PluginLocalNotifier(channelName: 'Expiry reminders'),
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
    await c
        .read(sessionProvider.notifier)
        .signIn(
          email: 'demo@demo-hospital.example',
          password: 'x',
          role: Role.learner,
        );
    await wait(tester, 1500);
    c.read(routerProvider).go(AppRoutes.certs);
    final simulate = find.byKey(const Key('certs.simulate'));
    await waitFor(tester, simulate);
    await tester.ensureVisible(simulate);
    await tester.tap(simulate);
    await waitFor(tester, find.text('BLS certificate expires in 56 days'));
    // Marker for the screenshot step; keep the app up while it is taken.
    debugPrint('CE_REMINDER_SHOWN');
    for (var i = 0; i < 100; i++) {
      await wait(tester);
    }
  });
}
