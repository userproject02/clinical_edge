import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/money.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

String _plain(String s) => s.replaceAll(RegExp('[\u2066-\u2069]'), '');

void main() {
  group('Money', () {
    test('TC-PAY-1-01 VAT and totals for the seed prices', () {
      for (final (sub, vat, total) in <(int, int, int)>[
        (35000, 1750, 36750),
        (25000, 1250, 26250),
        (30000, 1500, 31500),
      ]) {
        final p = PriceBreakdown(Money(sub));
        expect(p.vat.fils, vat, reason: '$sub');
        expect(p.total.fils, total, reason: '$sub');
        expect(Money(sub).withVat, Money(total));
      }
    });

    test('TC-PAY-1-02 odd-fils VAT rounds half up', () {
      expect(vatOf(const Money(1)).fils, 0); // 0.05
      expect(vatOf(const Money(9)).fils, 0); // 0.45
      expect(vatOf(const Money(10)).fils, 1); // 0.50 → 1
      expect(vatOf(const Money(29)).fils, 1); // 1.45
      expect(vatOf(const Money(30)).fils, 2); // 1.50 → 2
      expect(vatOf(const Money(31999)).fils, 1600); // 1599.95
      expect(vatOf(const Money(-30)).fils, -2); // refunds mirror
      expect(vatOf(Money.zero), Money.zero);
    });

    test('TC-PAY-1-03 formatting per locale', () {
      final en = lookupAppLocalizations(const Locale('en'));
      final ar = lookupAppLocalizations(const Locale('ar'));
      expect(_plain(const Money(31500).format(en)), 'AED 315.00');
      expect(_plain(const Money(31500).format(ar)), '315.00 د.إ');
      expect(_plain(const Money(5).format(en)), 'AED 0.05');
      expect(_plain(const Money(123456789).format(en)), 'AED 1,234,567.89');
      expect(_plain(const Money(-36750).format(en)), 'AED -367.50');
    });
  });

  group('Clock', () {
    test('TC-PH2-01 demo clock is 17 Nov 2026 09:00 Dubai', () {
      final c = FixedClock(demoNow);
      expect(c.now(), DateTime.utc(2026, 11, 17, 5));
      expect(c.today(), DateTime.utc(2026, 11, 17));
      expect(
        FixedClock(DateTime.utc(2026, 11, 17, 21)).today(),
        DateTime.utc(2026, 11, 18),
        reason: '01:00 next day in Dubai',
      );
    });

    test('TC-PH2-02 daysBetween counts calendar days', () {
      final today = DateTime.utc(2026, 11, 17);
      expect(daysBetween(today, DateTime.utc(2027, 1, 12)), 56);
      expect(daysBetween(today, DateTime.utc(2027, 9, 30)), 317);
      expect(daysBetween(today, today), 0);
      expect(daysBetween(today, DateTime.utc(2026, 11, 16)), -1);
    });

    test('TC-PH2-03 SystemClock returns UTC', () {
      expect(const SystemClock().now().isUtc, isTrue);
    });
  });
}
