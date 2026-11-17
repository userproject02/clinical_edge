import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/session.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Picks a localized screen title.
typedef TitleOf = String Function(AppLocalizations l10n);

/// Phase 1 placeholder for a tab screen: tab app bar + title + route.
class TabPlaceholder extends ConsumerWidget {
  /// Creates the placeholder.
  const new({
    required this.title,
    required this.path,
    this.icon = Icons.dashboard_outlined,
    super.key,
  });

  /// Screen title.
  final TitleOf title;

  /// Route path, shown in mono for orientation.
  final String path;

  /// Illustration icon.
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final role = ref.watch(sessionProvider.select((s) => s.role));
    return AppScaffold.tab(
      subtitle: l10n.tenant,
      title: title(l10n),
      hasUnread: true,
      onBellPressed: () => NotificationBanner.show(
        context,
        title: l10n.notificationsEmptyTitle,
        message: l10n.notificationsEmptyBody,
      ),
      avatarInitials: role.stubInitials,
      onAvatarPressed: () => context.push(AppRoutes.profile),
      body: _PlaceholderBody(title: title(l10n), path: path, icon: icon),
    );
  }
}

/// Phase 1 placeholder for a pushed screen: detail app bar + title + route.
class DetailPlaceholder extends StatelessWidget {
  /// Creates the placeholder.
  const new({
    required this.title,
    required this.path,
    this.icon = Icons.article_outlined,
    this.hero = false,
    super.key,
  });

  /// Screen title.
  final TitleOf title;

  /// Route path.
  final String path;

  /// Illustration icon.
  final IconData icon;

  /// Uses the deep-teal hero bar (course detail, lesson player).
  final bool hero;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = context.colors;
    return AppScaffold.detail(
      title: title(l10n),
      barColor: hero ? c.hero : null,
      barForeground: hero ? c.onHero : null,
      body: _PlaceholderBody(title: title(l10n), path: path, icon: icon),
    );
  }
}

/// Upload certificate sheet placeholder (route `/certs/upload`).
class UploadSheetPlaceholder extends StatelessWidget {
  /// Creates the placeholder.
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppBottomSheet(
      title: l10n.titleUploadCert,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          l10n.placeholderBody,
          style: context.body.copyWith(color: context.colors.muted),
        ),
      ),
    );
  }
}

/// Sign-in placeholder: hero panel with the ECG line and the screen title.
class SignInPlaceholder extends StatelessWidget {
  /// Creates the placeholder.
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ColoredBox(
            color: c.hero,
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: <Widget>[
                  const PositionedDirectional(
                    start: 0,
                    end: 0,
                    bottom: 10,
                    child: EcgLine(),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      24,
                      28,
                      24,
                      96,
                    ),
                    child: Row(
                      children: <Widget>[
                        AppMark(
                          size: 34,
                          background: c.onHero,
                          foreground: c.hero,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                l10n.appTitle,
                                style: context.sectionTitle.copyWith(
                                  color: c.onHero,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                l10n.brandTag,
                                style: context.micro.copyWith(
                                  color: c.heroMuted,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _PlaceholderBody(
              title: l10n.titleSignIn,
              path: AppRoutes.signIn,
              icon: Icons.login_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderBody extends StatelessWidget {
  const new({required this.title, required this.path, required this.icon});

  final String title;
  final String path;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyState(
      icon: icon,
      title: title,
      message: l10n.placeholderBody,
      action: LtrText(
        path,
        textAlign: TextAlign.center,
        style: context.mono.copyWith(color: context.colors.muted),
      ),
    );
  }
}
