import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:material_ui/material_ui.dart';

/// Colour tone of a [StatusTag] (and other status-aware widgets).
enum StatusTone {
  /// Valid, approved, passed.
  ok,

  /// Renew soon, pending.
  warn,

  /// Rejected, failed, expired.
  bad,

  /// Brand emphasis (owned, in progress).
  brand,

  /// Informational (verifying).
  blue,

  /// Neutral (not requested, locked).
  neutral,
}

/// Foreground/background pair for a [StatusTone].
extension StatusToneColors on StatusTone {
  /// Foreground (text, icon, dot) colour.
  Color foreground(AppColors c) => switch (this) {
    StatusTone.ok => c.ok,
    StatusTone.warn => c.warn,
    StatusTone.bad => c.bad,
    StatusTone.brand => c.brand,
    StatusTone.blue => c.blue,
    StatusTone.neutral => c.muted,
  };

  /// Background colour.
  Color background(AppColors c) => switch (this) {
    StatusTone.ok => c.okSoft,
    StatusTone.warn => c.warnSoft,
    StatusTone.bad => c.badSoft,
    StatusTone.brand => c.brandSoft,
    StatusTone.blue => c.blueSoft,
    StatusTone.neutral => c.surface2,
  };
}

/// Small rounded status label: 12/600 text on a tinted background.
class StatusTag extends StatelessWidget {
  /// Creates the tag.
  const new({
    required this.label,
    this.tone = StatusTone.neutral,
    this.icon,
    this.dot = false,
    super.key,
  });

  /// Label text.
  final String label;

  /// Colour tone.
  final StatusTone tone;

  /// Optional leading icon.
  final IconData? icon;

  /// Shows a leading dot (when no [icon]).
  final bool dot;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fg = tone.foreground(c);
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 3, 10, 3),
      decoration: BoxDecoration(
        color: tone.background(c),
        borderRadius: BorderRadius.circular(AppRadii.tag),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
          ] else if (dot) ...<Widget>[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          // Never wraps; if squeezed (large text in a narrow slot) it fades
          // instead of overflowing.
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: context.caption.copyWith(
                color: fg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
