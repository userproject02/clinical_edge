import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:material_ui/material_ui.dart';

/// Animated heartbeat trace used on the sign-in hero and hero cards.
///
/// Draws the prototype's ECG path (viewBox 900 × 140, scaled to fit and
/// centred) with a travelling dash that loops every 3.6 s. With reduced
/// motion the full trace is drawn statically. Decorative: excluded from
/// semantics.
class EcgLine extends StatefulWidget {
  /// Creates the trace.
  const new({
    this.color,
    this.opacity = 0.35,
    this.strokeWidth = 3,
    this.height = 90,
    super.key,
  });

  /// Stroke colour (defaults to the hero accent token).
  final Color? color;

  /// Overall opacity.
  final double opacity;

  /// Stroke width in viewBox units.
  final double strokeWidth;

  /// Height of the drawing box.
  final double height;

  @override
  State<EcgLine> createState() => _EcgLineState();
}

class _EcgLineState extends State<EcgLine> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Motion.ecg,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Motion.enabled(context)) {
      if (!_c.isAnimating) _c.repeat();
    } else {
      _c
        ..stop()
        ..value = 1;
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? context.colors.heroAccent;
    return ExcludeSemantics(
      child: Opacity(
        opacity: widget.opacity,
        child: SizedBox(
          height: widget.height,
          width: double.infinity,
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _EcgPainter(
                progress: _c,
                color: color,
                strokeWidth: widget.strokeWidth,
                animated: Motion.enabled(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EcgPainter extends CustomPainter {
  new({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.animated,
  }) : super(repaint: progress);

  final Animation<double> progress;
  final Color color;
  final double strokeWidth;
  final bool animated;

  static const double _vbW = 900;
  static const double _vbH = 140;
  static const double _dash = 900;

  static final Path _path = Path()
    ..moveTo(0, 80)
    ..lineTo(260, 80)
    ..lineTo(285, 80)
    ..lineTo(300, 40)
    ..lineTo(320, 120)
    ..lineTo(340, 20)
    ..lineTo(360, 100)
    ..lineTo(375, 80)
    ..lineTo(560, 80)
    ..lineTo(580, 80)
    ..lineTo(592, 60)
    ..lineTo(604, 96)
    ..lineTo(616, 80)
    ..lineTo(900, 80);

  @override
  void paint(Canvas canvas, Size size) {
    final scale = (size.width / _vbW) < (size.height / _vbH)
        ? size.width / _vbW
        : size.height / _vbH;
    final dx = (size.width - _vbW * scale) / 2;
    final dy = (size.height - _vbH * scale) / 2;

    canvas
      ..save()
      ..translate(dx, dy)
      ..scale(scale);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (!animated) {
      canvas
        ..drawPath(_path, paint)
        ..restore();
      return;
    }

    // CSS: stroke-dasharray 900; stroke-dashoffset 900 → 0.
    // A point at distance s is drawn when (s + offset) mod 1800 < 900.
    final offset = _dash * (1 - progress.value);
    final visible = Path();
    for (final m in _path.computeMetrics()) {
      final len = m.length;
      // Visible windows: [k*1800 - offset, k*1800 - offset + 900).
      for (var k = 0; k * 2 * _dash - offset < len; k++) {
        final start = k * 2 * _dash - offset;
        final end = start + _dash;
        final s = start < 0 ? 0.0 : start;
        final e = end > len ? len : end;
        if (e > s) visible.addPath(m.extractPath(s, e), Offset.zero);
      }
    }
    canvas
      ..drawPath(visible, paint)
      ..restore();
  }

  @override
  bool shouldRepaint(_EcgPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.animated != animated;
}

/// The ClinicalEdge app mark: a rounded square with a small heartbeat glyph.
class AppMark extends StatelessWidget {
  /// Creates the mark.
  const new({this.size = 36, this.background, this.foreground, super.key});

  /// Edge length.
  final double size;

  /// Square colour (defaults to brand).
  final Color? background;

  /// Glyph colour (defaults to on-brand).
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _MarkPainter(
            background: background ?? c.brand,
            foreground: foreground ?? c.onBrand,
          ),
        ),
      ),
    );
  }
}

class _MarkPainter extends CustomPainter {
  new({required this.background, required this.foreground});

  final Color background;
  final Color foreground;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 36;
    canvas
      ..save()
      ..scale(s)
      ..drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(0, 0, 36, 36),
          const Radius.circular(10),
        ),
        Paint()..color = background,
      );
    final glyph = Path()
      ..moveTo(8, 19)
      ..lineTo(13, 19)
      ..lineTo(15.5, 13)
      ..lineTo(19.5, 24)
      ..lineTo(22.5, 16)
      ..lineTo(24, 19)
      ..lineTo(28, 19);
    canvas
      ..drawPath(
        glyph,
        Paint()
          ..color = foreground
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_MarkPainter old) =>
      old.background != background || old.foreground != foreground;
}
