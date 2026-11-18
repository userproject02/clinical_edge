import 'package:clinical_edge/core/motion.dart';
import 'package:material_ui/material_ui.dart';

/// Width from which section lists reflow into two columns (tablets).
const double twoColumnBreakpoint = 700;

/// Scrolling list of dashboard sections with the staggered fade-up
/// entrance. On wide screens (tablets) sections reflow into two independent
/// columns, alternating start/end in reading order (mirrors in RTL).
class SectionList extends StatelessWidget {
  /// Creates the list.
  const new({
    required this.sections,
    this.padding = const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 24),
    this.gap = 14,
    super.key,
  });

  /// Sections in reading order.
  final List<Widget> sections;

  /// List padding.
  final EdgeInsetsGeometry padding;

  /// Space between sections.
  final double gap;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    // The width actually available (not the screen), so split views and
    // tests behave too.
    builder: (context, box) =>
        _build(context, wide: box.maxWidth >= twoColumnBreakpoint),
  );

  Widget _build(BuildContext context, {required bool wide}) {
    final items = <Widget>[
      for (final (i, w) in sections.indexed) FadeUpIn(index: i, child: w),
    ];
    if (!wide) {
      return ListView(
        padding: padding,
        children: <Widget>[
          for (final (i, w) in items.indexed) ...<Widget>[
            if (i > 0) SizedBox(height: gap),
            w,
          ],
        ],
      );
    }
    // Two independent columns (start: 1st, 3rd, …; end: 2nd, 4th, …), so a
    // short section never leaves a gap beside a tall one.
    Widget column(int parity) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (var i = parity; i < items.length; i += 2) ...<Widget>[
          if (i > parity) SizedBox(height: gap),
          items[i],
        ],
      ],
    );
    return ListView(
      padding: padding,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: column(0)),
            SizedBox(width: gap),
            Expanded(child: column(1)),
          ],
        ),
      ],
    );
  }
}
