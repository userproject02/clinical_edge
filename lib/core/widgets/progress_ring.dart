import 'dart:math' as math;

import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:material_ui/material_ui.dart';

/// Circular progress with an animated sweep and a centre label.
///
/// The arc starts at 12 o'clock and sweeps clockwise over 1.3 s (from the
/// previous value when [value] changes). The centre label is one line that
/// shrinks to fit and never wraps. Screen readers get [semanticLabel] plus
/// the percentage.
class ProgressRing extends StatelessWidget {
  /// Creates the ring.
  const new({
    required this.value,
    required this.semanticLabel,
    this.size = 84,
    this.strokeWidth = 10,
    this.color,
    this.trackColor,
    this.label,
    this.labelStyle,
    super.key,
  });

  /// Progress 0–1.
  final double value;

  /// What the ring measures, for screen readers.
  final String semanticLabel;

  /// Outer diameter.
  final double size;

  /// Arc thickness, in the prototype's 100-unit viewBox (scaled to [size]).
  final double strokeWidth;

  /// Arc colour (defaults to brand).
  final Color? color;

  /// Track colour (defaults to surface2).
  final Color? trackColor;

  /// Centre text (defaults to the percentage).
  final String? label;

  /// Centre text style.
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final target = value.clamp(0.0, 1.0);
    final percent = Formats.percent(target * 100);
    final text = label ?? percent;
    return Semantics(
      label: semanticLabel,
      value: percent,
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: size,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: target),
          duration: Motion.duration(
            context,
            Motion.ringDelay + Motion.ringSweep,
          ),
          curve: Interval(
            Motion.ringDelay.inMicroseconds /
                (Motion.ringDelay + Motion.ringSweep).inMicroseconds,
            1,
            curve: Motion.standard,
          ),
          builder: (context, v, child) => CustomPaint(
            painter: _RingPainter(
              value: v,
              color: color ?? c.brand,
              track: trackColor ?? c.surface2,
              stroke: strokeWidth * size / 100,
            ),
            child: child,
          ),
          child: Padding(
            padding: EdgeInsets.all(strokeWidth * size / 100 + 4),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  maxLines: 1,
                  softWrap: false,
                  style:
                      labelStyle ??
                      context.cardTitle.copyWith(
                        fontSize: size * 0.22,
                        letterSpacing: 0,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  new({
    required this.value,
    required this.color,
    required this.track,
    required this.stroke,
  });

  final double value;
  final Color color;
  final Color track;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    // Prototype: r = 42 in a 100 viewBox.
    final radius = size.width * 0.42;
    final center = size.center(Offset.zero);
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = track
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke,
    );
    if (value <= 0) return;
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * value,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value ||
      old.color != color ||
      old.track != track ||
      old.stroke != stroke;
}
