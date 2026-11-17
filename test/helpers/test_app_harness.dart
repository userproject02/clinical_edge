import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/mock_overrides.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Builds a container wired like `main.dart` (in-memory DB), restores the
/// session and pumps the full app. Pass the same [db] and [prefs] values to
/// simulate a restart.
Future<ProviderContainer> pumpClinicalEdge(
  WidgetTester tester, {
  InMemoryLocalDb? db,
  Map<String, Object>? prefs,
  String locale = 'en',
  Role? signedInAs,
  bool reduceMotion = true,
  Size size = const Size(390, 844),
}) async {
  SharedPreferences.setMockInitialValues(
    prefs ?? <String, Object>{PrefKeys.locale: locale},
  );
  final container = ProviderContainer(
    overrides: mockOverrides(
      db: db ?? InMemoryLocalDb(),
      prefs: await SharedPreferences.getInstance(),
    ),
  );
  addTearDown(container.dispose);
  // Real async work (seeding) must run outside the fake test zone.
  await tester.runAsync(() async {
    await container.read(sessionProvider.future);
    if (signedInAs != null) {
      await container
          .read(sessionProvider.notifier)
          .signIn(
            email: 'demo@demo-hospital.example',
            password: 'x',
            role: signedInAs,
          );
      container.read(firstHomeLoadProvider.notifier).done();
    }
  });
  if (reduceMotion) {
    // Looping decor (ECG line, bell pulse) never settles otherwise.
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
  }
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const ClinicalEdgeApp(showDebugMenu: false),
    ),
  );
  await settle(tester);
  return container;
}

/// Lets real async repository work finish and settles frames, alternating
/// real-time ticks with frames (some repository futures complete only on a
/// real event-loop turn, which pumpAndSettle alone never gives).
Future<void> settle(WidgetTester tester) async {
  var idle = 0;
  for (var i = 0; i < 40 && idle < 3; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 5)),
    );
    await tester.pump(const Duration(milliseconds: 50));
    idle = tester.binding.hasScheduledFrame ? 0 : idle + 1;
  }
}
