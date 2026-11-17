import 'dart:convert';

import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/money.dart';
import 'package:clinical_edge/core/payments/payment_gateway.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/checkout/data/checkout_repository.dart';
import 'package:clinical_edge/features/checkout/domain/card_rules.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app_harness.dart';

const _layla = 'u-layla';
const _pan = '4242424242424242';
const _cvc = '987';
const _c3 = 'Medication Safety & High-Alert Drugs';

Finder _t(String s) => find.byWidgetPredicate(
  (w) =>
      w is Text &&
      (w.data ?? '').replaceAll(RegExp('[\u2066-\u2069]'), '').contains(s),
);

String _loc(ProviderContainer c) =>
    c.read(routerProvider).routerDelegate.currentConfiguration.uri.path;

Future<void> _go(WidgetTester t, ProviderContainer c, String path) async {
  c.read(routerProvider).go(path);
  await settle(t);
}

Future<void> _tap(WidgetTester t, Finder f) async {
  await t.ensureVisible(f);
  await t.tap(f);
  await settle(t);
}

Future<void> _fillCard(
  WidgetTester t, {
  String number = _pan,
  String expiry = '1228',
  String cvc = _cvc,
}) async {
  await t.enterText(find.byKey(const Key('checkout.number')), number);
  await t.enterText(find.byKey(const Key('checkout.expiry')), expiry);
  await t.enterText(find.byKey(const Key('checkout.cvc')), cvc);
  await t.pump();
}

/// Every stored or logged string, to prove no card data leaks.
Future<String> _everything(
  WidgetTester t,
  ProviderContainer c,
  InMemoryLocalDb db,
) async => (await t.runAsync(() async {
  final out = StringBuffer();
  for (final e in await c.read(auditStoreProvider).list()) {
    out.writeln(jsonEncode(e.toJson()));
  }
  for (final e in await c.read(usageStoreProvider).list()) {
    out.writeln(jsonEncode(e.toJson()));
  }
  for (final col in [Collections.orders, Collections.meta]) {
    out.writeln(jsonEncode(await (await db.open(col)).values()));
  }
  return out.toString();
}))!;

