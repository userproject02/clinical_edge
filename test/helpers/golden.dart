import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'test_app.dart';

/// Registers four golden tests for a widget: light/dark × LTR/RTL.
///
/// Files: `test/core/widgets/goldens/<name>_<variant>.png`. Regenerate with
/// `flutter test --update-goldens --tags golden` on Linux (the CI platform).
///
/// [settle] is how long to advance the clock before capturing, so looping
/// animations (pulse, ECG, shimmer) land on a deterministic frame.
void goldenVariants(
  String name,
  Widget Function() build, {
  Size size = const Size(390, 200),
  Duration settle = const Duration(seconds: 2),
  Future<void> Function(WidgetTester tester)? setUp,
}) {
  for (final v in Variant.values) {
    testWidgets('$name golden (${v.id})', (tester) async {
      await tester.binding.setSurfaceSize(size);
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        testApp(
          Builder(
            builder: (context) => ColoredBox(
              color: context.colors.background,
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: build(),
                  ),
                ),
              ),
            ),
          ),
          variant: v,
        ),
      );
      if (setUp != null) await setUp(tester);
      await tester.pump();
      await tester.pump(settle);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/${name}_${v.id}.png'),
      );
    }, tags: <String>['golden']);
  }
}
