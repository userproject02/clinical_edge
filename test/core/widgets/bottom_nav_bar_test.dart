import 'package:clinical_edge/core/widgets/bottom_nav_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden.dart';
import '../../helpers/test_app.dart';

const _items = <NavItem>[
  NavItem(icon: Icons.inbox_outlined, label: 'Queue', badge: 2),
  NavItem(icon: Icons.task_alt_outlined, label: 'Decided'),
  NavItem(icon: Icons.menu_book_outlined, label: 'Learn'),
];

void main() {
  testWidgets('TC-PH1-13 nav bar selects, shows badge and pill indicator', (
    tester,
  ) async {
    var selected = 0;
    await pumpTestApp(
      tester,
      StatefulBuilder(
        builder: (context, setState) => Align(
          alignment: Alignment.bottomCenter,
          child: BottomNavBar(
            items: _items,
            selectedIndex: selected,
            onSelected: (i) => setState(() => selected = i),
          ),
        ),
      ),
    );
    expect(find.textContaining('2'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('2 new')), findsOneWidget);
    await tester.tap(find.text('Learn'));
    await tester.pumpAndSettle();
    expect(selected, 2);
    final bar = tester.widget<NavigationBar>(find.byType(NavigationBar));
    expect(bar.selectedIndex, 2);
  });

  goldenVariants(
    'bottom_nav_bar',
    () => BottomNavBar(items: _items, selectedIndex: 0, onSelected: (_) {}),
    size: const Size(390, 120),
  );
}
