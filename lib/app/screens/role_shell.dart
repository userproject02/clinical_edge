import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/bottom_nav_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Scaffold of a role's tab shell: the indexed stack of tab navigators with
/// the fade-up tab transition, and the bottom bar.
class RoleShell extends StatelessWidget {
  /// Creates the shell.
  const new({required this.navigationShell, required this.items, super.key});

  /// go_router's shell (holds one navigator per tab).
  final StatefulNavigationShell navigationShell;

  /// Bottom-bar destinations, one per branch.
  final List<NavItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabSwitchTransition(
        switchKey: navigationShell.currentIndex,
        child: navigationShell,
      ),
      bottomNavigationBar: BottomNavBar(
        items: items,
        selectedIndex: navigationShell.currentIndex,
        onSelected: (i) => navigationShell.goBranch(
          i,
          // Tapping the active tab again returns to its root.
          initialLocation: i == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
