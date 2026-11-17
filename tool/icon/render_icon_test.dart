// Renders the logo mark (heartbeat in a rounded square, #0A6E73) to PNGs
// used by flutter_launcher_icons and flutter_native_splash.
// Run: flutter test tool/icon/render_icon_test.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:clinical_edge/core/widgets/ecg_line.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _brand = Color(0xFF0A6E73);
const _white = Color(0xFFFFFFFF);

Future<void> _render(
  WidgetTester tester,
  String path, {
  required double size,
  required double markSize,
  Color? fill,
}) async {
  final key = GlobalKey();
  await tester.binding.setSurfaceSize(Size(size, size));
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: RepaintBoundary(
        key: key,
        child: ColoredBox(
          color: fill ?? const Color(0x00000000),
          child: Center(
            child: AppMark(
              size: markSize,
              background: _brand,
              foreground: _white,
            ),
          ),
        ),
      ),
    ),
  );
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final image = await tester.runAsync(boundary.toImage);
  final bytes = await tester.runAsync(
    () => image!.toByteData(format: ui.ImageByteFormat.png),
  );
  File(path).writeAsBytesSync(bytes!.buffer.asUint8List());
}

void main() {
  testWidgets('render app icon assets', (tester) async {
    // Full-bleed icon (iOS clips its own corners).
    await _render(
      tester,
      'assets/icon/icon.png',
      size: 1024,
      markSize: 1024,
      fill: _brand,
    );
    // Android adaptive foreground: mark inside the 66 % safe zone.
    await _render(
      tester,
      'assets/icon/icon_foreground.png',
      size: 1024,
      markSize: 600,
    );
    // Splash logo.
    await _render(tester, 'assets/icon/splash.png', size: 768, markSize: 384);
  });
}
