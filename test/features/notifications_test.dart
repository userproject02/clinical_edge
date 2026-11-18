import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/notifications/domain/inbox_item.dart';
import 'package:clinical_edge/features/notifications/presentation/inbox_providers.dart';
import 'package:clinical_edge/features/notifications/presentation/inbox_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app.dart';
import '../helpers/test_app_harness.dart';

String _loc(ProviderContainer c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

Finder get _bell => find.byTooltip('Notifications');

Finder get _sheet => find.byKey(const Key('inbox.sheet'));

/// The bell's unread dot (a sibling of the bell button in its stack).
Finder get _dot => find.descendant(
  of: find.ancestor(of: _bell, matching: find.byType(Stack)).first,
  matching: find.byType(PulsingDot),
);

Finder _inSheet(String text) => find.descendant(
  of: _sheet,
  matching: find.byWidgetPredicate(
    (w) =>
        w is Text &&
        (w.data ?? '').replaceAll(RegExp(r'[\u2066-\u2069]'), '') == text,
  ),
);

Future<void> _openBell(WidgetTester tester) async {
  await tester.tap(_bell);
  await settle(tester);
  expect(_sheet, findsOneWidget);
}

/// Item titles in the sheet, top to bottom.
List<String> _titles(WidgetTester tester) {
  final tiles = find.descendant(
    of: _sheet,
    matching: find.byWidgetPredicate(
      (w) => w is InkWell && '${w.key}'.contains('inbox.item.'),
    ),
  );
  return <String>[
    for (final e in tiles.evaluate())
      tester
          .widgetList<Text>(
            find.descendant(
              of: find.byWidget(e.widget),
              matching: find.byType(Text),
            ),
          )
          .first
          .data!,
  ];
}

void main() {
  group('Notifications (bell)', () {
    testWidgets('TC-NOTIF-01 learner: reminders and decisions; dot clears; '
        'tap opens Certs', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      expect(_dot, findsOneWidget);

      await _openBell(tester);
      final titles = _titles(tester);
      expect(titles.first, 'BLS certificate expires in 56 days');
      expect(titles, contains('Neonatal resuscitation skills approved'));
      expect(
        _inSheet('Decided by Dr. Omar Al Mansoori on 28 Oct 2026.'),
        findsOneWidget,
      );
      // Everything is new on the first open.
      expect(
        find.descendant(of: _sheet, matching: find.text('New')),
        findsNWidgets(titles.length),
      );

      await tester.tap(_inSheet('BLS certificate expires in 56 days'));
      await settle(tester);
      expect(_sheet, findsNothing);
      expect(_loc(c), AppRoutes.certs);
      // Seen: no dot, and no "New" tags next time.
      expect(_dot, findsNothing);
      await _openBell(tester);
      expect(
        find.descendant(of: _sheet, matching: find.text('New')),
        findsNothing,
      );
    });

    testWidgets('TC-NOTIF-02 supervisor: pending requests, newest first; '
        'tap opens the review', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.supervisor);
      expect(_dot, findsOneWidget);
      await _openBell(tester);
      expect(_titles(tester), <String>[
        'Aisha Rahman requested sign-off',
        'Mariam Saeed requested sign-off',
      ]);
      expect(
        _inSheet('Peripheral IV cannulation · requested 16 Nov 2026'),
        findsOneWidget,
      );
      await tester.tap(_inSheet('Aisha Rahman requested sign-off'));
      await settle(tester);
      expect(_loc(c), startsWith('${AppRoutes.queue}/'));
      expect(find.text('Review sign-off'), findsOneWidget);
    });

    testWidgets('TC-NOTIF-03 admin: cohort expiries soonest first, then '
        'pending sign-offs', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.admin);
      await _openBell(tester);
      expect(_titles(tester), <String>[
        'Dr. Yousef Nasser: BLS expires in 12 days',
        'Mariam Saeed: NRP expires in 47 days',
        'Dr. Layla Haddad: BLS expires in 56 days',
        '2 sign-offs awaiting supervisors',
      ]);
      await tester.tap(_inSheet('2 sign-offs awaiting supervisors'));
      await settle(tester);
      expect(_loc(c), AppRoutes.cohort);
    });

    testWidgets('TC-NOTIF-04 Arabic: localized items, no overflow', (
      tester,
    ) async {
      await pumpClinicalEdge(tester, signedInAs: Role.admin, locale: 'ar');
      await tester.tap(find.byTooltip('الإشعارات'));
      await settle(tester);
      expect(
        find.descendant(of: _sheet, matching: find.textContaining('BLS')),
        findsWidgets,
      );
      expect(
        find.descendant(
          of: _sheet,
          matching: find.textContaining('بانتظار المشرفين'),
        ),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('TC-NOTIF-05 nothing to report: empty state, no dot', (
      tester,
    ) async {
      await pumpTestApp(
        tester,
        ProviderScope(
          overrides: [
            inboxProvider.overrideWith((ref) async => const <InboxItem>[]),
          ],
          child: Consumer(
            builder: (context, ref, _) => Column(
              children: <Widget>[
                Text('unread: ${ref.watch(inboxUnreadProvider)}'),
                const Expanded(child: InboxSheet()),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('inbox.empty')), findsOneWidget);
      expect(find.text("You're all caught up"), findsOneWidget);
      expect(find.text('unread: false'), findsOneWidget);
    });
  });
}
