import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/widgets/segmented_picker.dart';
import 'package:material_ui/material_ui.dart';

/// Horizontally scrolling row of single-select filter chips (catalogue
/// categories, audit filters). Scrolls from the start edge in both LTR and
/// RTL. Each chip has a 48 dp touch target around a 36 dp visual.
class FilterChipRow<T> extends StatelessWidget {
  /// Creates the row.
  const new({
    required this.options,
    required this.selected,
    required this.onSelected,
    this.padding = const EdgeInsetsDirectional.symmetric(horizontal: 16),
    super.key,
  });

  /// Chips in order.
  final List<Segment<T>> options;

  /// Selected value.
  final T selected;

  /// Selection handler.
  final ValueChanged<T> onSelected;

  /// Padding around the scrolling content.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: options.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final o = options[i];
          return _Chip(
            label: o.label,
            selected: o.value == selected,
            onTap: () => onSelected(o.value),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const new({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final radius = BorderRadius.circular(AppRadii.chip);
    return Semantics(
      selected: selected,
      button: true,
      child: Center(
        child: Material(
          color: selected ? c.brandSoft : c.surface,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(color: selected ? c.brand : c.outline),
          ),
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              child: Text(
                label,
                style: context.caption.copyWith(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  color: selected ? c.brand : c.text,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
