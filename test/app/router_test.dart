import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/app/state/session.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _out = Session();
const _learner = Session(signedIn: true);
const _supervisor = Session(signedIn: true, role: Role.supervisor);
const _admin = Session(signedIn: true, role: Role.admin);

String? _r(Session s, String path) => redirectFor(s, Uri.parse(path));

Future<ProviderContainer> _pumpApp(
  WidgetTester tester, {
  Role? signedInAs,
  String locale = 'en',
}) async {
  SharedPreferences.setMockInitialValues(<String, Object>{
    PrefKeys.locale: locale,
  });
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );
  addTearDown(container.dispose);
  if (signedInAs != null) {
    container.read(sessionProvider.notifier).signIn(signedInAs);
  }
  // Looping decor (ECG line, bell pulse) never settles; tests run with the
  // platform's reduce-motion setting, which the app honours everywhere.
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
  await tester.binding.setSurfaceSize(const Size(390, 844));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const ClinicalEdgeApp(showDebugMenu: false),
    ),
  );
  await tester.pumpAndSettle();
  return container;
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

      c.read(sessionProvider.notifier).signIn(Role.supervisor);
      await tester.pumpAndSettle();
      expect(_location(c), '/queue');
      expect(find.text('Sign-off queue'), findsWidgets);
      expect(
        tester.widget<NavigationBar>(find.byType(NavigationBar)).destinations,
        hasLength(3),
      );

      c.read(sessionProvider.notifier).signIn(Role.admin);
      await tester.pumpAndSettle();
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
      await tester.pumpAndSettle();
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
      await tester.pumpAndSettle();
      expect(find.text('Course'), findsWidgets);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
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
      c.read(routerProvider).go(AppRoutes.quiz('bls'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Home'),
        ),
      );
      await tester.pumpAndSettle();
      expect(_location(c), '/home');
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Assess'),
        ),
      );
      await tester.pumpAndSettle();
      expect(_location(c), '/assess/bls/run');
    });

    testWidgets('TC-PH1-47 avatar pushes /profile; upload opens a sheet', (
      tester,
    ) async {
      final c = await _pumpApp(tester, signedInAs: Role.learner);
      await tester.tap(find.bySemanticsLabel('Profile and settings'));
      await tester.pumpAndSettle();
      expect(find.text('Profile & settings'), findsWidgets);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      c.read(routerProvider).go(AppRoutes.certUpload);
      await tester.pumpAndSettle();
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
      await tester.pumpAndSettle();
      final back = tester.getRect(find.byTooltip('رجوع'));
      expect(back.left, greaterThan(195), reason: 'back arrow on the right');
    });

    testWidgets('TC-PH1-49 every placeholder shows its title', (tester) async {
      final c = await _pumpApp(tester, signedInAs: Role.learner);
      final router = c.read(routerProvider);
      final expected = <String, String>{
        '/home': 'Home',
        '/learn': 'Courses',
        '/learn/c1': 'Course',
        '/learn/c1/lesson/1': 'Lesson',
        '/learn/c3/checkout': 'Checkout',
        '/learn/c3/receipt/o1': 'Receipt',
        '/assess': 'Assessments',
        '/assess/bls/run': 'Quiz',
        '/certs': 'Certifications & CPD',
        '/signoffs': 'Competencies',
      };
      for (final MapEntry(key: path, value: title) in expected.entries) {
        router.go(path);
        await tester.pumpAndSettle();
        expect(find.text(title), findsWidgets, reason: path);
        expect(find.text(path), findsOneWidget, reason: path);
      }
      c.read(sessionProvider.notifier).signIn(Role.supervisor);
      await tester.pumpAndSettle();
      c.read(routerProvider).go('/queue/q1');
      await tester.pumpAndSettle();
      expect(find.text('Review sign-off'), findsWidgets);
      c.read(routerProvider).go('/decided');
      await tester.pumpAndSettle();
      expect(find.text('Recently decided'), findsWidgets);
      c.read(sessionProvider.notifier).signIn(Role.admin);
      await tester.pumpAndSettle();
      for (final MapEntry(key: path, value: title) in <String, String>{
        '/audit': 'Audit log',
        '/insights': 'Usage insights',
      }.entries) {
        c.read(routerProvider).go(path);
        await tester.pumpAndSettle();
        expect(find.text(title), findsWidgets, reason: path);
      }
    });

    testWidgets('TC-PH1-50 signing out returns to sign-in', (tester) async {
      final c = await _pumpApp(tester, signedInAs: Role.admin);
      c.read(sessionProvider.notifier).signOut();
      await tester.pumpAndSettle();
      expect(_location(c), AppRoutes.signIn);
    });
  });
}
