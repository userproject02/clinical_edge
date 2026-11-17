import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:material_ui/material_ui.dart';

/// Loading placeholder with a shimmer that sweeps every 1.2 s, moving from
/// the start edge to the end edge. Static with reduced motion.
class SkeletonBox extends StatefulWidget {
  /// Creates a skeleton.
  const new({
    this.width,
    this.height = 16,
    this.radius = AppRadii.card,
    super.key,
  });

  /// Width (fills the parent when null).
  final double? width;

  /// Height.
  final double height;

  /// Corner radius.
  final double radius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Motion.shimmer,
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
    final c = context.colors;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Semantics(
      label: AppLocalizations.of(context).loading,
      excludeSemantics: true,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          // CSS: 200 % wide gradient, background-position sliding one width.
          final shift = (rtl ? -1 : 1) * (_c.value * 2 - 1);
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              gradient: Motion.enabled(context)
                  ? LinearGradient(
                      begin: Alignment(-1 + shift * 2, 0),
                      end: Alignment(1 + shift * 2, 0),
                      colors: <Color>[c.surface2, c.outline, c.surface2],
                    )
                  : null,
              color: Motion.enabled(context) ? null : c.surface2,
            ),
          );
        },
      ),
    );
  }
}
