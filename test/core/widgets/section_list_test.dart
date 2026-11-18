import 'package:clinical_edge/core/widgets/section_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Future<void> _pump(WidgetTester tester, double width) async {
  tester.view.physicalSize = Size(width, 1200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: SectionList(
          sections: <Widget>[
            SizedBox(key: Key('a'), height: 300),
            SizedBox(key: Key('b'), height: 80),
            SizedBox(key: Key('c'), height: 100),
            SizedBox(key: Key('d'), height: 100),
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('TC-NFR-TAB-02 two columns stack independently (no gaps)', (
    tester,
  ) async {
    await _pump(tester, 1000);
    final a = tester.getRect(find.byKey(const Key('a')));
    final b = tester.getRect(find.byKey(const Key('b')));
    final c = tester.getRect(find.byKey(const Key('c')));
    final d = tester.getRect(find.byKey(const Key('d')));
    // a, c on the start side; b, d on the end side.
    expect(c.left, a.left);
    expect(d.left, b.left);
    expect(b.left, greaterThan(a.left));
    // d sits right under the short b, not under the tall a.
    expect(d.top, b.bottom + 14);
    expect(c.top, a.bottom + 14);
  });

  testWidgets('TC-NFR-TAB-03 phone width keeps a single column', (
    tester,
  ) async {
    await _pump(tester, 430);
    final a = tester.getRect(find.byKey(const Key('a')));
    final b = tester.getRect(find.byKey(const Key('b')));
    expect(b.left, a.left);
    expect(b.top, a.bottom + 14);
  });
}
