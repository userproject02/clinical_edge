import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/mock_overrides.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/theme_mode.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Phase 1 device check: run with
/// `flutter test integration_test -d <iOS simulator | Android emulator>`.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('TC-PH1-51 scaffold on device: roles, dark mode, Arabic RTL', (
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
    await _settleLive(tester);
    expect(find.text('Sign in'), findsWidgets);

    await c.read(sessionProvider.future);
    for (final role in Role.values) {
      await c
          .read(sessionProvider.notifier)
          .signIn(
            email: 'demo@demo-hospital.example',
            password: 'x',
            role: role,
          );
      await Future<void>.delayed(const Duration(seconds: 1));
      await tester.pump();
      expect(find.byType(NavigationBar), findsOneWidget);
    }

    await c.read(themeModeProvider.notifier).set(ThemeMode.dark);
    await c.read(localeProvider.notifier).set(const Locale('ar'));
    await _settleLive(tester);
    final nav = tester.element(find.byType(NavigationBar));
    expect(Directionality.of(nav), TextDirection.rtl);
    expect(Theme.of(nav).brightness, Brightness.dark);
  });
}

/// Pumps frames in real time for about a second (on a device, animations
/// such as the theme cross-fade start on the first frame and need more).
Future<void> _settleLive(WidgetTester tester) async {
  for (var i = 0; i < 12; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await tester.pump();
  }
}
