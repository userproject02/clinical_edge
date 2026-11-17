import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/status_tag.dart';
import 'package:clinical_edge/core/widgets/timed_overlay.dart';
import 'package:material_ui/material_ui.dart';

/// Confirmation toast on the inverse surface with a coloured status dot.
///
/// Use [AppSnackBar.show] to present it; it slides up 24 px and fades in over
/// 400 ms, stays ~3 s and leaves the same way.
class AppSnackBar extends StatelessWidget {
  /// Creates the visual.
  const new({
    required this.title,
    this.message,
    this.tone = StatusTone.ok,
    super.key,
  });

  /// Bold first line.
  final String title;

  /// Optional second line.
  final String? message;

  /// Dot colour tone.
  final StatusTone tone;

  /// Shows a snackbar above the bottom bar.
  static TimedOverlayHandle show(
    BuildContext context, {
    required String title,
    String? message,
    StatusTone tone = StatusTone.ok,
    double bottomInset = 88,
  }) {
    return showTimedOverlay(
      context: context,
      edge: OverlayEdge.bottom,
      animation: Motion.snackbar,
      visibleFor: Motion.snackbarVisible,
      offset: Motion.snackbarSlide,
      margin: EdgeInsetsDirectional.fromSTEB(12, 0, 12, bottomInset),
      child: AppSnackBar(title: title, message: message, tone: tone),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    // On the inverse surface, the dot uses the opposite theme's tone colour
    // so it stays visible (light dot on dark snackbar and vice versa).
    final dark = Theme.of(context).brightness == Brightness.dark;
    final dot = tone.foreground(dark ? AppColors.light : AppColors.dark);
    return Semantics(
      liveRegion: true,
      container: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        decoration: BoxDecoration(
          color: c.inverse,
          borderRadius: BorderRadius.circular(AppRadii.field),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 28,
              offset: Offset(0, 12),
              spreadRadius: -12,
            ),
          ],
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
        child: Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: context.caption.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: c.onInverse,
                    ),
                  ),
                  if (message != null)
                    Text(
                      message!,
                      style: context.caption.copyWith(
                        color: c.onInverse.withValues(alpha: 0.8),
                      ),
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
