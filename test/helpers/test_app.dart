import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// One rendering variant: theme × text direction.
enum Variant {
  /// Light, English (LTR).
  lightLtr('light_ltr', Brightness.light, Locale('en')),

  /// Dark, English (LTR).
  darkLtr('dark_ltr', Brightness.dark, Locale('en')),

  /// Light, Arabic (RTL).
  lightRtl('light_rtl', Brightness.light, Locale('ar')),

  /// Dark, Arabic (RTL).
  darkRtl('dark_rtl', Brightness.dark, Locale('ar'));

  new(this.id, this.brightness, this.locale);

  /// File-name suffix.
  final String id;

  /// Theme brightness.
  final Brightness brightness;

  /// Locale (Arabic → RTL).
  final Locale locale;
}

/// Wraps [child] in a themed, localized app like the real one.
Widget testApp(
  Widget child, {
  Variant variant = Variant.lightLtr,
  bool disableAnimations = false,
  double textScale = 1,
}) {
  final arabic = variant.locale.languageCode == 'ar';
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: variant.brightness == Brightness.light
        ? AppTheme.light(arabic: arabic)
        : AppTheme.dark(arabic: arabic),
    locale: variant.locale,
    supportedLocales: supportedAppLocales,
    localizationsDelegates: appLocalizationsDelegates,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(
        disableAnimations: disableAnimations,
        textScaler: TextScaler.linear(textScale),
      ),
      child: child!,
    ),
    home: Scaffold(body: child),
  );
}

/// Pumps [child] inside [testApp].
Future<void> pumpTestApp(
  WidgetTester tester,
  Widget child, {
  Variant variant = Variant.lightLtr,
  bool disableAnimations = false,
  double textScale = 1,
  Size size = const Size(390, 844),
}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    testApp(
      child,
      variant: variant,
      disableAnimations: disableAnimations,
      textScale: textScale,
    ),
  );
}
