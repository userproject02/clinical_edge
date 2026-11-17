import 'package:clinical_edge/core/widgets/buttons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden.dart';
import '../../helpers/test_app.dart';

void main() {
  group('PrimaryButton', () {
    testWidgets('TC-PH1-14 is 52 dp tall, stadium and tappable', (
      tester,
    ) async {
      var taps = 0;
      await pumpTestApp(
        tester,
        Center(
          child: PrimaryButton(label: 'Sign in', onPressed: () => taps++),
        ),
      );
      expect(tester.getSize(find.byType(PrimaryButton)).height, 52);
      final style = tester
          .widget<FilledButton>(find.byType(FilledButton))
          .style!;
      expect(style.shape!.resolve(<WidgetState>{}), isA<StadiumBorder>());
      await tester.tap(find.text('Sign in'));
      expect(taps, 1);
    });

    testWidgets('TC-PH1-15 loading shows spinner, keeps width, ignores taps', (
      tester,
    ) async {
      var taps = 0;
      Widget button({required bool loading}) => Center(
        child: PrimaryButton(
          label: 'Pay AED 315.00',
          expand: false,
          loading: loading,
          onPressed: () => taps++,
        ),
      );
      await pumpTestApp(tester, button(loading: false));
      final width = tester.getSize(find.byType(PrimaryButton)).width;

      await pumpTestApp(tester, button(loading: true));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(tester.getSize(find.byType(PrimaryButton)).width, width);
      await tester.tap(find.byType(PrimaryButton), warnIfMissed: false);
      expect(taps, 0);
      expect(find.bySemanticsLabel('Pay AED 315.00, Loading'), findsOneWidget);
    });
  });

  testWidgets('TC-PH1-16 SecondaryButton disabled when onPressed is null', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      const Center(child: SecondaryButton(label: 'Back', onPressed: null)),
    );
    final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    expect(button.onPressed, isNull);
    expect(tester.getSize(find.byType(SecondaryButton)).height, 52);
  });

  goldenVariants(
    'primary_button',
    () => Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        PrimaryButton(
          label: 'Continue',
          icon: Icons.play_arrow_rounded,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        PrimaryButton(label: 'Pay', loading: true, onPressed: () {}),
        const SizedBox(height: 12),
        const PrimaryButton(label: 'Disabled', onPressed: null),
      ],
    ),
    size: const Size(390, 220),
    settle: const Duration(milliseconds: 300),
  );

  goldenVariants(
    'secondary_button',
    () => Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SecondaryButton(label: 'Preview lesson', onPressed: () {}),
        const SizedBox(height: 12),
        const SecondaryButton(label: 'Disabled', onPressed: null),
      ],
    ),
    size: const Size(390, 160),
  );
}
