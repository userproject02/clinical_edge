import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app_harness.dart';

Session _as(Role role) {
  const t = LocalizedText(en: 'x', ar: 'س');
  return Session(
    user: AppUser(
      id: SeedUsers.forRole(role),
      name: t,
      shortName: t,
      title: t,
      department: 'er',
      email: 'x@demo-hospital.example',
      role: role,
      initials: 'XX',
    ),
    role: role,
  );
}

const Session? _out = null;
final Session _learner = _as(Role.learner);
final Session _supervisor = _as(Role.supervisor);
final Session _admin = _as(Role.admin);

String? _r(Session? s, String path) => redirectFor(s, Uri.parse(path));

Future<ProviderContainer> _pumpApp(
  WidgetTester tester, {
  Role? signedInAs,
  String locale = 'en',
}) => pumpClinicalEdge(tester, signedInAs: signedInAs, locale: locale);

Future<void> _signInAs(
  WidgetTester tester,
  ProviderContainer c,
  Role role,
) async {
  await tester.runAsync(
    () => c
        .read(sessionProvider.notifier)
        .signIn(email: 'x@demo-hospital.example', password: 'x', role: role),
  );
  c.read(firstHomeLoadProvider.notifier).done();
  await settle(tester);
}

String _location(ProviderContainer c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

void main() {
  group('redirectFor', () {
    test('TC-PH1-38 signed out always lands on /sign-in', () {
      expect(_r(_out, '/home'), AppRoutes.signIn);
      expect(_r(_out, '/queue/q1'), AppRoutes.signIn);
      expect(_r(_out, '/sign-in'), isNull);
    });

    test('TC-PH1-39 signed in: /sign-in and / go to the role home', () {
      expect(_r(_learner, '/sign-in'), '/home');
      expect(_r(_supervisor, '/sign-in'), '/queue');
      expect(_r(_admin, '/'), '/cohort');
    });

    test('TC-PH1-40 wrong role → that role home', () {
      expect(_r(_learner, '/queue'), '/home');
      expect(_r(_learner, '/audit'), '/home');
      expect(_r(_supervisor, '/home'), '/queue');
      expect(_r(_supervisor, '/learn/c1/checkout'), '/queue');
      expect(_r(_supervisor, '/learn/c1/lesson/2'), '/queue');
      expect(_r(_admin, '/learn'), '/cohort');
      expect(_r(_admin, '/certs/upload'), '/cohort');
    });

    test('TC-PH1-41 allowed routes pass through', () {
      for (final p in <String>[
        '/home',
        '/learn',
        '/learn/c1',
        '/learn/c1/lesson/3',
        '/learn/c3/checkout',
        '/learn/c3/receipt/o1',
        '/assess',
        '/assess/bls/run',
        '/certs',
        '/certs/upload',
        '/signoffs',
        '/profile',
      ]) {
        expect(_r(_learner, p), isNull, reason: p);
      }
      for (final p in <String>[
        '/queue',
        '/queue/q1',
        '/decided',
        '/learn',
        '/learn/c1',
        '/profile',
      ]) {
        expect(_r(_supervisor, p), isNull, reason: p);
      }
      for (final p in <String>['/cohort', '/audit', '/insights', '/profile']) {
        expect(_r(_admin, p), isNull, reason: p);
      }
    });
  });

  group('app routing', () {
    testWidgets('TC-PH1-42 signed out starts on sign-in', (tester) async {
      final c = await _pumpApp(tester);
      expect(_location(c), AppRoutes.signIn);
      expect(find.text('Sign in'), findsWidgets);
    });

    testWidgets('TC-PH1-43 each role gets its own tabs', (tester) async {
      final c = await _pumpApp(tester, signedInAs: Role.learner);
      expect(_location(c), '/home');
      final bar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(bar.destinations, hasLength(5));
      for (final label in <String>[
        'Home',
        'Learn',
        'Assess',
        'Certs',
        'Sign-offs',
      ]) {
        expect(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text(label),
          ),
          findsOneWidget,
        );
      }

      await _signInAs(tester, c, Role.supervisor);
      expect(_location(c), '/queue');
      expect(find.byKey(const Key('queue.list')), findsOneWidget);
      expect(
        tester.widget<NavigationBar>(find.byType(NavigationBar)).destinations,
        hasLength(3),
      );

      await _signInAs(tester, c, Role.admin);
      expect(_location(c), '/cohort');
      expect(find.text('Cohort dashboard'), findsWidgets);
    });

    testWidgets('TC-PH1-44 supervisor /learn opens the supervisor Learn tab', (
      tester,
    ) async {
      final c = await _pumpApp(tester, signedInAs: Role.supervisor);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Learn'),
        ),
      );
      await settle(tester);
      expect(_location(c), '/learn');
      final bar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(bar.selectedIndex, 2);
      expect(bar.destinations, hasLength(3));
    });

    testWidgets('TC-PH1-45 back from a detail selects the tab it belongs to', (
      tester,
    ) async {
      final c = await _pumpApp(tester, signedInAs: Role.learner);
      expect(
        tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
        0,
      );
      c.read(routerProvider).go(AppRoutes.course('c1'));
      await settle(tester);
      expect(find.text('Basic Life Support Refresher'), findsWidgets);
      await tester.tap(find.byTooltip('Back'));
      await settle(tester);
      expect(_location(c), '/learn');
      expect(
        tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
        1,
      );
      expect(find.text('Courses'), findsWidgets);
    });

    testWidgets('TC-PH1-46 tab state is kept when switching tabs', (
      tester,
    ) async {
      final c = await _pumpApp(tester, signedInAs: Role.learner);
      c.read(routerProvider).go(AppRoutes.course('c1'));
      await settle(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Home'),
        ),
      );
      await settle(tester);
      expect(_location(c), '/home');
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Learn'),
        ),
      );
      await settle(tester);
      expect(_location(c), '/learn/c1');
    });

    testWidgets('TC-PH1-47 avatar pushes /profile; upload opens a sheet', (
      tester,
    ) async {
      final c = await _pumpApp(tester, signedInAs: Role.learner);
      await tester.tap(find.bySemanticsLabel('Profile and settings'));
      await settle(tester);
      expect(find.text('Profile & settings'), findsWidgets);
      await tester.tap(find.byTooltip('Back'));
      await settle(tester);

      c.read(routerProvider).go(AppRoutes.certUpload);
      await settle(tester);
      expect(find.byType(AppBottomSheet), findsOneWidget);
      expect(find.text('Upload certificate'), findsOneWidget);
    });

    testWidgets('TC-PH1-48 Arabic mirrors the whole app (RTL)', (tester) async {
      final c = await _pumpApp(tester, signedInAs: Role.learner, locale: 'ar');
      expect(c.read(localeProvider), const Locale('ar'));
      final title = find.text('الرئيسية').first;
      expect(Directionality.of(tester.element(title)), TextDirection.rtl);
      // First tab sits on the right in RTL.
      final home = tester.getCenter(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('الرئيسية'),
        ),
      );
      final signoffs = tester.getCenter(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('الاعتمادات'),
        ),
      );
      expect(home.dx, greaterThan(signoffs.dx));

      c.read(routerProvider).go(AppRoutes.course('c1'));
      await settle(tester);
      final back = tester.getRect(find.byTooltip('رجوع'));
      expect(back.left, greaterThan(195), reason: 'back arrow on the right');
    });

    testWidgets('TC-PH1-49 every remaining placeholder shows its title', (
      tester,
    ) async {
      final c = await _pumpApp(tester, signedInAs: Role.learner);
      final router = c.read(routerProvider);
      final expected = <String, String>{
        '/learn/c3/checkout': 'Checkout',
        '/learn/c3/receipt/o1': 'Receipt',
      };
      for (final MapEntry(key: path, value: title) in expected.entries) {
        router.go(path);
        await settle(tester);
        expect(find.text(title), findsWidgets, reason: path);
        expect(find.text(path), findsOneWidget, reason: path);
      }
      await _signInAs(tester, c, Role.supervisor);
      c.read(routerProvider).go('/queue/q1');
      await settle(tester);
      expect(find.text('Review sign-off'), findsWidgets);
      c.read(routerProvider).go('/decided');
      await settle(tester);
      expect(find.text('Recently decided'), findsWidgets);
      await _signInAs(tester, c, Role.admin);
      for (final MapEntry(key: path, value: title) in <String, String>{
        '/audit': 'Audit log',
        '/insights': 'Usage insights',
      }.entries) {
        c.read(routerProvider).go(path);
        await settle(tester);
        expect(find.text(title), findsWidgets, reason: path);
      }
    });

    testWidgets('TC-PH1-50 signing out returns to sign-in', (tester) async {
      final c = await _pumpApp(tester, signedInAs: Role.admin);
      await tester.runAsync(() => c.read(sessionProvider.notifier).signOut());
      await settle(tester);
      expect(_location(c), AppRoutes.signIn);
    });
  });
}
