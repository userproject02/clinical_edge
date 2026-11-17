import 'package:clinical_edge/core/widgets/linear_meter.dart';
import 'package:clinical_edge/core/widgets/progress_ring.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden.dart';
import '../../helpers/test_app.dart';

void main() {
  group('ProgressRing', () {
    testWidgets('TC-PH1-23 sweeps over 1.3 s and exposes semantics', (
      tester,
    ) async {
      await pumpTestApp(
        tester,
        const Center(
          child: ProgressRing(value: 0.55, semanticLabel: 'Overall progress'),
        ),
      );
      CustomPaint paint() => tester.widget<CustomPaint>(
        find
            .descendant(
              of: find.byType(ProgressRing),
              matching: find.byType(CustomPaint),
            )
            .first,
      );
      double sweep() => (paint().painter! as dynamic).value as double;

      await tester.pump(const Duration(milliseconds: 50));
      expect(sweep(), 0, reason: '100 ms delay before sweeping');
      await tester.pump(const Duration(milliseconds: 600));
      expect(sweep(), inExclusiveRange(0, 0.55));
      await tester.pumpAndSettle();
      expect(sweep(), closeTo(0.55, 1e-9));

      expect(
        tester.getSemantics(find.byType(ProgressRing)),
        matchesSemantics(label: 'Overall progress', value: '\u206655%\u2069'),
      );
    });

    testWidgets('TC-PH1-24 centre label never wraps, even at 1.3× text', (
      tester,
    ) async {
      await pumpTestApp(
        tester,
        const Center(
          child: ProgressRing(
            value: 0.88,
            size: 52,
            semanticLabel: 'Score',
            label: '88% passed',
          ),
        ),
        textScale: 1.3,
      );
      await tester.pumpAndSettle();
      final paragraph = tester.renderObject<RenderParagraph>(
        find.text('88% passed'),
      );
      expect(paragraph.maxLines, 1);
      expect(paragraph.didExceedMaxLines, isFalse);
      final ring = tester.getRect(find.byType(ProgressRing));
      final text = tester.getRect(find.text('88% passed'));
      expect(ring.contains(text.center), isTrue);
    });

    testWidgets('TC-PH1-25 reduced motion draws the final value at once', (
      tester,
    ) async {
      await pumpTestApp(
        tester,
        const ProgressRing(value: 0.4, semanticLabel: 'x'),
        disableAnimations: true,
      );
      await tester.pump();
      final paint = tester.widget<CustomPaint>(
        find
            .descendant(
              of: find.byType(ProgressRing),
              matching: find.byType(CustomPaint),
            )
            .first,
      );
      expect((paint.painter! as dynamic).value, closeTo(0.4, 1e-9));
    });
  });

  group('LinearMeter', () {
    Future<Rect> fillRect(WidgetTester tester, Variant v) async {
      await pumpTestApp(
        tester,
        const Padding(
          padding: EdgeInsets.all(20),
          child: LinearMeter(value: 0.5, semanticLabel: 'CPD credits'),
        ),
        variant: v,
      );
      await tester.pumpAndSettle();
      return tester.getRect(
        find
            .descendant(
              of: find.byType(LinearMeter),
              matching: find.byType(DecoratedBox),
            )
            .last,
      );
    }

    testWidgets('TC-PH1-26 grows from the start edge (left LTR, right RTL)', (
      tester,
    ) async {
      const track = Rect.fromLTWH(20, 0, 350, 8);
      final ltr = await fillRect(tester, Variant.lightLtr);
      expect(ltr.left, closeTo(track.left, 0.5));
      expect(ltr.width, closeTo(track.width / 2, 0.5));
      final rtl = await fillRect(tester, Variant.lightRtl);
      expect(rtl.right, closeTo(track.right, 0.5));
      expect(rtl.width, closeTo(track.width / 2, 0.5));
    });

    testWidgets('TC-PH1-27 bar animates over ~1.15 s', (tester) async {
      await pumpTestApp(
        tester,
        const LinearMeter(value: 1, semanticLabel: 'x'),
      );
      double width() => tester
          .getSize(
            find
                .descendant(
                  of: find.byType(LinearMeter),
                  matching: find.byType(DecoratedBox),
                )
                .last,
          )
          .width;
      await tester.pump(const Duration(milliseconds: 100));
      expect(width(), 0);
      await tester.pump(const Duration(milliseconds: 500));
      expect(width(), greaterThan(0));
      expect(width(), lessThan(390));
      await tester.pumpAndSettle();
      expect(width(), closeTo(390, 0.5));
    });
  });

  goldenVariants(
    'progress_ring',
    () => const Row(
      children: <Widget>[
        ProgressRing(value: 0.55, semanticLabel: 'Overall'),
        SizedBox(width: 16),
        ProgressRing(
          value: 0.88,
          size: 104,
          semanticLabel: 'Score',
          color: Color(0xFF1C7347),
        ),
        SizedBox(width: 16),
        ProgressRing(value: 0.3, size: 52, strokeWidth: 12, semanticLabel: 'x'),
      ],
    ),
    size: const Size(390, 150),
  );

  goldenVariants(
    'linear_meter',
    () => const Column(
      children: <Widget>[
        LinearMeter(value: 0.65, semanticLabel: 'CPD'),
        SizedBox(height: 16),
        LinearMeter(value: 0.2, height: 12, semanticLabel: 'Expiry'),
      ],
    ),
    size: const Size(390, 90),
  );
}
