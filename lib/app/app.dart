import 'package:clinical_edge/app/debug/debug_menu.dart';
import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/state/theme_mode.dart';
import 'package:clinical_edge/app/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Localization delegates: the app's strings plus Material, Cupertino and
/// Widgets (which also sets RTL for Arabic).
const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates =
    <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      ...GlobalMaterialLocalizations.delegates,
    ];

/// Root widget of ClinicalEdge: router, light/dark themes, EN/AR locale.
class ClinicalEdgeApp extends ConsumerWidget {
  /// Creates the app. [showDebugMenu] defaults to debug builds only.
  const new({this.showDebugMenu = kDebugMode, super.key});

  /// Shows the temporary developer menu button.
  final bool showDebugMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);
    final mode = ref.watch(themeModeProvider);
    final arabic = locale.languageCode == 'ar';

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(arabic: arabic),
      darkTheme: AppTheme.dark(arabic: arabic),
      themeMode: mode,
      themeAnimationDuration: const Duration(milliseconds: 250),
      locale: locale,
      supportedLocales: supportedAppLocales,
      localizationsDelegates: appLocalizationsDelegates,
      routerConfig: router,
      // The bridge passes theme + localizations to packages that still import
      // package:flutter/material.dart (fl_chart). Remove when they migrate.
      // ignore: deprecated_member_use
      builder: (context, child) => MaterialUiCompatibilityBridge(
        child: DebugMenuOverlay(
          enabled: showDebugMenu,
          router: router,
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
