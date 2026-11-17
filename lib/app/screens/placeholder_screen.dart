import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

/// Picks a localized screen title.
typedef TitleOf = String Function(AppLocalizations l10n);

/// Placeholder for a tab screen (until its feature phase): real tab app
/// bar + title + route. Role homes show the first-load skeleton.
class TabPlaceholder extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isHome = Role.values.any((r) => AppRoutes.homeFor(r) == path);
    final body = _PlaceholderBody(title: title(l10n), path: path, icon: icon);
    return TabScaffold(
      title: title(l10n),
      isHome: isHome,
      body: isHome ? FirstLoadSkeleton(child: body) : body,
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
