import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/core/widgets/ecg_line.dart';
import 'package:clinical_edge/core/widgets/pulsing_dot.dart';
import 'package:clinical_edge/core/widgets/skeleton_box.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden.dart';
import '../../helpers/test_app.dart';

void main() {
  testWidgets('TC-PH1-31 EcgLine loops and is hidden from screen readers', (
    tester,
  ) async {
    await pumpTestApp(tester, const EcgLine());
    expect(tester.binding.hasScheduledFrame, isTrue);
    await tester.pump(const Duration(seconds: 5));
    expect(
      find.descendant(
        of: find.byType(EcgLine),
        matching: find.byType(ExcludeSemantics),
      ),
      findsOneWidget,
    );
  });

  testWidgets('TC-PH1-32 looping widgets stop with reduced motion', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      const Column(
        children: <Widget>[
          EcgLine(),
          PulsingDot(color: Color(0xFFA64B05)),
          SkeletonBox(height: 40),
        ],
      ),
      disableAnimations: true,
    );
    await tester.pump();
    expect(tester.binding.hasScheduledFrame, isFalse);
    final box = tester.widget<Container>(
      find.descendant(
        of: find.byType(SkeletonBox),
        matching: find.byType(Container),
      ),
    );
    expect((box.decoration! as BoxDecoration).color, AppColors.light.surface2);
  });

  testWidgets('TC-PH1-33 SkeletonBox announces loading', (tester) async {
    await pumpTestApp(tester, const SkeletonBox(height: 40));
    expect(find.bySemanticsLabel('Loading'), findsOneWidget);
  });

  goldenVariants(
    'ecg_line',
    () => Builder(
      builder: (context) => Container(
        height: 120,
        decoration: BoxDecoration(
          color: context.colors.hero,
          borderRadius: BorderRadius.circular(AppRadii.hero),
        ),
        child: const Align(
          alignment: Alignment.bottomCenter,
          child: EcgLine(opacity: 0.6),
        ),
      ),
    ),
    size: const Size(390, 160),
    settle: const Duration(milliseconds: 1800),
  );

  goldenVariants(
    'pulsing_dot',
    () => const Row(
      children: <Widget>[
        PulsingDot(color: Color(0xFFA64B05)),
        SizedBox(width: 24),
        PulsingDot(color: Color(0xFFD66E14), size: 10),
      ],
    ),
    size: const Size(390, 80),
    settle: const Duration(milliseconds: 700),
  );

  goldenVariants(
    'skeleton_box',
    () => const Column(
      children: <Widget>[
        SkeletonBox(height: 84, radius: AppRadii.hero),
        SizedBox(height: 12),
        SkeletonBox(height: 48),
        SizedBox(height: 12),
        SkeletonBox(width: 160, height: 16, radius: 8),
      ],
    ),
    size: const Size(390, 220),
    settle: const Duration(milliseconds: 300),
  );
}
