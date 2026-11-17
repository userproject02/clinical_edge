import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('TC-PH0-02 app boots to the sign-in placeholder', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const ClinicalEdgeApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ClinicalEdge'), findsOneWidget);
    expect(find.text('Sign in'), findsWidgets);
    expect(find.bySemanticsLabel('Debug menu'), findsOneWidget);
  });
}
