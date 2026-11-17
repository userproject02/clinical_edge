import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/features/certifications/data/certification_repository.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:uuid/uuid.dart';

/// Why an upload form is invalid.
enum UploadError {
  /// Certificate name is empty.
  nameRequired,

  /// No expiry date chosen.
  expiryRequired,

  /// Expiry is not after the issue date.
  expiryBeforeIssue,
}

/// CERT-3: stores an uploaded certificate as "verifying" and writes
/// `cert.upload` (audit). Only a fake file reference is kept: never the
/// file contents or the device path.
class UploadCertificate {
  /// Creates the use case.
  const new({required this.repository, required this.logger, Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  /// Certificate store.
  final CertificationRepository repository;

  /// Activity logger.
  final ActivityLogger logger;

  final Uuid _uuid;

  /// Form errors (empty when valid).
  static Set<UploadError> validate({
    required String name,
    required DateTime? issuedOn,
    required DateTime? expiresOn,
  }) => <UploadError>{
    if (name.trim().isEmpty) UploadError.nameRequired,
    if (expiresOn == null) UploadError.expiryRequired,
    if (expiresOn != null && issuedOn != null && !expiresOn.isAfter(issuedOn))
      UploadError.expiryBeforeIssue,
  };

  /// Validates and uploads. Throws [ArgumentError] when invalid.
  Future<Certification> call({
    required String userId,
    required String name,
    required LocalizedText issuer,
    required DateTime issuedOn,
    required DateTime? expiresOn,
  }) async {
    final errors = validate(
      name: name,
      issuedOn: issuedOn,
      expiresOn: expiresOn,
    );
    if (errors.isNotEmpty) throw ArgumentError.value(errors, 'form');
    final title = name.trim();
    final cert = await repository.upload(
      userId: userId,
      name: LocalizedText(en: title, ar: title),
      issuer: issuer,
      issuedOn: issuedOn,
      expiresOn: expiresOn!,
      fileRef: 'demo-upload-${_uuid.v4()}',
    );
    await logger.audit(
      AuditAction.certUpload,
      target: '$title · pending verification',
    );
    return cert;
  }
}

/// Short label for a certificate name: the text in trailing parentheses
/// ("Neonatal Resuscitation Program (NRP)" → "NRP"), else the name.
String shortCertName(String name) =>
    RegExp(r'\(([^)]+)\)\s*$').firstMatch(name.trim())?.group(1) ?? name.trim();
