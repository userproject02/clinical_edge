import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:material_ui/material_ui.dart';

/// Builds the Material 3 [ThemeData] for ClinicalEdge.
///
/// The [ColorScheme] starts from the brand seed (#0A6E73) as a fallback and
/// then takes every role that has a design token, so Material components and
/// custom widgets agree. Status colours live in the [AppColors] extension.
abstract final class AppTheme {
  /// Brand seed colour.
  static const Color seed = Color(0xFF0A6E73);

  /// Light theme for a locale (Arabic switches the font family).
  static ThemeData light({bool arabic = false}) =>
      _build(Brightness.light, AppColors.light, arabic: arabic);

  /// Dark theme for a locale.
  static ThemeData dark({bool arabic = false}) =>
      _build(Brightness.dark, AppColors.dark, arabic: arabic);

  /// [ColorScheme] built from the tokens.
  static ColorScheme colorScheme(Brightness brightness, AppColors c) {
    return ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    ).copyWith(
      primary: c.brand,
      onPrimary: c.onBrand,
      primaryContainer: c.brandSoft,
      onPrimaryContainer: c.brand,
      secondary: c.blue,
      onSecondary: c.surface,
      secondaryContainer: c.blueSoft,
      onSecondaryContainer: c.blue,
      tertiary: c.warn,
      onTertiary: c.surface,
      tertiaryContainer: c.warnSoft,
      onTertiaryContainer: c.warn,
      error: c.bad,
      onError: c.surface,
      errorContainer: c.badSoft,
      onErrorContainer: c.bad,
      surface: c.surface,
      onSurface: c.text,
      onSurfaceVariant: c.muted,
      surfaceDim: c.background,
      surfaceBright: c.surface,
      surfaceContainerLowest: c.surface,
      surfaceContainerLow: c.surface,
      surfaceContainer: c.surface,
      surfaceContainerHigh: c.surface2,
      surfaceContainerHighest: c.surface2,
      outline: c.outline,
      outlineVariant: c.outline,
      inverseSurface: c.inverse,
      onInverseSurface: c.onInverse,
      scrim: c.scrim,
      shadow: const Color(0xFF000000),
    );
  }

  static ThemeData _build(
    Brightness brightness,
    AppColors c, {
    required bool arabic,
  }) {
    final scheme = colorScheme(brightness, c);
    final text = AppTypography.textTheme(arabic: arabic, color: c.text);
    const stadium = StadiumBorder();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.background,
      textTheme: text,
      fontFamily: arabic ? AppFonts.plexArabic : AppFonts.inter,
      extensions: <ThemeExtension<dynamic>>[c],
      splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
      dividerTheme: DividerThemeData(color: c.outline, thickness: 1, space: 1),
      iconTheme: IconThemeData(color: c.text, size: 22),
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        foregroundColor: c.text,
        surfaceTintColor: const Color(0x00000000),
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: text.titleMedium,
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        surfaceTintColor: const Color(0x00000000),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 52),
          shape: stadium,
          backgroundColor: c.brand,
          foregroundColor: c.onBrand,
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 52),
          shape: stadium,
          foregroundColor: c.brand,
          side: BorderSide(color: c.outline, width: 1.5),
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          foregroundColor: c.brand,
          shape: stadium,
          textStyle: text.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: 14,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.field),
          borderSide: BorderSide(color: c.outline, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.field),
          borderSide: BorderSide(color: c.outline, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.field),
          borderSide: BorderSide(color: c.brand, width: 2),
        ),
        labelStyle: text.labelMedium?.copyWith(color: c.muted),
        hintStyle: text.bodyMedium?.copyWith(color: c.muted),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: const Color(0x00000000),
        elevation: 0,
        height: 72,
        indicatorColor: c.brandSoft,
        indicatorShape: stadium,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 22,
            color: states.contains(WidgetState.selected) ? c.brand : c.muted,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => text.labelSmall!.copyWith(
            color: states.contains(WidgetState.selected) ? c.text : c.muted,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: c.bad,
        textColor: const Color(0xFFFFFFFF),
        textStyle: text.labelSmall?.copyWith(fontSize: 10),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: const Color(0x00000000),
        modalBackgroundColor: c.surface,
        modalBarrierColor: c.scrim,
        elevation: 0,
        modalElevation: 0,
        showDragHandle: false,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.sheet),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: c.inverse,
        contentTextStyle: text.bodySmall?.copyWith(color: c.onInverse),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.field),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.brand,
        linearTrackColor: c.surface2,
        circularTrackColor: c.surface2,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.surface,
        selectedColor: c.brandSoft,
        side: BorderSide(color: c.outline),
        labelStyle: text.labelMedium?.copyWith(color: c.text),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.chip),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: AppPageTransitionsBuilder(),
          TargetPlatform.iOS: AppPageTransitionsBuilder(),
        },
      ),
    );
  }
}
