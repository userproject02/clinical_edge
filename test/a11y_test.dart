import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_app_harness.dart';

Future<void> _go(WidgetTester t, ProviderContainer c, String path) async {
  c.read(routerProvider).go(path);
  await settle(t);
}

Future<void> _guidelines(WidgetTester tester, String where) async {
  await expectLater(
    tester,
    meetsGuideline(androidTapTargetGuideline),
    reason: '$where: Android tap targets',
  );
  await expectLater(
    tester,
    meetsGuideline(iOSTapTargetGuideline),
    reason: '$where: iOS tap targets',
  );
  await expectLater(
    tester,
    meetsGuideline(labeledTapTargetGuideline),
    reason: '$where: labelled tap targets',
  );
  await expectLater(
    tester,
    meetsGuideline(textContrastGuideline),
    reason: '$where: text contrast',
  );
}

void main() {
  for (final theme in ['light', 'dark']) {
    group('A11y guidelines ($theme)', () {
      testWidgets('TC-NFR-A11Y-01 sign-in', (tester) async {
        final handle = tester.ensureSemantics();
        await pumpClinicalEdge(
          tester,
          prefs: <String, Object>{PrefKeys.themeMode: theme},
        );
        await _guidelines(tester, 'sign-in');
        handle.dispose();
      });

      for (final (role, path) in <(Role, String)>[
        (Role.learner, AppRoutes.home),
        (Role.learner, AppRoutes.quiz('bls')),
        (Role.learner, AppRoutes.checkout('c3')),
        (Role.learner, AppRoutes.certs),
        (Role.supervisor, AppRoutes.queue),
        (Role.admin, AppRoutes.cohort),
      ]) {
        testWidgets('TC-NFR-A11Y-01 $path', (tester) async {
          final handle = tester.ensureSemantics();
          final c = await pumpClinicalEdge(
            tester,
            prefs: <String, Object>{PrefKeys.themeMode: theme},
            signedInAs: role,
          );
          await _go(tester, c, path);
          await _guidelines(tester, path);
          handle.dispose();
        });
      }
    });
  }

  group('Text scaling 1.3×', () {
    for (final (role, path) in <(Role, String)>[
      (Role.learner, AppRoutes.home),
      (Role.learner, AppRoutes.learn),
      (Role.learner, AppRoutes.course('c1')),
      (Role.learner, AppRoutes.assess),
      (Role.learner, AppRoutes.quiz('bls')),
      (Role.learner, AppRoutes.certs),
      (Role.learner, AppRoutes.signoffs),
      (Role.learner, AppRoutes.checkout('c3')),
      (Role.learner, AppRoutes.profile),
      (Role.supervisor, AppRoutes.queue),
      (Role.supervisor, AppRoutes.decided),
      (Role.admin, AppRoutes.cohort),
      (Role.admin, AppRoutes.audit),
      (Role.admin, AppRoutes.insights),
    ]) {
      for (final locale in ['en', 'ar']) {
        testWidgets('TC-NFR-A11Y-02 $path at 1.3× ($locale), no overflow', (
          tester,
        ) async {
          tester.platformDispatcher.textScaleFactorTestValue = 1.3;
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
          final c = await pumpClinicalEdge(
            tester,
            locale: locale,
            signedInAs: role,
          );
          await _go(tester, c, path);
          // Layout overflow is reported as a FlutterError and fails the test.
          expect(tester.takeException(), isNull);
        });
      }
    }
  });
}
