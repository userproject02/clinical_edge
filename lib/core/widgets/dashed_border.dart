import 'package:material_ui/material_ui.dart';

/// Paints a dashed rounded-rectangle border around [child] (drop zones,
/// secondary actions such as "Simulate expiry reminder").
class DashedBorder extends StatelessWidget {
  /// Creates the border.
  const new({
    required this.child,
    required this.color,
    this.radius = 16,
    this.strokeWidth = 1.5,
    this.dash = 6,
    this.gap = 4,
    super.key,
  });

  /// Content.
  final Widget child;

  /// Dash colour.
  final Color color;

  /// Corner radius.
  final double radius;

  /// Line width.
  final double strokeWidth;

  /// Dash length.
  final double dash;

  /// Gap length.
  final double gap;

  @override
  Widget build(BuildContext context) => CustomPaint(
    foregroundPainter: _DashedPainter(
      color: color,
      radius: radius,
      strokeWidth: strokeWidth,
      dash: dash,
      gap: gap,
    ),
    child: child,
  );
}

class _DashedPainter extends CustomPainter {
  new({
    required this.color,
    required this.radius,
    required this.strokeWidth,
    required this.dash,
    required this.gap,
  });

  final Color color;
  final double radius;
  final double strokeWidth;
  final double dash;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final inset = strokeWidth / 2;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        inset,
        inset,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final metric = (Path()..addRRect(rrect)).computeMetrics().first;
    for (var d = 0.0; d < metric.length; d += dash + gap) {
      canvas.drawPath(metric.extractPath(d, d + dash), paint);
    }
  }

  @override
  bool shouldRepaint(_DashedPainter old) =>
      old.color != color || old.radius != radius || old.dash != dash;
}
