import 'dart:typed_data';
import 'dart:ui' show Rect;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'file_sharer.g.dart';

/// Opens the system share sheet with a generated file (CSV export, receipt
/// PDF).
abstract interface class FileSharer {
  /// Shares [bytes] as a file called [name].
  Future<void> shareFile({
    required Uint8List bytes,
    required String name,
    required String mimeType,
    Rect? origin,
  });
}

/// [FileSharer] on share_plus (writes a temporary file for the sheet).
class PluginFileSharer implements FileSharer {
  /// Creates the sharer.
  const new();

  @override
  Future<void> shareFile({
    required Uint8List bytes,
    required String name,
    required String mimeType,
    Rect? origin,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[XFile.fromData(bytes, name: name, mimeType: mimeType)],
        fileNameOverrides: <String>[name],
        sharePositionOrigin: origin,
      ),
    );
  }
}

/// Recording [FileSharer] for tests and previews.
class RecordingFileSharer implements FileSharer {
  /// Files shared so far.
  final List<({String name, String mimeType, Uint8List bytes})> shared = [];

  @override
  Future<void> shareFile({
    required Uint8List bytes,
    required String name,
    required String mimeType,
    Rect? origin,
  }) async {
    shared.add((name: name, mimeType: mimeType, bytes: bytes));
  }
}

/// The file sharer (overridden in `mock_overrides.dart`).
@Riverpod(keepAlive: true)
FileSharer fileSharer(Ref ref) =>
    throw UnimplementedError('Override fileSharerProvider.');
