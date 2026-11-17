import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_theme.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

double _contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final hi = la > lb ? la : lb;
  final lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

void main() {
  test('TC-PH1-07 tokens match the prototype exactly', () {
    const l = AppColors.light;
    const d = AppColors.dark;
    expect(l.background, const Color(0xFFF3F6F7));
    expect(l.brand, const Color(0xFF0A6E73));
    expect(l.inverse, const Color(0xFF1B2A2E));
    expect(d.background, const Color(0xFF0A1316));
    expect(d.brand, const Color(0xFF45BDB9));
    expect(d.onBrand, const Color(0xFF04201F));
    expect(d.blueSoft, const Color(0xFF1B2547));
    for (final c in <AppColors>[l, d]) {
      expect(c.hero, const Color(0xFF07393C));
      expect(c.onHero, const Color(0xFFE8F4F4));
      expect(c.heroMuted, const Color(0xFFA9D6D4));
      expect(c.courseBls, const Color(0xFF0A6E73));
      expect(c.courseIpc, const Color(0xFF2F4FB0));
      expect(c.courseMedication, const Color(0xFF9A4A0B));
    }
  });

  test('TC-PH1-08 ColorScheme and extension come from the tokens', () {
    final light = AppTheme.light();
    final dark = AppTheme.dark();
    expect(light.useMaterial3, isTrue);
    expect(light.colorScheme.primary, AppColors.light.brand);
    expect(light.colorScheme.surface, AppColors.light.surface);
    expect(light.scaffoldBackgroundColor, AppColors.light.background);
    expect(dark.colorScheme.primary, AppColors.dark.brand);
    expect(dark.colorScheme.inverseSurface, AppColors.dark.inverse);
    expect(light.extension<AppColors>(), AppColors.light);
    expect(dark.extension<AppColors>(), AppColors.dark);
  });

  test('TC-PH1-09 type scale, fonts per script and Latin-only tracking', () {
    final en = AppTheme.light().textTheme;
    final ar = AppTheme.light(arabic: true).textTheme;
    expect(en.titleLarge!.fontSize, 22);
    expect(en.titleLarge!.fontWeight, FontWeight.w700);
    expect(en.titleLarge!.letterSpacing, closeTo(-0.44, 1e-9));
    expect(en.titleMedium!.fontSize, 16);
    expect(en.bodyMedium!.fontSize, 14);
    expect(en.bodySmall!.fontSize, 12);
    expect(en.labelSmall!.fontSize, 11);
    expect(en.labelSmall!.fontWeight, FontWeight.w600);
    expect(en.bodyMedium!.fontFamily, AppFonts.inter);
    expect(ar.bodyMedium!.fontFamily, AppFonts.plexArabic);
    expect(ar.titleLarge!.letterSpacing, 0);
    expect(AppTypography.mono(en.bodySmall!).fontFamily, AppFonts.mono);
  });

  test('TC-PH1-34 text tokens meet 4.5:1 contrast on their backgrounds', () {
    for (final c in <AppColors>[AppColors.light, AppColors.dark]) {
      final pairs = <(Color, Color)>[
        (c.text, c.background),
        (c.text, c.surface),
        (c.muted, c.background),
        (c.muted, c.surface),
        (c.onBrand, c.brand),
        (c.brand, c.brandSoft),
        (c.warn, c.warnSoft),
        (c.ok, c.okSoft),
        (c.bad, c.badSoft),
        (c.blue, c.blueSoft),
        (c.onInverse, c.inverse),
        (c.onHero, c.hero),
        (c.heroMuted, c.hero),
      ];
      for (final (fg, bg) in pairs) {
        expect(
          _contrast(fg, bg),
          greaterThanOrEqualTo(4.5),
          reason: '$fg on $bg',
        );
      }
    }
  });
}
