import 'package:material_ui/material_ui.dart';

/// Font families bundled in `assets/fonts` (declared in pubspec.yaml).
abstract final class AppFonts {
  /// Latin UI font.
  static const String inter = 'Inter';

  /// Arabic UI font.
  static const String plexArabic = 'IBMPlexSansArabic';

  /// Monospace for codes, invoice numbers and hashes.
  static const String mono = 'JetBrainsMono';
}

/// Type scale from the prototype.
///
/// | Role          | Size/weight | TextTheme slot  |
/// | ------------- | ----------- | --------------- |
/// | screen title  | 22/700      | titleLarge      |
/// | section title | 16/700      | titleMedium     |
/// | card title    | 15/700      | titleSmall      |
/// | button        | 15/700      | labelLarge      |
/// | body          | 14/400      | bodyMedium      |
/// | body large    | 15/400      | bodyLarge       |
/// | caption       | 12/400      | bodySmall       |
/// | label         | 12/600      | labelMedium     |
/// | micro         | 11/600      | labelSmall      |
///
/// Titles get -0.02em letter-spacing in Latin only: negative tracking breaks
/// the joins of Arabic script, so Arabic titles keep 0.
abstract final class AppTypography {
  /// Builds the [TextTheme] for a script. [arabic] picks IBM Plex Sans Arabic
  /// with Inter as fallback (and vice versa), so mixed text renders well.
  static TextTheme textTheme({required bool arabic, required Color color}) {
    final family = arabic ? AppFonts.plexArabic : AppFonts.inter;
    final fallback = <String>[
      if (arabic) AppFonts.inter else AppFonts.plexArabic,
    ];

    TextStyle style(
      double size,
      FontWeight weight, {
      double height = 1.35,
      bool title = false,
    }) {
      return TextStyle(
        fontFamily: family,
        fontFamilyFallback: fallback,
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color,
        letterSpacing: title && !arabic ? -0.02 * size : 0,
      );
    }

    return TextTheme(
      displaySmall: style(30, FontWeight.w700, height: 1.12, title: true),
      headlineSmall: style(24, FontWeight.w700, height: 1.2, title: true),
      titleLarge: style(22, FontWeight.w700, height: 1.25, title: true),
      titleMedium: style(16, FontWeight.w700, height: 1.3, title: true),
      titleSmall: style(15, FontWeight.w700, height: 1.3, title: true),
      bodyLarge: style(15, FontWeight.w400, height: 1.45),
      bodyMedium: style(14, FontWeight.w400, height: 1.45),
      bodySmall: style(12, FontWeight.w400, height: 1.4),
      labelLarge: style(15, FontWeight.w700, height: 1.2),
      labelMedium: style(12, FontWeight.w600, height: 1.3),
      labelSmall: style(11, FontWeight.w600, height: 1.3),
    );
  }

  /// JetBrains Mono variant of [base], for codes and hashes.
  static TextStyle mono(TextStyle base) => base.copyWith(
    fontFamily: AppFonts.mono,
    fontFamilyFallback: const <String>[AppFonts.inter],
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
}

/// Named text styles matching the design vocabulary.
extension AppTextStyles on BuildContext {
  TextTheme get _t => Theme.of(this).textTheme;

  /// 22/700 screen title.
  TextStyle get screenTitle => _t.titleLarge!;

  /// 16/700 section title.
  TextStyle get sectionTitle => _t.titleMedium!;

  /// 15/700 card title.
  TextStyle get cardTitle => _t.titleSmall!;

  /// 14/400 body.
  TextStyle get body => _t.bodyMedium!;

  /// 12/400 caption.
  TextStyle get caption => _t.bodySmall!;

  /// 11/600 micro label.
  TextStyle get micro => _t.labelSmall!;

  /// 12/500 monospace (codes, hashes).
  TextStyle get mono => AppTypography.mono(_t.bodySmall!);
}
