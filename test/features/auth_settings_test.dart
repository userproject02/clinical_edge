import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/notifications.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/app/state/theme_mode.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/test_app_harness.dart';

String _location(ProviderContainer c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

Future<List<String>> _usage(WidgetTester t, ProviderContainer c) async =>
    (await t.runAsync(() => c.read(usageStoreProvider).list()))!
        .map((e) => e.action)
        .toList();

Future<void> _tapSignIn(WidgetTester tester) async {
  await tester.ensureVisible(find.byKey(const Key('signIn.submit')));
  await tester.tap(find.byKey(const Key('signIn.submit')));
  await settle(tester);
}

void main() {
  group('Sign-in', () {
    testWidgets('TC-AUTH-1-01 empty fields: inline errors, no navigation', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester);
      expect(_location(c), AppRoutes.signIn);
      await tester.enterText(find.byKey(const Key('signIn.email')), '');
      await tester.enterText(find.byKey(const Key('signIn.password')), '');
      await _tapSignIn(tester);
      expect(find.text('Enter your work email'), findsOneWidget);
      expect(find.text('Enter your password'), findsOneWidget);
      expect(_location(c), AppRoutes.signIn);
      expect(c.read(sessionProvider).value, isNull);

      await tester.enterText(
        find.byKey(const Key('signIn.email')),
        'a@b.example',
      );
      await _tapSignIn(tester);
      expect(find.text('Enter your work email'), findsNothing);
      expect(find.text('Enter your password'), findsOneWidget);
      expect(_location(c), AppRoutes.signIn);
    });

    for (final (role, home, name) in <(Role, String, String)>[
      (Role.learner, '/home', 'Layla'),
      (Role.supervisor, '/queue', 'Omar'),
      (Role.admin, '/cohort', 'Sara'),
    ]) {
      testWidgets('TC-AUTH-1-02 sign in as ${role.name} lands on $home', (
        tester,
      ) async {
        final c = await pumpClinicalEdge(tester);
        await tester.tap(
          find.text(
            <Role, String>{
              Role.learner: 'Learner',
              Role.supervisor: 'Supervisor',
              Role.admin: 'Admin',
            }[role]!,
          ),
        );
        await settle(tester);
        final email = tester.widget<TextField>(
          find.byKey(const Key('signIn.email')),
        );
        expect(email.controller!.text, endsWith('@demo-hospital.example'));
        expect(
          email.controller!.text.toLowerCase(),
          contains(name.toLowerCase()),
        );
        await tester.tap(find.byKey(const Key('signIn.submit')));
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 5)),
        );
        await tester.pump();
        await tester.pump();
        // First home load shows the skeleton for ~900 ms.
        expect(find.byKey(const Key('home.skeleton')), findsOneWidget);
        await tester.pump(const Duration(milliseconds: 950));
        await settle(tester);
        expect(find.byKey(const Key('home.skeleton')), findsNothing);
        expect(_location(c), home);
        expect(c.read(sessionProvider).value!.role, role);
        // Home title is the user's first name; subtitle the greeting.
        expect(find.text(name), findsOneWidget);
        expect(find.text('Good morning'), findsOneWidget);
        expect(await _usage(tester, c), contains('auth.signin'));
      });
    }

    testWidgets('TC-AUTH-1-04 restart keeps the user signed in', (
      tester,
    ) async {
      final db = InMemoryLocalDb();
      await pumpClinicalEdge(tester, db: db, signedInAs: Role.supervisor);
      final again = await pumpClinicalEdge(tester, db: db);
      expect(_location(again), '/queue');
      expect(again.read(sessionProvider).value!.user.id, 'u-omar');
    });

    testWidgets(
      'TC-AUTH-1-05 language toggle on sign-in switches to Arabic RTL',
      (tester) async {
        final c = await pumpClinicalEdge(tester);
        await tester.tap(find.byKey(const Key('signIn.language')));
        await settle(tester);
        expect(c.read(localeProvider), const Locale('ar'));
        expect(find.text('تسجيل الدخول'), findsWidgets);
        final field = tester.element(find.byKey(const Key('signIn.submit')));
        expect(Directionality.of(field), TextDirection.rtl);
      },
    );
  });

  group('Role switch (demo)', () {
    testWidgets('TC-AUTH-2-01 Profile switch: role.change audit, stays', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await tester.tap(find.bySemanticsLabel('Profile and settings'));
      await settle(tester);
      expect(find.byKey(const Key('profile.role')), findsOneWidget);
      await tester.tap(
        find.descendant(
          of: find.byKey(const Key('profile.role')),
          matching: find.text('Supervisor'),
        ),
      );
      await settle(tester);

      expect(find.byKey(const Key('profile.role')), findsOneWidget);
      expect(c.read(sessionProvider).value!.role, Role.supervisor);
      expect(find.text('Dr. Omar Al Mansoori'), findsOneWidget);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Role switched'), findsOneWidget);
      expect(find.text('Now viewing as Dr. Omar Al Mansoori'), findsOneWidget);

      final audit = (await tester.runAsync(
        () => c.read(auditStoreProvider).list(),
      ))!;
      final last = audit.last;
      expect(last.action, 'role.change');
      expect(last.target, 'Learner → Supervisor (demo)');
      expect(last.userId, 'u-omar');

      // Back from Profile goes to the new role's home with its tabs.
      await tester.tap(find.byTooltip('Back'));
      await settle(tester);
      expect(_location(c), '/queue');
      expect(
        tester.widget<NavigationBar>(find.byType(NavigationBar)).destinations,
        hasLength(3),
      );
      await tester.pump(const Duration(seconds: 5));
      await settle(tester);
    });
  });

  group('Sign-out', () {
    testWidgets('TC-AUTH-3-01 sign out: sign-in, cleared, auth.signout', (
      tester,
    ) async {
      final db = InMemoryLocalDb();
      final c = await pumpClinicalEdge(tester, db: db, signedInAs: Role.admin);
      await tester.tap(find.bySemanticsLabel('Profile and settings'));
      await settle(tester);
      // Profile scrolls (help card); let the scroll settle before tapping.
      await tester.ensureVisible(find.byKey(const Key('profile.signOut')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('profile.signOut')));
      await settle(tester);
      expect(_location(c), AppRoutes.signIn);
      expect(c.read(sessionProvider).value, isNull);
      expect(await _usage(tester, c), contains('auth.signout'));
      final again = await pumpClinicalEdge(tester, db: db);
      expect(_location(again), AppRoutes.signIn);
    });
  });

  group('Settings', () {
    testWidgets('TC-SET-1-01 settings apply instantly and persist', (
      tester,
    ) async {
      final db = InMemoryLocalDb();
      final c = await pumpClinicalEdge(
        tester,
        db: db,
        signedInAs: Role.learner,
      );
      await tester.tap(find.bySemanticsLabel('Profile and settings'));
      await settle(tester);

      await tester.tap(
        find.descendant(
          of: find.byKey(const Key('profile.theme')),
          matching: find.text('Dark'),
        ),
      );
      await settle(tester);
      expect(c.read(themeModeProvider), ThemeMode.dark);
      expect(
        Theme.of(tester.element(find.byKey(const Key('profile.theme'))))
            .brightness,
        Brightness.dark,
      );

      await tester.ensureVisible(
        find.byKey(const Key('profile.notifications')),
      );
      await tester.tap(find.byKey(const Key('profile.notifications')));
      await settle(tester);
      expect(c.read(notificationsEnabledProvider), isFalse);

      await tester.tap(
        find.descendant(
          of: find.byKey(const Key('profile.language')),
          matching: find.text('العربية'),
        ),
      );
      await settle(tester);
      expect(find.text('الملف والإعدادات'), findsWidgets);
      final back = tester.getRect(find.byTooltip('رجوع'));
      expect(back.left, greaterThan(195), reason: 'back arrow mirrored');

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(PrefKeys.themeMode), 'dark');
      expect(prefs.getString(PrefKeys.locale), 'ar');
      expect(prefs.getBool(PrefKeys.notifications), isFalse);

      final restarted = await pumpClinicalEdge(
        tester,
        db: db,
        prefs: <String, Object>{
          PrefKeys.themeMode: 'dark',
          PrefKeys.locale: 'ar',
          PrefKeys.notifications: false,
        },
      );
      expect(restarted.read(themeModeProvider), ThemeMode.dark);
      expect(restarted.read(localeProvider), const Locale('ar'));
      expect(restarted.read(notificationsEnabledProvider), isFalse);
      expect(_location(restarted), '/home');
    });

    test('TC-SET-1-02 greeting follows the Dubai clock', () {
      final l = lookupAppLocalizations(const Locale('en'));
      expect(greetingFor(DateTime.utc(2026, 11, 17, 5), l), 'Good morning');
      expect(greetingFor(DateTime.utc(2026, 11, 17, 9), l), 'Good afternoon');
      expect(greetingFor(DateTime.utc(2026, 11, 17, 13), l), 'Good evening');
      expect(greetingFor(DateTime.utc(2026, 11, 17, 21), l), 'Good morning');
    });
  });

  group('Screen goldens', () {
    for (final (theme, locale) in <(String, String)>[
      ('light', 'en'),
      ('dark', 'en'),
      ('light', 'ar'),
      ('dark', 'ar'),
    ]) {
      final dir = locale == 'ar' ? 'rtl' : 'ltr';
      testWidgets('sign_in golden ($theme $dir)', (tester) async {
        await pumpClinicalEdge(
          tester,
          prefs: <String, Object>{
            PrefKeys.themeMode: theme,
            PrefKeys.locale: locale,
          },
        );
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/sign_in_${theme}_$dir.png'),
        );
      }, tags: <String>['golden']);

      testWidgets('settings golden ($theme $dir)', (tester) async {
        final c = await pumpClinicalEdge(
          tester,
          prefs: <String, Object>{
            PrefKeys.themeMode: theme,
            PrefKeys.locale: locale,
          },
          signedInAs: Role.learner,
        );
        unawaited(c.read(routerProvider).push(AppRoutes.profile));
        await settle(tester);
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/settings_${theme}_$dir.png'),
        );
      }, tags: <String>['golden']);
    }
  });
}
