import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/widgets/empty_state.dart';
import 'package:clinical_edge/core/widgets/stat_tile.dart';
import 'package:clinical_edge/core/widgets/status_tag.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden.dart';
import '../../helpers/test_app.dart';

void main() {
  testWidgets('TC-PH1-20 StatusTag uses the tone colours', (tester) async {
    await pumpTestApp(
      tester,
      const Wrap(
        children: <Widget>[
          StatusTag(label: 'Valid', tone: StatusTone.ok),
          StatusTag(label: 'Renew soon', tone: StatusTone.warn),
        ],
      ),
    );
    final valid = tester.widget<Text>(find.text('Valid'));
    expect(valid.style!.color, AppColors.light.ok);
    final soon = tester.widget<Text>(find.text('Renew soon'));
    expect(soon.style!.color, AppColors.light.warn);
    for (final tone in StatusTone.values) {
      expect(tone.background(AppColors.dark), isNotNull);
    }
  });

  testWidgets('TC-PH1-21 StatTile shows label, value, caption; tappable', (
    tester,
  ) async {
    var taps = 0;
    await pumpTestApp(
      tester,
      Padding(
        padding: const EdgeInsets.all(16),
        child: StatTile(
          label: 'CPD credits',
          value: '26 / 40',
          caption: '14 to go',
          onTap: () => taps++,
        ),
      ),
    );
    await tester.tap(find.text('26 / 40'));
    expect(taps, 1);
    expect(find.text('14 to go'), findsOneWidget);
  });

  testWidgets('TC-PH1-22 EmptyState renders title, message and action', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      EmptyState(
        title: 'No attempts yet',
        message: 'Take the quiz to see your score history.',
        action: TextButton(onPressed: () {}, child: const Text('Start')),
      ),
    );
    expect(find.text('No attempts yet'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
  });

  goldenVariants(
    'status_tag',
    () => const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        StatusTag(label: 'Valid', tone: StatusTone.ok, dot: true),
        StatusTag(label: 'Renew soon', tone: StatusTone.warn),
        StatusTag(label: 'Changes requested', tone: StatusTone.bad),
        StatusTag(
          label: 'Owned',
          tone: StatusTone.brand,
          icon: Icons.check_rounded,
        ),
        StatusTag(label: 'Verifying', tone: StatusTone.blue),
        StatusTag(label: 'Not requested'),
      ],
    ),
    size: const Size(390, 130),
  );

  goldenVariants(
    'stat_tile',
    () => Row(
      children: <Widget>[
        Expanded(
          child: StatTile(
            label: 'Avg. completion',
            value: Formats.percent(64),
            caption: '+6 this month',
            icon: Icons.insert_chart_outlined_rounded,
            tone: StatusTone.ok,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatTile(
            label: 'Pending sign-offs',
            value: Formats.integer(2),
            caption: 'Oldest 2 days',
            tone: StatusTone.warn,
          ),
        ),
      ],
    ),
    size: const Size(390, 170),
  );

  goldenVariants(
    'empty_state',
    () => const SizedBox(
      height: 260,
      child: EmptyState(
        title: 'Queue is clear',
        message: 'New sign-off requests will appear here.',
      ),
    ),
    size: const Size(390, 300),
  );
}
