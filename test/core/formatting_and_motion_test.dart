import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app.dart';

String _strip(String s) => s.replaceAll(RegExp('[\u2066-\u2069]'), '');

void main() {
  setUpAll(initializeDateFormatting);

  group('Formats', () {
    test('TC-PH1-01 AED amounts per locale, LTR-isolated', () {
      final en = lookupAppLocalizations(const Locale('en'));
      final ar = lookupAppLocalizations(const Locale('ar'));
      expect(_strip(Formats.aed(31500, en)), 'AED 315.00');
      expect(_strip(Formats.aed(31500, ar)), '315.00 د.إ');
      expect(_strip(Formats.aed(36750, en)), 'AED 367.50');
      expect(_strip(Formats.aed(123456789, en)), 'AED 1,234,567.89');
      expect(Formats.aed(100, en), startsWith('\u2066'));
      expect(Formats.aed(100, en), endsWith('\u2069'));
    });

    test('TC-PH1-02 percent, integer and dates keep Western digits', () {
      expect(_strip(Formats.percent(55.4)), '55%');
      expect(_strip(Formats.integer(1240)), '1,240');
      final d = DateTime(2027, 1, 12);
      expect(Formats.date(d, const Locale('en')), '12 Jan 2027');
      final arDate = Formats.date(d, const Locale('ar'));
      expect(arDate, contains('12'));
      expect(arDate, contains('2027'));
      expect(arDate, isNot(contains('Jan')));
    });
  });

  group('Motion', () {
    testWidgets('TC-PH1-03 durations collapse to zero with reduced motion', (
      tester,
    ) async {
      late Duration on;
      late Duration off;
      await pumpTestApp(
        tester,
        Builder(
          builder: (c) {
            on = Motion.duration(c, Motion.push);
            return const SizedBox();
          },
        ),
      );
      await pumpTestApp(
        tester,
        Builder(
          builder: (c) {
            off = Motion.duration(c, Motion.push);
            return const SizedBox();
          },
        ),
        disableAnimations: true,
      );
      expect(on, const Duration(milliseconds: 420));
      expect(off, Duration.zero);
    });

    test('TC-PH1-04 motion constants match the prototype', () {
      expect(Motion.tabSwitch.inMilliseconds, 360);
      expect(Motion.push.inMilliseconds, 420);
      expect(Motion.listStagger.inMilliseconds, 50);
      expect(Motion.listItem.inMilliseconds, 500);
      expect(Motion.ringSweep.inMilliseconds, 1300);
      expect(Motion.barGrow.inMilliseconds, 1000);
      expect(Motion.pulse.inMilliseconds, 2200);
      expect(Motion.ecg.inMilliseconds, 3600);
      expect(Motion.shimmer.inMilliseconds, 1200);
      expect(Motion.sheet.inMilliseconds, 420);
      expect(Motion.snackbar.inMilliseconds, 400);
      expect(Motion.banner.inMilliseconds, 500);
      expect(Motion.shake.inMilliseconds, 400);
      expect(Motion.checkDraw.inMilliseconds, 500);
      expect(Motion.standard, const Cubic(0.2, 0.7, 0.2, 1));
    });

    testWidgets('TC-PH1-05 push slide mirrors in RTL', (tester) async {
      Future<double> offsetAt(Variant v) async {
        final controller = AnimationController(
          vsync: tester,
          duration: Motion.push,
          value: 0.3,
        );
        addTearDown(controller.dispose);
        await pumpTestApp(
          tester,
          SharedAxisPageTransition(
            animation: controller,
            secondaryAnimation: const AlwaysStoppedAnimation<double>(0),
            child: const SizedBox(key: Key('page'), width: 10, height: 10),
          ),
          variant: v,
        );
        final t = tester.widget<Transform>(
          find
              .ancestor(
                of: find.byKey(const Key('page')),
                matching: find.byType(Transform),
              )
              .first,
        );
        return t.transform.getTranslation().x;
      }

      expect(await offsetAt(Variant.lightLtr), greaterThan(0));
      expect(await offsetAt(Variant.lightRtl), lessThan(0));
    });

    testWidgets('TC-PH1-06 Shake moves sideways then returns', (tester) async {
      final key = GlobalKey<ShakeState>();
      await pumpTestApp(tester, Shake(key: key, child: const Text('B')));
      key.currentState!.shake();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      final t = tester.widget<Transform>(
        find
            .ancestor(of: find.text('B'), matching: find.byType(Transform))
            .first,
      );
      expect(t.transform.getTranslation().x.abs(), greaterThan(1));
      await tester.pumpAndSettle();
    });
  });

  test('TC-NFR-L10N-01 numeric ranges are LTR-isolated in Arabic text', () {
    const lri = '\u2066';
    const pdi = '\u2069';
    expect(
      ltrNumbers('60–80 ضغطة في الدقيقة'),
      '${lri}60–80$pdi ضغطة في الدقيقة',
    );
    expect(
      ltrNumbers('Compress at 100–120 per minute'),
      'Compress at ${lri}100–120$pdi per minute',
    );
    expect(ltrNumbers('no digits'), 'no digits');
  });
}
