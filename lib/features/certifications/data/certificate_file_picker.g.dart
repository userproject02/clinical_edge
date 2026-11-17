// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_file_picker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The file picker (overridden in `mock_overrides.dart`).

@ProviderFor(certificateFilePicker)
final certificateFilePickerProvider = CertificateFilePickerProvider._();

/// The file picker (overridden in `mock_overrides.dart`).

final class CertificateFilePickerProvider
    extends
        $FunctionalProvider<
          CertificateFilePicker,
          CertificateFilePicker,
          CertificateFilePicker
        >
    with $Provider<CertificateFilePicker> {
  /// The file picker (overridden in `mock_overrides.dart`).
  CertificateFilePickerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'certificateFilePickerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$certificateFilePickerHash();

  @$internal
  @override
  $ProviderElement<CertificateFilePicker> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CertificateFilePicker create(Ref ref) {
    return certificateFilePicker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CertificateFilePicker value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CertificateFilePicker>(value),
    );
  }
}

String _$certificateFilePickerHash() =>
    r'2be530c466f0bbbf6168bc888be96952c4043333';
