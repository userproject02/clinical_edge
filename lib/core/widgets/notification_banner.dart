import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/ecg_line.dart';
import 'package:clinical_edge/core/widgets/timed_overlay.dart';
import 'package:material_ui/material_ui.dart';

/// Simulated push notification that drops in from the top of the screen.
///
/// Use [NotificationBanner.show]: it slides down from above the top edge and
/// fades in over 500 ms, stays ~4 s and leaves the same way.
class NotificationBanner extends StatelessWidget {
  /// Creates the visual.
  const new({required this.title, this.message, super.key});

  /// Bold line.
  final String title;

  /// Body line.
  final String? message;

  /// Shows the banner at the top of the root overlay.
  static TimedOverlayHandle show(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    return showTimedOverlay(
      context: context,
      edge: OverlayEdge.top,
      animation: Motion.banner,
      visibleFor: Motion.bannerVisible,
      offset: -1.1,
      margin: const EdgeInsets.all(10),
      child: NotificationBanner(title: title, message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = AppLocalizations.of(context);
    return Semantics(
      liveRegion: true,
      container: true,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(AppRadii.banner),
            border: Border.all(color: c.outline),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x73000000),
                blurRadius: 36,
                offset: Offset(0, 16),
                spreadRadius: -14,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppMark(
                size: 38,
                background: AppColors.light.brand,
                foreground: AppColors.light.onBrand,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            l10n.notificationAppName,
                            style: context.micro.copyWith(
                              color: c.muted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          l10n.notificationNow,
                          style: context.micro.copyWith(
                            color: c.muted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      title,
                      style: context.body.copyWith(fontWeight: FontWeight.w700),
                    ),
                    if (message != null)
                      Text(
                        message!,
                        style: context.caption.copyWith(
                          fontSize: 13,
                          color: c.muted,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
