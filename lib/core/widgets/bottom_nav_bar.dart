import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:material_ui/material_ui.dart';

/// One bottom-bar destination.
@immutable
class NavItem {
  /// Creates a destination.
  const new({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badge = 0,
  });

  /// Icon when not selected.
  final IconData icon;

  /// Icon when selected (defaults to [icon]).
  final IconData? selectedIcon;

  /// Label under the icon.
  final String label;

  /// Count shown in a red badge; hidden when 0.
  final int badge;
}

/// Material 3 [NavigationBar] styled like the prototype: surface background,
/// hairline top border, brand-soft pill indicator and an optional badge.
class BottomNavBar extends StatelessWidget {
  /// Creates the bar.
  const new({
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  /// Destinations (3–5).
  final List<NavItem> items;

  /// Selected destination.
  final int selectedIndex;

  /// Tap handler.
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.outline)),
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onSelected,
        animationDuration: const Duration(milliseconds: 250),
        destinations: <Widget>[
          for (final item in items)
            NavigationDestination(
              label: item.label,
              tooltip: '',
              icon: _icon(item.icon, item.badge, l10n),
              selectedIcon: _icon(
                item.selectedIcon ?? item.icon,
                item.badge,
                l10n,
              ),
            ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon, int badge, AppLocalizations l10n) {
    if (badge <= 0) return Icon(icon);
    return Semantics(
      label: l10n.navBadge(badge),
      child: Badge(label: Text(ltr('$badge')), child: Icon(icon)),
    );
  }
}
