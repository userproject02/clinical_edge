import 'package:clinical_edge/core/motion.dart';
import 'package:material_ui/material_ui.dart';

/// A small status dot with an expanding halo that loops every 2.2 s
/// (expiry alerts, the bell's unread dot). The halo is a fading ring drawn
/// around the dot; the dot itself never scales.
class PulsingDot extends StatefulWidget {
  /// Creates the dot.
  const new({
    required this.color,
    this.size = 12,
    this.borderColor,
    this.haloColor,
    super.key,
  });

  /// Dot colour.
  final Color color;

  /// Diameter.
  final double size;

  /// Optional 2 px border (to separate the dot from an icon behind it).
  final Color? borderColor;

  /// Halo colour (defaults to [color]).
  final Color? haloColor;

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Motion.pulse,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Motion.enabled(context)) {
      if (!_c.isAnimating) _c.repeat();
    } else {
      _c
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final halo = widget.haloColor ?? widget.color;
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          // 0–70 %: halo grows 0 → 10 px and fades out; 70–100 %: rest.
          final t = (_c.value / 0.7).clamp(0.0, 1.0);
          final spread = 10 * t;
          final alpha = 0.45 * (1 - t);
          return Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
              border: widget.borderColor == null
                  ? null
                  : Border.all(color: widget.borderColor!, width: 2),
              boxShadow: <BoxShadow>[
                if (alpha > 0)
                  BoxShadow(
                    color: halo.withValues(alpha: alpha),
                    spreadRadius: spread,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
