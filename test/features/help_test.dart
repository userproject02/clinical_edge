import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/settings/presentation/help_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app_harness.dart';

String _loc(ProviderContainer c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

Future<void> _openHelp(WidgetTester tester, ProviderContainer c) async {
  c.read(routerProvider).go(AppRoutes.profile);
  await settle(tester);
  final card = find.byKey(const Key('profile.help'));
  await tester.ensureVisible(card);
  await tester.tap(card);
  await settle(tester);
  // Pushed over Profile (go_router keeps the base location for pushes).
  expect(find.byKey(const Key('help.list')), findsOneWidget);
}

void main() {
  final en = lookupAppLocalizations(const Locale('en'));
  final ar = lookupAppLocalizations(const Locale('ar'));

  group('Help & user guide', () {
    test('TC-HELP-01 every role has its own guide plus shared topics', () {
      final ids = {
        for (final r in Role.values)
          r: helpTopicsFor(en, r).map((t) => t.id).toList(),
      };
      expect(ids[Role.learner], <String>[
        'home',
        'learn',
        'assess',
        'certs',
        'signoffs',
        'bell',
        'settings',
        'demo',
      ]);
      expect(ids[Role.supervisor], <String>[
        'queue',
        'review',
        'decided',
        'learn',
        'bell',
        'settings',
        'demo',
      ]);
      expect(ids[Role.admin], <String>[
        'cohort',
        'audit',
        'insights',
        'bell',
        'settings',
        'demo',
      ]);
      // Every topic has a title and at least one step, in both languages.
      for (final l in <AppLocalizations>[en, ar]) {
        for (final r in Role.values) {
          for (final t in helpTopicsFor(l, r)) {
            expect(t.title.trim(), isNotEmpty);
            expect(
              t.body.split('\n').where((s) => s.trim().isNotEmpty),
              isNotEmpty,
            );
          }
        }
      }
    });

    test('TC-HELP-02 /help is open to every role', () {
      for (final r in Role.values) {
        expect(RouteAccess.allows(r, AppRoutes.help), isTrue, reason: '$r');
      }
    });

    for (final (role, intro, topic) in <(Role, String, String)>[
      (Role.learner, en.helpIntroLearner, 'signoffs'),
      (Role.supervisor, en.helpIntroSupervisor, 'review'),
      (Role.admin, en.helpIntroAdmin, 'audit'),
    ]) {
      testWidgets('TC-HELP-03 ${role.name}: Profile → Help shows the '
          '${role.name} guide', (tester) async {
        final c = await pumpClinicalEdge(tester, signedInAs: role);
        await _openHelp(tester, c);
        expect(find.text('Help & user guide'), findsOneWidget);
        expect(find.text(intro), findsOneWidget);
        final card = find.byKey(Key('help.topic.$topic'));
        await tester.scrollUntilVisible(card, 200);
        expect(card, findsOneWidget);
        expect(tester.takeException(), isNull);

        // Back returns to Profile.
        await tester.tap(find.byTooltip('Back'));
        await settle(tester);
        expect(find.byKey(const Key('help.list')), findsNothing);
        expect(find.byKey(const Key('profile.help')), findsOneWidget);
        expect(_loc(c), AppRoutes.profile);
      });
    }

    testWidgets('TC-HELP-04 Arabic guide at 1.3× text: no overflow', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(
        tester,
        signedInAs: Role.learner,
        locale: 'ar',
      );
      tester.platformDispatcher.textScaleFactorTestValue = 1.3;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      c.read(routerProvider).go(AppRoutes.help);
      await settle(tester);
      expect(find.text(ar.titleHelp), findsOneWidget);
      expect(find.text(ar.helpIntroLearner), findsOneWidget);
      for (final t in helpTopicsFor(ar, Role.learner)) {
        await tester.scrollUntilVisible(
          find.byKey(Key('help.topic.${t.id}')),
          200,
        );
        expect(tester.takeException(), isNull, reason: t.id);
      }
    });
  });
}
