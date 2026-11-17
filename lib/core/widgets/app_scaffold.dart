import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/widgets/pulsing_dot.dart';
import 'package:material_ui/material_ui.dart';

/// Screen scaffold with one of the two prototype app bars.
///
/// * [AppScaffold.tab] — top-level tab screens: subtitle over a 22/700 title,
///   a bell with a pulsing unread dot, and the avatar button.
/// * [AppScaffold.detail] — pushed screens: a back arrow that mirrors in RTL
///   and a 17/700 title, with an optional coloured bar.
class AppScaffold extends StatelessWidget {
  /// Tab screen scaffold.
  const new tab({
    required this.title,
    required this.body,
    this.subtitle,
    this.actions = const <Widget>[],
    this.onBellPressed,
    this.hasUnread = false,
    this.avatarInitials,
    this.onAvatarPressed,
    this.bottomBar,
    super.key,
  }) : _detail = false,
       onBack = null,
       barColor = null,
       barForeground = null;

  /// Detail (pushed) screen scaffold.
  const new detail({
    required this.title,
    required this.body,
    this.onBack,
    this.barColor,
    this.barForeground,
    this.actions = const <Widget>[],
    this.bottomBar,
    super.key,
  }) : _detail = true,
       subtitle = null,
       onBellPressed = null,
       hasUnread = false,
       avatarInitials = null,
       onAvatarPressed = null;

  final bool _detail;

  /// Title text.
  final String title;

  /// Small line above the title (tab bar only).
  final String? subtitle;

  /// Screen content.
  final Widget body;

  /// Extra icon buttons before the bell (tab) or after the title (detail).
  final List<Widget> actions;

  /// Bell tap. The bell is hidden when null.
  final VoidCallback? onBellPressed;

  /// Shows the pulsing dot on the bell.
  final bool hasUnread;

  /// Initials in the avatar button. The avatar is hidden when null.
  final String? avatarInitials;

  /// Avatar tap.
  final VoidCallback? onAvatarPressed;

  /// Back tap (defaults to `Navigator.maybePop`).
  final VoidCallback? onBack;

  /// Detail bar background (defaults to the screen background).
  final Color? barColor;

  /// Detail bar foreground.
  final Color? barForeground;

  /// Sticky content at the bottom (CTA bar).
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        children: <Widget>[
          if (_detail) _DetailBar(scaffold: this) else _TabBar(scaffold: this),
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: bottomBar,
    );
  }
}

class _TabBar extends StatelessWidget {
  const new({required this.scaffold});

  final AppScaffold scaffold;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = AppLocalizations.of(context);
    final s = scaffold;
    return ColoredBox(
      color: c.background,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 14, 10, 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Semantics(
                  header: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (s.subtitle != null)
                        Text(
                          s.subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.caption.copyWith(color: c.muted),
                        ),
                      Text(
                        s.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.screenTitle,
                      ),
                    ],
                  ),
                ),
              ),
              ...s.actions,
              if (s.onBellPressed != null)
                _BellButton(
                  onPressed: s.onBellPressed!,
                  hasUnread: s.hasUnread,
                  label: l10n.actionNotifications,
                ),
              if (s.avatarInitials != null)
                Semantics(
                  button: true,
                  label: l10n.actionProfile,
                  excludeSemantics: true,
                  child: SizedBox.square(
                    dimension: 48,
                    child: InkResponse(
                      onTap: s.onAvatarPressed,
                      radius: 24,
                      child: Center(
                        child: Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: c.brandSoft,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            s.avatarInitials!,
                            style: context.cardTitle.copyWith(
                              color: c.brand,
                              fontSize: 13,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BellButton extends StatelessWidget {
  const new({
    required this.onPressed,
    required this.hasUnread,
    required this.label,
  });

  final VoidCallback onPressed;
  final bool hasUnread;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox.square(
      dimension: 48,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: IconButton(
              onPressed: onPressed,
              tooltip: label,
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ),
          if (hasUnread)
            PositionedDirectional(
              top: 11,
              end: 12,
              child: IgnorePointer(
                child: PulsingDot(
                  color: c.alertDot,
                  size: 10,
                  borderColor: c.background,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailBar extends StatelessWidget {
  const new({required this.scaffold});

  final AppScaffold scaffold;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = AppLocalizations.of(context);
    final s = scaffold;
    final bg = s.barColor ?? c.background;
    final fg = s.barForeground ?? c.text;
    return ColoredBox(
      color: bg,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: IconTheme.merge(
            data: IconThemeData(color: fg),
            child: Row(
              children: <Widget>[
                IconButton(
                  tooltip: l10n.actionBack,
                  onPressed: s.onBack ?? () => Navigator.maybePop(context),
                  // Icons.arrow_back matches the text direction, so it mirrors
                  // automatically in RTL.
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      s.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.sectionTitle.copyWith(
                        fontSize: 17,
                        color: fg,
                      ),
                    ),
                  ),
                ),
                ...s.actions,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
