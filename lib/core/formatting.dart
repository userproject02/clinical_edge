import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:material_ui/material_ui.dart';

/// Unicode LEFT-TO-RIGHT ISOLATE.
final String _lri = String.fromCharCode(0x2066);

/// Unicode POP DIRECTIONAL ISOLATE.
final String _pdi = String.fromCharCode(0x2069);

/// Wraps [value] in a left-to-right bidi isolate so numbers, percentages,
/// emails, card numbers and hashes keep their order inside Arabic text.
String ltr(String value) => '$_lri$value$_pdi';

/// Locale-aware formatting. Digits are always Western (0–9), as in the
/// prototype, and every returned value is LTR-isolated.
abstract final class Formats {
  static final NumberFormat _money = NumberFormat('#,##0.00', 'en');
  static final NumberFormat _int = NumberFormat('#,##0', 'en');

  /// AED amount from integer fils: "AED 315.00" (en) or "315.00 د.إ" (ar).
  static String aed(int fils, AppLocalizations l10n) {
    final whole = fils ~/ 100;
    final rest = (fils % 100).abs();
    final amount = _money.format(whole + rest / 100);
    return ltr(l10n.aedAmount(amount));
  }

  /// Whole percentage: "55%".
  static String percent(num value) => ltr('${value.round()}%');

  /// Grouped integer: "1,240".
  static String integer(int value) => ltr(_int.format(value));

  /// Medium date for the locale: "17 Nov 2026" / "17 نوفمبر 2026".
  static String date(DateTime date, Locale locale) {
    final tag = locale.toLanguageTag();
    final pattern = DateFormat('d MMM y', tag);
    return _westernDigits(pattern.format(date));
  }

  /// Date and time for the locale: "17 Nov 2026, 09:02".
  static String dateTime(DateTime date, Locale locale) {
    final tag = locale.toLanguageTag();
    final d = DateFormat('d MMM y', tag).format(date);
    final t = DateFormat('HH:mm', tag).format(date);
    return _westernDigits('$d, ${ltr(t)}');
  }

  static const String _arabicIndic = '٠١٢٣٤٥٦٧٨٩';

  static String _westernDigits(String s) {
    final buffer = StringBuffer();
    for (final rune in s.runes) {
      final ch = String.fromCharCode(rune);
      final i = _arabicIndic.indexOf(ch);
      buffer.write(i >= 0 ? '$i' : ch);
    }
    return buffer.toString();
  }
}

/// Text that always lays out left to right (codes, hashes, numbers), even
/// inside an RTL screen. Alignment still follows the surrounding direction.
class LtrText extends StatelessWidget {
  /// Creates LTR text.
  const new(
    this.data, {
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    super.key,
  });

  /// The text.
  final String data;

  /// Style override.
  final TextStyle? style;

  /// Max lines.
  final int? maxLines;

  /// Overflow behaviour.
  final TextOverflow? overflow;

  /// Alignment (defaults to the start of the surrounding direction).
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final outer = Directionality.of(context);
    final align =
        textAlign ??
        (outer == TextDirection.rtl ? TextAlign.right : TextAlign.left);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        data,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: align,
      ),
    );
  }
}
