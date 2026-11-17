import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';

/// White rounded card with a title row used by every admin chart.
class AdminCard extends StatelessWidget {
  /// Creates the card.
  const new({
    required this.title,
    required this.child,
    this.trailing,
    this.subtitle,
    super.key,
  });

  /// Optional line under the title (wraps).
  final String? subtitle;

  /// Title.
  final String title;

  /// Optional widget at the end of the title row (tag).
  final Widget? trailing;

  /// Content.
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(AppRadii.cardLarge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Text(title, style: context.cardTitle)),
            if (trailing != null) ...<Widget>[
              const SizedBox(width: 8),
              trailing!,
            ],
          ],
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              subtitle!,
              style: context.micro.copyWith(color: context.colors.muted),
            ),
          ),
        const SizedBox(height: 14),
        child,
      ],
    ),
  );
}

/// One bar.
typedef BarDatum = ({String label, double value, Color color, String text});

/// Vertical bar chart on fl_chart: grows from 0 on entry (instant with
/// reduced motion) and lists bars from the start edge (mirrored in RTL).
/// Axis labels are drawn below the chart.
class VBarChart extends StatefulWidget {
  /// Creates the chart.
  const new({
    required this.bars,
    required this.semanticLabel,
    this.maxY = 100,
    this.height = 150,
    super.key,
  });

  /// Bars in reading order.
  final List<BarDatum> bars;

  /// Accessible summary.
  final String semanticLabel;

  /// Top of the y axis.
  final double maxY;

  /// Chart height.
  final double height;

  @override
  State<VBarChart> createState() => _VBarChartState();
}

class _VBarChartState extends State<VBarChart> {
  bool _shown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!Motion.enabled(context)) {
      _shown = true;
    } else if (!_shown) {
      Future<void>.delayed(Motion.barDelay, () {
        if (mounted) setState(() => _shown = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final bars = rtl ? widget.bars.reversed.toList() : widget.bars;
    return Semantics(
      label: widget.semanticLabel,
      container: true,
      child: ExcludeSemantics(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: widget.height,
              child: BarChart(
                BarChartData(
                  maxY: widget.maxY,
                  minY: 0,
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: const BarTouchData(enabled: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    horizontalInterval: widget.maxY / 4,
                    getDrawingHorizontalLine: (_) =>
                        FlLine(color: c.outline, strokeWidth: 1),
                  ),
                  barGroups: <BarChartGroupData>[
                    for (final (i, b) in bars.indexed)
                      BarChartGroupData(
                        x: i,
                        barRods: <BarChartRodData>[
                          BarChartRodData(
                            toY: _shown ? b.value : 0,
                            color: b.color,
                            width: 22,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                duration: Motion.duration(context, Motion.barGrow),
                curve: Motion.standard,
              ),
            ),
            const SizedBox(height: 6),
            // Labels follow the reading direction (Row mirrors in RTL), so
            // use the original order here.
            Row(
              children: <Widget>[
                for (final b in widget.bars)
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          b.text,
                          textAlign: TextAlign.center,
                          style: context.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: b.color,
                          ),
                        ),
                        Text(
                          b.label,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.micro.copyWith(color: c.muted),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal bars (label, meter, value) that grow on entry; mirror in RTL
/// through [LinearMeter].
class HBarList extends StatelessWidget {
  /// Creates the list.
  const new({
    required this.bars,
    required this.semanticLabel,
    this.max = 100,
    super.key,
  });

  /// Bars.
  final List<BarDatum> bars;

  /// Accessible summary.
  final String semanticLabel;

  /// Value of a full bar.
  final double max;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      label: semanticLabel,
      container: true,
      child: ExcludeSemantics(
        child: Column(
          children: <Widget>[
            for (final b in bars)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            b.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.caption.copyWith(color: c.text),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          b.text,
                          style: context.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: c.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    LinearMeter(
                      value: max == 0 ? 0 : (b.value / max).clamp(0.0, 1.0),
                      height: 10,
                      color: b.color,
                      semanticLabel: b.label,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