void main() {
  group('PAY-1 pricing and card rules', () {
    test('TC-PAY-1-07 VAT and totals for all three prices', () {
      for (final (price, vat, total) in [
        (35000, 1750, 36750),
        (25000, 1250, 26250),
        (30000, 1500, 31500),
      ]) {
        final p = PriceBreakdown(Money(price));
        expect(p.vat.fils, vat);
        expect(p.total.fils, total);
      }
      expect(const Money(31500).plain, '315.00');
      expect(const Money(36750).plain, '367.50');
    });

    test('TC-PAY-1-08 Luhn, expiry, CVC, grouping', () {
      expect(CardRules.luhn(_pan), isTrue);
      expect(CardRules.luhn('4242 4242 4242 4241'), isFalse);
      expect(CardRules.luhn('4242'), isFalse);
      expect(CardRules.group('4242424242424242'), '4242 4242 4242 4242');
      final today = DateTime.utc(2026, 11, 17);
      expect(CardRules.expiryValid('11 / 26', today), isTrue);
      expect(CardRules.expiryValid('10 / 26', today), isFalse);
      expect(CardRules.expiryValid('13 / 27', today), isFalse);
      expect(CardRules.expiryValid('1', today), isFalse);
      expect(CardRules.cvcValid('123'), isTrue);
      expect(CardRules.cvcValid('1234'), isTrue);
      expect(CardRules.cvcValid('12'), isFalse);
      expect(CardRules.last4(_pan), '4242');
    });
  });

  group('PAY-1 checkout', () {
    testWidgets('TC-PAY-1-09 summary, validation, double tap, success, '
        'receipt, unlock, no card data anywhere', (tester) async {
      final db = InMemoryLocalDb();
      final c = await pumpClinicalEdge(
        tester,
        db: db,
        signedInAs: Role.learner,
      );
      await _go(tester, c, AppRoutes.checkout('c3'));
      expect(find.text(_c3), findsOneWidget);
      expect(find.text('4 lessons · 2 CPD credits'), findsOneWidget);
      expect(_t('AED 300.00'), findsOneWidget);
      expect(_t('AED 15.00'), findsOneWidget);
      expect(_t('AED 315.00'), findsWidgets);
      expect(find.text('Pay AED 315.00'), findsNothing); // LTR-isolated
      expect(_t('Pay AED 315.00'), findsOneWidget);

      await _tap(tester, find.byKey(const Key('checkout.pay')));
      expect(find.text('Check the card number'), findsOneWidget);
      expect(find.text('3 or 4 digits'), findsOneWidget);

      await _fillCard(tester, expiry: '1025');
      await _tap(tester, find.byKey(const Key('checkout.pay')));
      expect(
        find.text('Enter a valid date that is not in the past'),
        findsOneWidget,
      );

      await _fillCard(tester);
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('checkout.number')))
            .controller!
            .text,
        '4242 4242 4242 4242',
      );
      // Double tap: the second tap is ignored while processing.
      await tester.tap(find.byKey(const Key('checkout.pay')));
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.text('Processing…'), findsOneWidget);
      await tester.tap(
        find.byKey(const Key('checkout.pay')),
        warnIfMissed: false,
      );
      await settle(tester);

      expect(_loc(c), startsWith('/learn/c3/receipt/'));
      expect(find.text('Payment successful'), findsOneWidget);
      expect(
        _t('Tax invoice CE-2026-001041 · 2026-11-17 09:00'),
        findsOneWidget,
      );
      expect(_t('ClinicalEdge (demo) · TRN [YOUR TRN]'), findsOneWidget);
      expect(find.text('Dr. Layla Haddad'), findsOneWidget);
      expect(_t('Card •••• 4242 (mock)'), findsOneWidget);
      expect(_t('AED 315.00'), findsWidgets);

      final orders = await tester.runAsync(
        () => c.read(checkoutRepositoryProvider).receipts(_layla),
      );
      expect(orders, hasLength(1), reason: 'double tap made one order');
      expect(orders!.single.cardLast4, '4242');
      expect(orders.single.invoiceNo, 'CE-2026-001041');
      expect(
        await tester.runAsync(
          () => c.read(courseRepositoryProvider).isOwned(_layla, 'c3'),
        ),
        isTrue,
      );

      final all = await _everything(tester, c, db);
      expect(all, contains('purchase'));
      expect(all, contains('$_c3 · AED 315.00 · CE-2026-001041'));
      expect(all, contains('checkout.start'));
      for (final secret in [_pan, '4242 4242 4242 4242', '12/28', '1228']) {
        expect(all.contains(secret), isFalse, reason: 'leaked $secret');
      }
      expect(RegExp('"cvc"|$_cvc"').hasMatch(all), isFalse);

      await _tap(tester, find.byKey(const Key('receipt.start')));
      expect(_loc(c), AppRoutes.lesson('c3', 1));
      await _go(tester, c, AppRoutes.course('c3'));
      expect(find.byKey(const Key('detail.progress')), findsOneWidget);
    });

    testWidgets('TC-PAY-1-10 decline shows a retry banner; 3-D Secure cancel '
        'then approve', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      c.read(mockGatewayModeProvider.notifier).set(MockGatewayMode.fail);
      await _go(tester, c, AppRoutes.checkout('c3'));
      await _fillCard(tester);
      await _tap(tester, find.byKey(const Key('checkout.pay')));
      expect(find.byKey(const Key('checkout.error')), findsOneWidget);
      expect(find.text('Payment declined'), findsOneWidget);
      expect(_loc(c), AppRoutes.checkout('c3'));

      c.read(mockGatewayModeProvider.notifier).set(MockGatewayMode.needs3ds);
      await _tap(tester, find.byKey(const Key('checkout.retry')));
      expect(find.text('3-D Secure (mock)'), findsOneWidget);
      await _tap(tester, find.byKey(const Key('3ds.cancel')));
      expect(
        find.text('Payment cancelled at 3-D Secure. You were not charged.'),
        findsOneWidget,
      );
      expect(
        await tester.runAsync(
          () => c.read(courseRepositoryProvider).isOwned(_layla, 'c3'),
        ),
        isFalse,
      );

      await _tap(tester, find.byKey(const Key('checkout.retry')));
      await _tap(tester, find.byKey(const Key('3ds.approve')));
      expect(_loc(c), startsWith('/learn/c3/receipt/'));
      expect(find.text('Payment successful'), findsOneWidget);
    });

    testWidgets('TC-PAY-2-03 Apple Pay (mock): sheet, label, receipt method', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.checkout('c3'));
      await _tap(tester, find.byKey(const Key('checkout.method.apple')));
      expect(find.text('Apple Pay sheet (mock)'), findsOneWidget);
      expect(find.text('Confirm with Face ID on device'), findsOneWidget);
      expect(_t('Pay with Apple Pay · AED 315.00'), findsOneWidget);
      await _tap(tester, find.byKey(const Key('checkout.pay')));
      expect(find.text('Apple Pay (mock)'), findsOneWidget);
      await _go(tester, c, AppRoutes.learn);
      expect(_t('AED 300.00'), findsNothing, reason: 'now owned');
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
      for (final name in <String>[
        'checkout_card',
        'checkout_apple_pay',
        'checkout_processing',
        'checkout_error',
        'receipt',
      ]) {
        testWidgets('$name golden ($theme $dir)', (tester) async {
          final c = await pumpClinicalEdge(
            tester,
            prefs: <String, Object>{
              PrefKeys.themeMode: theme,
              PrefKeys.locale: locale,
            },
            signedInAs: Role.learner,
          );
          if (name == 'checkout_error') {
            c.read(mockGatewayModeProvider.notifier).set(MockGatewayMode.fail);
          }
          await _go(tester, c, AppRoutes.checkout('c3'));
          switch (name) {
            case 'checkout_card':
              await _fillCard(tester);
            case 'checkout_apple_pay':
              await _tap(
                tester,
                find.byKey(const Key('checkout.method.apple')),
              );
            case 'checkout_processing':
              await _fillCard(tester);
              await tester.tap(find.byKey(const Key('checkout.pay')));
              await tester.pump(const Duration(milliseconds: 100));
            case 'checkout_error':
              await _fillCard(tester);
              await _tap(tester, find.byKey(const Key('checkout.pay')));
            case 'receipt':
              await _fillCard(tester);
              await _tap(tester, find.byKey(const Key('checkout.pay')));
          }
          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile('goldens/${name}_${theme}_$dir.png'),
          );
          if (name == 'checkout_processing') await settle(tester);
        }, tags: <String>['golden']);
      }
    }
  });
}
