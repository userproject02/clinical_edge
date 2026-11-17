/// Card form rules (PAY-1). The form validates locally; raw values are
/// never stored, logged or sent anywhere (only a mock token is).
abstract final class CardRules {
  /// Digits only.
  static String digits(String s) => s.replaceAll(RegExp(r'\D'), '');

  /// Luhn checksum over the digits of [number] (13–19 digits).
  static bool luhn(String number) {
    final d = digits(number);
    if (d.length < 13 || d.length > 19) return false;
    var sum = 0;
    for (var i = 0; i < d.length; i++) {
      var n = d.codeUnitAt(d.length - 1 - i) - 48;
      if (i.isOdd) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
    }
    return sum % 10 == 0;
  }

  /// Groups digits in 4s: "4242424242424242" → "4242 4242 4242 4242".
  static String group(String number) {
    final d = digits(number);
    final b = StringBuffer();
    for (var i = 0; i < d.length; i++) {
      if (i > 0 && i % 4 == 0) b.write(' ');
      b.write(d[i]);
    }
    return b.toString();
  }

  /// Parses "MM / YY" (or "MM/YY"); null when malformed.
  static ({int month, int year})? parseExpiry(String s) {
    final d = digits(s);
    if (d.length != 4) return null;
    final month = int.parse(d.substring(0, 2));
    if (month < 1 || month > 12) return null;
    return (month: month, year: 2000 + int.parse(d.substring(2)));
  }

  /// Whether [expiry] is a valid month not before [today]'s month.
  static bool expiryValid(String expiry, DateTime today) {
    final e = parseExpiry(expiry);
    if (e == null) return false;
    return e.year > today.year ||
        (e.year == today.year && e.month >= today.month);
  }

  /// CVC: 3 or 4 digits.
  static bool cvcValid(String cvc) => RegExp(r'^\d{3,4}$').hasMatch(cvc);

  /// Last 4 digits (for the receipt).
  static String last4(String number) {
    final d = digits(number);
    return d.length <= 4 ? d : d.substring(d.length - 4);
  }
}

/// Why a card form is invalid.
enum CardError {
  /// Number fails the length or Luhn check.
  number,

  /// Expiry malformed or in the past.
  expiry,

  /// CVC not 3–4 digits.
  cvc,
}

/// Validates the three card fields.
Set<CardError> validateCard({
  required String number,
  required String expiry,
  required String cvc,
  required DateTime today,
}) => <CardError>{
  if (!CardRules.luhn(number)) CardError.number,
  if (!CardRules.expiryValid(expiry, today)) CardError.expiry,
  if (!CardRules.cvcValid(cvc)) CardError.cvc,
};
