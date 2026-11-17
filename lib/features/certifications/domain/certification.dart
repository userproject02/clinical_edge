import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/json_converters.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'certification.freezed.dart';
part 'certification.g.dart';

/// Whether an uploaded certificate has been checked.
enum Verification {
  /// Checked.
  verified,

  /// Uploaded, waiting for verification.
  pending,
}

/// Displayed certificate status.
enum CertStatus {
  /// More than 90 days left.
  valid,

  /// 1–90 days left.
  renewSoon,

  /// 0 days or fewer left.
  expired,

  /// Uploaded and not yet verified.
  verifying,
}

/// Status rule (CERT-1): uploaded → verifying; days ≤ 0 → expired;
/// days ≤ 90 → renew soon; else valid.
abstract final class CertRules {
  /// Renew-soon threshold in days.
  static const int renewSoonDays = 90;

  /// Expiry reminder offsets (CERT-4).
  static const List<int> reminderDays = <int>[90, 60, 30, 7];

  /// Status for [daysLeft] and [verification].
  static CertStatus status({
    required int daysLeft,
    required Verification verification,
  }) {
    if (verification == Verification.pending) return CertStatus.verifying;
    if (daysLeft <= 0) return CertStatus.expired;
    if (daysLeft <= renewSoonDays) return CertStatus.renewSoon;
    return CertStatus.valid;
  }
}

/// A professional certification.
@freezed
abstract class Certification with _$Certification {
  /// Creates a certification.
  const factory({
    required String id,
    required String userId,
    required LocalizedText name,
    required LocalizedText issuer,
    @DateOnlyConverter() required DateTime issuedOn,
    @DateOnlyConverter() required DateTime expiresOn,
    required Verification verification,
    String? fileRef,

    /// Short code shown in alerts ("BLS").
    String? code,
  }) = _Certification;

  const new _();

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CertificationFromJson(json);

  /// Days from today (per [clock], Asia/Dubai) to expiry.
  int daysLeft(Clock clock) => daysBetween(clock.today(), expiresOn);

  /// Status today.
  CertStatus status(Clock clock) =>
      CertRules.status(daysLeft: daysLeft(clock), verification: verification);

  /// Dates of the 90/60/30/7-day reminders.
  List<DateTime> reminderDates() => <DateTime>[
    for (final d in CertRules.reminderDays)
      expiresOn.subtract(Duration(days: d)),
  ];
}

/// Where CPD credits came from.
enum CpdSource {
  /// Outside ClinicalEdge.
  external,

  /// A ClinicalEdge course.
  clinicaledge,
}

/// One CPD ledger line.
@freezed
abstract class CpdEntry with _$CpdEntry {
  /// Creates an entry.
  const factory({
    required String id,
    required String userId,
    @DateOnlyConverter() required DateTime date,
    required LocalizedText activity,
    required CpdSource source,
    required int credits,
  }) = _CpdEntry;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CpdEntryFromJson(json);
}

/// CPD cycle configuration (target is config, not hard-coded in UI).
@freezed
abstract class CpdConfig with _$CpdConfig {
  /// Creates the config.
  const factory({
    required String cycle,
    required int target,
    required bool targetIsDemo,
    required LocalizedText targetNote,
  }) = _CpdConfig;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$CpdConfigFromJson(json);
}
