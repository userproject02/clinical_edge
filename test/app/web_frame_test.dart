import 'package:clinical_edge/app/theme/app_theme.dart';
import 'package:clinical_edge/app/web_frame.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Future<void> _pump(
  WidgetTester tester, {
  required Size size,
  bool enabled = true,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: WebFrame(
        enabled: enabled,
        child: Builder(
          builder: (context) => Text(
            '${MediaQuery.sizeOf(context).width}',
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('TC-WEB-01 wide window: phone-width centred column', (
    tester,
  ) async {
    await _pump(tester, size: const Size(1440, 900));
    expect(find.byKey(const Key('web.frame')), findsOneWidget);
    // Content sees the column width, not the window.
    expect(find.text('$kWebFrameMaxWidth'), findsOneWidget);
    final box = tester.getRect(
      find.descendant(
        of: find.byKey(const Key('web.frame')),
        matching: find.byType(SizedBox),
      ),
    );
    expect(box.width, kWebFrameMaxWidth);
    expect(box.center.dx, 720);
  });

  testWidgets('TC-WEB-02 phone-width window: no frame, full width', (
    tester,
  ) async {
    await _pump(tester, size: const Size(430, 932));
    expect(find.byKey(const Key('web.frame')), findsNothing);
    expect(find.text('430.0'), findsOneWidget);
  });

  testWidgets('TC-WEB-03 disabled (native builds): never framed', (
    tester,
  ) async {
    await _pump(tester, size: const Size(1440, 900), enabled: false);
    expect(find.byKey(const Key('web.frame')), findsNothing);
  });
}
