/// Thrown when an event target looks like sensitive data.
class SensitiveTargetException implements Exception {
  /// Creates the exception with the rule that matched (never the value).
  const new(this.rule);

  /// Which rule rejected the target.
  final String rule;

  @override
  String toString() => 'SensitiveTargetException: target rejected ($rule)';
}

/// Guards what reaches the logs (AGENTS.md → Logging and privacy rules).
///
/// Rejects targets that look like a card number (13–19 digits, optionally
/// separated by spaces or dashes), a CVC, an email address or a password,
/// and caps the length at [maxLength] characters. Short labels such as
/// "BLS Refresher · AED 367.50 · CE-2026-001041" or "88%" pass.
abstract final class TargetSanitizer {
  /// Maximum target length.
  static const int maxLength = 120;

  static final RegExp _cardLike = RegExp(r'(?:\d[ -]?){12,18}\d');
  static final RegExp _cvc = RegExp(
    r'\b(cvc|cvv|cvn|csc|cvc2|cvv2|security\s*code)\b',
    caseSensitive: false,
  );
  static final RegExp _email = RegExp(
    r'[A-Z0-9._%+\-]+@[A-Z0-9.\-]+\.[A-Z]{2,}',
    caseSensitive: false,
  );
  static final RegExp _password = RegExp(
    r'\b(password|passwd|pwd|passcode|pin\s*code)\b',
    caseSensitive: false,
  );

  /// Returns [target] trimmed and capped, or throws
  /// [SensitiveTargetException].
  static String clean(String target) {
    final t = target.trim();
    if (_cardLike.hasMatch(t)) {
      throw const SensitiveTargetException('card number');
    }
    if (_cvc.hasMatch(t)) throw const SensitiveTargetException('cvc');
    if (_email.hasMatch(t)) throw const SensitiveTargetException('email');
    if (_password.hasMatch(t)) {
      throw const SensitiveTargetException('password');
    }
    if (t.runes.length <= maxLength) return t;
    return String.fromCharCodes(t.runes.take(maxLength));
  }
}
