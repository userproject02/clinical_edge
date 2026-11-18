import 'dart:io' show Platform;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'certificate_file_picker.g.dart';

/// A picked certificate file: name and size only. The app never reads or
/// stores file contents or device paths (AGENTS.md → Logging and privacy).
class PickedFile {
  /// Creates the value.
  const new({required this.name, required this.sizeBytes});

  /// File name ("NRP_certificate.pdf").
  final String name;

  /// Size in bytes.
  final int sizeBytes;
}

/// Picks a certificate file (CERT-3).
abstract interface class CertificateFilePicker {
  /// Lets the user pick a file; null when cancelled.
  Future<PickedFile?> pick();
}

/// The demo file used on simulators and in tests.
const PickedFile sampleCertificateFile = PickedFile(
  name: 'NRP_certificate.pdf',
  sizeBytes: 412 * 1024,
);

/// Mock picker: always returns [sampleCertificateFile].
class MockCertificateFilePicker implements CertificateFilePicker {
  /// Creates the picker.
  const new();

  @override
  Future<PickedFile?> pick() async => sampleCertificateFile;
}

/// `file_picker` on a device; on an iOS simulator (or if the picker fails)
/// falls back to [sampleCertificateFile].
class PlatformCertificateFilePicker implements CertificateFilePicker {
  /// Creates the picker.
  const new();

  static bool get _simulator =>
      !kIsWeb &&
      Platform.isIOS &&
      Platform.environment.containsKey('SIMULATOR_UDID');

  @override
  Future<PickedFile?> pick() async {
    if (_simulator) return sampleCertificateFile;
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const <String>['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (files.isEmpty) return null;
      final file = files.first;
      // Size from file metadata; contents are never read.
      return PickedFile(name: file.name, sizeBytes: await file.xFile.length());
    } on Object {
      return sampleCertificateFile;
    }
  }
}

/// The file picker (overridden in `mock_overrides.dart`).
@Riverpod(keepAlive: true)
CertificateFilePicker certificateFilePicker(Ref ref) =>
    throw UnimplementedError('Override certificateFilePickerProvider.');
