import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/app/state/session.dart';
import 'package:clinical_edge/app/state/theme_mode.dart';
import 'package:clinical_edge/core/role.dart';
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
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: const ClinicalEdgeApp(showDebugMenu: false),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Sign in'), findsWidgets);

    for (final role in Role.values) {
      c.read(sessionProvider.notifier).signIn(role);
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(NavigationBar), findsOneWidget);
    }

    await c.read(themeModeProvider.notifier).set(ThemeMode.dark);
    await c.read(localeProvider.notifier).set(const Locale('ar'));
    await tester.pump(const Duration(seconds: 1));
    final nav = tester.element(find.byType(NavigationBar));
    expect(Directionality.of(nav), TextDirection.rtl);
    expect(Theme.of(nav).brightness, Brightness.dark);
  });
}
