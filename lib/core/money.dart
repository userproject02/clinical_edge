import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:flutter/foundation.dart' show immutable;

/// UAE VAT rate, in percent.
const int vatPercent = 5;

/// An amount of UAE dirham stored as integer fils (1 AED = 100 fils).
///
/// Never use `double` for money (AGENTS.md). VAT is
/// `round(subtotal × 5 / 100)`, rounding half away from zero.
@immutable
class Money implements Comparable<Money> {
  /// Creates an amount from fils.
  const new(this.fils);

  /// Creates an amount from whole dirham.
  const new aed(int dirham) : fils = dirham * 100;

  /// Zero.
  static const Money zero = Money(0);

  /// Amount in fils.
  final int fils;

  /// Sum.
  Money operator +(Money other) => Money(fils + other.fils);

  /// Difference.
  Money operator -(Money other) => Money(fils - other.fils);

  /// 5 % VAT on this subtotal, rounded to the nearest fils (half up).
  Money get vat => vatOf(this);

  /// Subtotal plus VAT.
  Money get withVat => this + vat;

  /// Localized display: "AED 315.00" / "315.00 د.إ", LTR-isolated.
  String format(AppLocalizations l10n) => Formats.aed(fils, l10n);

  @override
  int compareTo(Money other) => fils.compareTo(other.fils);

  @override
  bool operator ==(Object other) => other is Money && other.fils == fils;

  @override
  int get hashCode => fils.hashCode;

  @override
  String toString() => 'Money($fils fils)';
}

/// VAT of [subtotal]: round(subtotal × 5 / 100), integer maths only.
Money vatOf(Money subtotal) {
  final scaled = subtotal.fils * vatPercent;
  final sign = scaled < 0 ? -1 : 1;
  return Money(sign * ((scaled.abs() + 50) ~/ 100));
}

/// Subtotal, VAT and total for one purchase.
@immutable
class PriceBreakdown {
  /// Computes the breakdown of [subtotal].
  new(this.subtotal) : vat = vatOf(subtotal);

  /// Price before VAT.
  final Money subtotal;

  /// 5 % VAT.
  final Money vat;

  /// Subtotal + VAT.
  Money get total => subtotal + vat;
}
