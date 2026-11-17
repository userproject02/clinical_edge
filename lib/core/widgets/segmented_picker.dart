import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:material_ui/material_ui.dart';

/// One option of a [SegmentedPicker].
@immutable
class Segment<T> {
  /// Creates an option.
  const new({required this.value, required this.label});

  /// Value reported on selection.
  final T value;

  /// Visible label.
  final String label;
}

/// Stadium segmented control (role picker, theme, language).
///
/// Equal-width segments separated by hairlines; the selected one gets the
/// brand-soft fill with bold brand text. Each segment is ≥ 48 dp tall.
class SegmentedPicker<T> extends StatelessWidget {
  /// Creates the picker.
  const new({
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.semanticLabel,
    super.key,
  });

  /// Options in reading order (they follow the text direction).
  final List<Segment<T>> segments;

  /// Currently selected value.
  final T selected;

  /// Selection handler.
  final ValueChanged<T> onChanged;

  /// Optional group label for screen readers.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      container: true,
      label: semanticLabel,
      child: Container(
        decoration: ShapeDecoration(
          color: c.surface,
          shape: StadiumBorder(side: BorderSide(color: c.outline)),
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              for (var i = 0; i < segments.length; i++) ...<Widget>[
                if (i > 0) VerticalDivider(width: 1, color: c.outline),
                Expanded(child: _segment(context, segments[i])),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _segment(BuildContext context, Segment<T> s) {
    final c = context.colors;
    final on = s.value == selected;
    return Semantics(
      selected: on,
      button: true,
      inMutuallyExclusiveGroup: true,
      child: Material(
        color: on ? c.brandSoft : FixedColors.transparent,
        child: InkWell(
          onTap: on ? null : () => onChanged(s.value),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: context.caption.copyWith(
              fontSize: 13,
              fontWeight: on ? FontWeight.w700 : FontWeight.w600,
              color: on ? c.brand : c.muted,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    s.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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
