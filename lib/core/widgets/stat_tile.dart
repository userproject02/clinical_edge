import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/widgets/status_tag.dart';
import 'package:material_ui/material_ui.dart';

/// KPI card: caption label, large value and an optional supporting line.
///
/// Pass numbers already formatted (and LTR-isolated) with `Formats`.
class StatTile extends StatelessWidget {
  /// Creates the tile.
  const new({
    required this.label,
    required this.value,
    this.caption,
    this.icon,
    this.tone = StatusTone.brand,
    this.onTap,
    super.key,
  });

  /// What is measured.
  final String label;

  /// The figure.
  final String value;

  /// Supporting line under the value.
  final String? caption;

  /// Optional icon in a tinted square.
  final IconData? icon;

  /// Tone of the icon square and caption.
  final StatusTone tone;

  /// Optional tap.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final content = Padding(
      padding: const EdgeInsets.all(AppSpacing.card),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: tone.background(c),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 16, color: tone.foreground(c)),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.caption.copyWith(color: c.muted),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: context.screenTitle.copyWith(letterSpacing: 0),
          ),
          if (caption != null) ...<Widget>[
            const SizedBox(height: 2),
            Text(
              caption!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.caption.copyWith(color: tone.foreground(c)),
            ),
          ],
        ],
      ),
    );
    return Semantics(
      container: true,
      button: onTap != null,
      child: Material(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        clipBehavior: Clip.antiAlias,
        child: onTap == null ? content : InkWell(onTap: onTap, child: content),
      ),
    );
  }
}
