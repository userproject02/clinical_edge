import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

/// Widest the app grows in a browser: a large phone, so the phone layouts the
/// prototype is designed for are what a desktop browser shows.
const double kWebFrameMaxWidth = 480;

/// Browser windows at or below this width are treated as phones and fill the
/// window (no frame).
const double kWebFrameBreakpoint = 600;

/// Centres the app in a phone-width column on wide browser windows (desktop
/// Safari and Chrome); on phones, native builds and tests it is transparent.
///
/// The column's [MediaQuery] reports its own size, so `LayoutBuilder` and
/// media-query checks inside see a phone, not the whole window.
class WebFrame extends StatelessWidget {
  /// Creates the frame. [enabled] defaults to web builds only.
  const new({required this.child, this.enabled = kIsWeb, super.key});

  /// The app.
  final Widget child;

  /// Whether to frame wide windows (tests override it).
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    if (!enabled || media.size.width <= kWebFrameBreakpoint) return child;

    final colors = context.colors;
    final width = media.size.width < kWebFrameMaxWidth
        ? media.size.width
        : kWebFrameMaxWidth;
    return ColoredBox(
      key: const Key('web.frame'),
      color: colors.surface2,
      child: Center(
        child: SizedBox(
          width: width,
          height: media.size.height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.background,
              border: BorderDirectional(
                start: BorderSide(color: colors.outline),
                end: BorderSide(color: colors.outline),
              ),
            ),
            child: MediaQuery(
              data: media.copyWith(size: Size(width, media.size.height)),
              child: ClipRect(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
