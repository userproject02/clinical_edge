import 'package:material_ui/material_ui.dart';

/// Design tokens of the ClinicalEdge prototype, exposed as a [ThemeExtension].
///
/// Widgets read colours with `context.colors` (see [AppColorsContext]) and
/// never hard-code hex values. The light and dark sets match the prototype
/// canvas exactly; hero and course-cover colours are identical in both themes.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  /// Creates a full token set.
  const new({
    required this.background,
    required this.surface,
    required this.surface2,
    required this.outline,
    required this.text,
    required this.muted,
    required this.brand,
    required this.onBrand,
    required this.brandSoft,
    required this.warn,
    required this.warnSoft,
    required this.ok,
    required this.okSoft,
    required this.bad,
    required this.badSoft,
    required this.blue,
    required this.blueSoft,
    required this.inverse,
    required this.onInverse,
    required this.hero,
    required this.onHero,
    required this.heroMuted,
    required this.heroAccent,
    required this.alertDot,
    required this.scrim,
    required this.courseBls,
    required this.courseIpc,
    required this.courseMedication,
  });

  /// Light theme tokens.
  static const AppColors light = AppColors(
    background: Color(0xFFF3F6F7),
    surface: Color(0xFFFFFFFF),
    surface2: Color(0xFFEAF0F1),
    outline: Color(0xFFD9E2E4),
    text: Color(0xFF0F1E24),
    muted: Color(0xFF4F636A),
    brand: Color(0xFF0A6E73),
    onBrand: Color(0xFFFFFFFF),
    brandSoft: Color(0xFFDFF0F0),
    warn: Color(0xFFA64B05),
    warnSoft: Color(0xFFFDEFE1),
    ok: Color(0xFF1C7347),
    okSoft: Color(0xFFE2F3E9),
    bad: Color(0xFFB42318),
    badSoft: Color(0xFFFCE9E7),
    blue: Color(0xFF2F4FB0),
    blueSoft: Color(0xFFE6EBFA),
    inverse: Color(0xFF1B2A2E),
    onInverse: Color(0xFFE8F4F4),
    hero: _hero,
    onHero: _onHero,
    heroMuted: _heroMuted,
    heroAccent: _heroAccent,
    alertDot: _alertDot,
    scrim: _scrim,
    courseBls: _courseBls,
    courseIpc: _courseIpc,
    courseMedication: _courseMedication,
  );

  /// Dark theme tokens.
  static const AppColors dark = AppColors(
    background: Color(0xFF0A1316),
    surface: Color(0xFF111D21),
    surface2: Color(0xFF182B2F),
    outline: Color(0xFF25393E),
    text: Color(0xFFE5EEF0),
    muted: Color(0xFF9DB2B8),
    brand: Color(0xFF45BDB9),
    onBrand: Color(0xFF04201F),
    brandSoft: Color(0xFF123438),
    warn: Color(0xFFF2A866),
    warnSoft: Color(0xFF3A2615),
    ok: Color(0xFF62CC93),
    okSoft: Color(0xFF11301F),
    bad: Color(0xFFF4837A),
    badSoft: Color(0xFF3B1816),
    blue: Color(0xFF93A8FF),
    blueSoft: Color(0xFF1B2547),
    inverse: Color(0xFFE5EEF0),
    onInverse: Color(0xFF0F1E24),
    hero: _hero,
    onHero: _onHero,
    heroMuted: _heroMuted,
    heroAccent: _heroAccent,
    alertDot: _alertDot,
    scrim: _scrim,
    courseBls: _courseBls,
    courseIpc: _courseIpc,
    courseMedication: _courseMedication,
  );

  static const Color _hero = Color(0xFF07393C);
  static const Color _onHero = Color(0xFFE8F4F4);
  static const Color _heroMuted = Color(0xFFA9D6D4);
  static const Color _heroAccent = Color(0xFF5FD0CB);
  static const Color _alertDot = Color(0xFFD66E14);
  static const Color _scrim = Color(0x80051214);
  static const Color _courseBls = Color(0xFF0A6E73);
  static const Color _courseIpc = Color(0xFF2F4FB0);
  static const Color _courseMedication = Color(0xFF9A4A0B);

  /// Screen background.
  final Color background;

  /// Cards, sheets, bottom bar.
  final Color surface;

  /// Secondary surface: tracks, skeletons, neutral tags.
  final Color surface2;

  /// Hairlines and borders.
  final Color outline;

  /// Primary text.
  final Color text;

  /// Secondary text.
  final Color muted;

  /// Brand teal.
  final Color brand;

  /// Content on [brand].
  final Color onBrand;

  /// Tinted brand background (selected chips, nav pill).
  final Color brandSoft;

  /// Warning (renew soon, pending).
  final Color warn;

  /// Warning background.
  final Color warnSoft;

  /// Success (valid, approved, passed).
  final Color ok;

  /// Success background.
  final Color okSoft;

  /// Error (rejected, failed, expired).
  final Color bad;

  /// Error background.
  final Color badSoft;

  /// Informational blue (verifying, admin).
  final Color blue;

  /// Informational background.
  final Color blueSoft;

  /// Inverse surface (snackbars).
  final Color inverse;

  /// Content on [inverse].
  final Color onInverse;

  /// Deep-teal hero panel background (same in both themes).
  final Color hero;

  /// Primary text on [hero].
  final Color onHero;

  /// Secondary text on [hero].
  final Color heroMuted;

  /// Accent strokes on [hero] (ECG line, rings).
  final Color heroAccent;

  /// Pulsing notification dot on the bell.
  final Color alertDot;

  /// Modal scrim behind sheets.
  final Color scrim;

  /// Course cover: Basic Life Support.
  final Color courseBls;

  /// Course cover: Infection Prevention & Control.
  final Color courseIpc;

  /// Course cover: Medication Safety.
  final Color courseMedication;

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surface2,
    Color? outline,
    Color? text,
    Color? muted,
    Color? brand,
    Color? onBrand,
    Color? brandSoft,
    Color? warn,
    Color? warnSoft,
    Color? ok,
    Color? okSoft,
    Color? bad,
    Color? badSoft,
    Color? blue,
    Color? blueSoft,
    Color? inverse,
    Color? onInverse,
    Color? hero,
    Color? onHero,
    Color? heroMuted,
    Color? heroAccent,
    Color? alertDot,
    Color? scrim,
    Color? courseBls,
    Color? courseIpc,
    Color? courseMedication,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      outline: outline ?? this.outline,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      brand: brand ?? this.brand,
      onBrand: onBrand ?? this.onBrand,
      brandSoft: brandSoft ?? this.brandSoft,
      warn: warn ?? this.warn,
      warnSoft: warnSoft ?? this.warnSoft,
      ok: ok ?? this.ok,
      okSoft: okSoft ?? this.okSoft,
      bad: bad ?? this.bad,
      badSoft: badSoft ?? this.badSoft,
      blue: blue ?? this.blue,
      blueSoft: blueSoft ?? this.blueSoft,
      inverse: inverse ?? this.inverse,
      onInverse: onInverse ?? this.onInverse,
      hero: hero ?? this.hero,
      onHero: onHero ?? this.onHero,
      heroMuted: heroMuted ?? this.heroMuted,
      heroAccent: heroAccent ?? this.heroAccent,
      alertDot: alertDot ?? this.alertDot,
      scrim: scrim ?? this.scrim,
      courseBls: courseBls ?? this.courseBls,
      courseIpc: courseIpc ?? this.courseIpc,
      courseMedication: courseMedication ?? this.courseMedication,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      background: l(background, other.background),
      surface: l(surface, other.surface),
      surface2: l(surface2, other.surface2),
      outline: l(outline, other.outline),
      text: l(text, other.text),
      muted: l(muted, other.muted),
      brand: l(brand, other.brand),
      onBrand: l(onBrand, other.onBrand),
      brandSoft: l(brandSoft, other.brandSoft),
      warn: l(warn, other.warn),
      warnSoft: l(warnSoft, other.warnSoft),
      ok: l(ok, other.ok),
      okSoft: l(okSoft, other.okSoft),
      bad: l(bad, other.bad),
      badSoft: l(badSoft, other.badSoft),
      blue: l(blue, other.blue),
      blueSoft: l(blueSoft, other.blueSoft),
      inverse: l(inverse, other.inverse),
      onInverse: l(onInverse, other.onInverse),
      hero: l(hero, other.hero),
      onHero: l(onHero, other.onHero),
      heroMuted: l(heroMuted, other.heroMuted),
      heroAccent: l(heroAccent, other.heroAccent),
      alertDot: l(alertDot, other.alertDot),
      scrim: l(scrim, other.scrim),
      courseBls: l(courseBls, other.courseBls),
      courseIpc: l(courseIpc, other.courseIpc),
      courseMedication: l(courseMedication, other.courseMedication),
    );
  }
}

