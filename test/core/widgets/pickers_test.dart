import 'package:clinical_edge/core/widgets/filter_chip_row.dart';
import 'package:clinical_edge/core/widgets/segmented_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden.dart';
import '../../helpers/test_app.dart';

const _roles = <Segment<String>>[
  Segment(value: 'learner', label: 'Learner'),
  Segment(value: 'supervisor', label: 'Supervisor'),
  Segment(value: 'admin', label: 'Admin'),
];

const _cats = <Segment<String>>[
  Segment(value: 'all', label: 'All'),
  Segment(value: 'res', label: 'Resuscitation'),
  Segment(value: 'ipc', label: 'Infection control'),
  Segment(value: 'med', label: 'Medication safety'),
];

void main() {
  group('SegmentedPicker', () {
    testWidgets('TC-PH1-17 selects a segment; segments are ≥ 48 dp', (
      tester,
    ) async {
      var value = 'learner';
      await pumpTestApp(
        tester,
        StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedPicker<String>(
              segments: _roles,
              selected: value,
              onChanged: (v) => setState(() => value = v),
            ),
          ),
        ),
      );
      expect(tester.getSize(find.text('Admin').first).height, lessThan(48));
      expect(
        tester.getSize(find.byType(SegmentedPicker<String>)).height,
        greaterThanOrEqualTo(48),
      );
      await tester.tap(find.text('Supervisor'));
      await tester.pump();
      expect(value, 'supervisor');
    });

    testWidgets('TC-PH1-18 order follows text direction', (tester) async {
      await pumpTestApp(
        tester,
        SegmentedPicker<String>(
          segments: _roles,
          selected: 'learner',
          onChanged: (_) {},
        ),
        variant: Variant.lightRtl,
      );
      final first = tester.getCenter(find.text('Learner')).dx;
      final last = tester.getCenter(find.text('Admin')).dx;
      expect(first, greaterThan(last));
    });
  });

  group('FilterChipRow', () {
    testWidgets('TC-PH1-19 selects a chip and scrolls horizontally', (
      tester,
    ) async {
      var value = 'all';
      await pumpTestApp(
        tester,
        StatefulBuilder(
          builder: (context, setState) => FilterChipRow<String>(
            options: _cats,
            selected: value,
            onSelected: (v) => setState(() => value = v),
          ),
        ),
        size: const Size(320, 200),
      );
      await tester.tap(find.text('Resuscitation'));
      await tester.pump();
      expect(value, 'res');
      final list = tester.widget<ListView>(find.byType(ListView));
      expect(list.scrollDirection, Axis.horizontal);
    });
  });

  goldenVariants(
    'segmented_picker',
    () => SegmentedPicker<String>(
      segments: _roles,
      selected: 'supervisor',
      onChanged: (_) {},
    ),
    size: const Size(390, 96),
  );

  goldenVariants(
    'filter_chip_row',
    () => FilterChipRow<String>(
      options: _cats,
      selected: 'res',
      onSelected: (_) {},
      padding: EdgeInsets.zero,
    ),
    size: const Size(390, 96),
  );
}
