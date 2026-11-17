import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:material_ui/material_ui.dart';

/// Rounded horizontal meter that grows from the start edge (left in LTR,
/// right in RTL) over 1 s after a 150 ms delay.
class LinearMeter extends StatelessWidget {
  /// Creates the meter.
  const new({
    required this.value,
    required this.semanticLabel,
    this.height = 8,
    this.color,
    this.trackColor,
    super.key,
  });

  /// Fill 0–1.
  final double value;

  /// What the meter measures, for screen readers.
  final String semanticLabel;

  /// Bar thickness.
  final double height;

  /// Fill colour (defaults to brand).
  final Color? color;

  /// Track colour (defaults to surface2).
  final Color? trackColor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final target = value.clamp(0.0, 1.0);
    final radius = BorderRadius.circular(height / 2);
    final total = Motion.barDelay + Motion.barGrow;
    final delayFraction = Motion.barDelay.inMicroseconds / total.inMicroseconds;
    return Semantics(
      label: semanticLabel,
      value: Formats.percent(target * 100),
      excludeSemantics: true,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: trackColor ?? c.surface2,
          borderRadius: radius,
        ),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: target),
          duration: Motion.duration(context, total),
          curve: Interval(delayFraction, 1, curve: Motion.standard),
          builder: (context, v, _) => FractionallySizedBox(
            alignment: AlignmentDirectional.centerStart,
            widthFactor: v,
            heightFactor: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color ?? c.brand,
                borderRadius: radius,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