/// Shape and spacing tokens (4-pt grid).
abstract final class AppSpacing {
  /// 4 dp.
  static const double xs = 4;

  /// 8 dp.
  static const double sm = 8;

  /// 12 dp: default gap between cards.
  static const double gap = 12;

  /// 16 dp: screen padding.
  static const double screen = 16;

  /// 16 dp: card padding (range 14–18).
  static const double card = 16;
}

/// Corner radii from the prototype.
abstract final class AppRadii {
  /// Chips and tags (8–10).
  static const double tag = 8;

  /// Filter chips.
  static const double chip = 10;

  /// Text fields and snackbars.
  static const double field = 12;

  /// Cards (16–20).
  static const double card = 16;

  /// Large cards.
  static const double cardLarge = 20;

  /// Notification banner.
  static const double banner = 22;

  /// Hero panels.
  static const double hero = 24;

  /// Bottom sheet top corners.
  static const double sheet = 28;

  /// Fully rounded (stadium).
  static const double pill = 999;
}

/// Shorthand access to [AppColors] from a [BuildContext].
extension AppColorsContext on BuildContext {
  /// The active [AppColors] (falls back to light tokens if not installed).
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;
}

/// Fixed colours that do not change with the theme (shadows, transparent
/// fills, the system-styled Apple Pay sheet). Widgets use these names
/// instead of `Color(0x…)` literals.
abstract final class FixedColors {
  /// Fully transparent.
  static const Color transparent = Color(0x00000000);

  /// Soft card shadow (lesson player panels).
  static const Color shadowSoft = Color(0x22000000);

  /// Sign-in hero shadow.
  static const Color shadowHero = Color(0x59000000);

  /// Notification banner shadow.
  static const Color shadowBanner = Color(0x73000000);

  /// Snackbar shadow.
  static const Color shadowSnackbar = Color(0x80000000);

  /// Apple Pay sheet background (system style, same in both themes).
  static const Color applePaySheet = Color(0xFF000000);

  /// Text and glyphs on the Apple Pay sheet.
  static const Color onApplePaySheet = Color(0xFFFFFFFF);
}
