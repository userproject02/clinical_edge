// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cert_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Expiry reminder rules on the app clock.

@ProviderFor(reminderService)
final reminderServiceProvider = ReminderServiceProvider._();

/// Expiry reminder rules on the app clock.

final class ReminderServiceProvider
    extends
        $FunctionalProvider<ReminderService, ReminderService, ReminderService>
    with $Provider<ReminderService> {
  /// Expiry reminder rules on the app clock.
  ReminderServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderServiceHash();

  @$internal
  @override
  $ProviderElement<ReminderService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReminderService create(Ref ref) {
    return reminderService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderService>(value),
    );
  }
}

String _$reminderServiceHash() => r'8f4faad8d7f2bc517cac4ac0aa0b4754a760ba56';

/// The certificate to warn about now (Home expiry alert, bell), or null.

@ProviderFor(dueCertificate)
final dueCertificateProvider = DueCertificateProvider._();

/// The certificate to warn about now (Home expiry alert, bell), or null.

final class DueCertificateProvider
    extends
        $FunctionalProvider<
          AsyncValue<Certification?>,
          Certification?,
          FutureOr<Certification?>
        >
    with $FutureModifier<Certification?>, $FutureProvider<Certification?> {
  /// The certificate to warn about now (Home expiry alert, bell), or null.
  DueCertificateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dueCertificateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dueCertificateHash();

  @$internal
  @override
  $FutureProviderElement<Certification?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Certification?> create(Ref ref) {
    return dueCertificate(ref);
  }
}

String _$dueCertificateHash() => r'3f66766ad2f5c6df88ff07448f65e79d4755dd18';

/// Keeps the device's scheduled reminders in step with the switch, the
/// certificate list and the language. Watched by the tab scaffold.

@ProviderFor(reminderSync)
final reminderSyncProvider = ReminderSyncProvider._();

/// Keeps the device's scheduled reminders in step with the switch, the
/// certificate list and the language. Watched by the tab scaffold.

final class ReminderSyncProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Keeps the device's scheduled reminders in step with the switch, the
  /// certificate list and the language. Watched by the tab scaffold.
  ReminderSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSyncHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return reminderSync(ref);
  }
}

String _$reminderSyncHash() => r'ebf73486347dff8979ebf4ac5ebe90a9851183ec';

/// Turns expiry reminders on or off (shared by the Certs card and Profile).
/// Turning on asks the OS for permission.

@ProviderFor(setRemindersEnabled)
final setRemindersEnabledProvider = SetRemindersEnabledProvider._();

/// Turns expiry reminders on or off (shared by the Certs card and Profile).
/// Turning on asks the OS for permission.

final class SetRemindersEnabledProvider
    extends
        $FunctionalProvider<
          Future<void> Function(bool enabled),
          Future<void> Function(bool enabled),
          Future<void> Function(bool enabled)
        >
    with $Provider<Future<void> Function(bool enabled)> {
  /// Turns expiry reminders on or off (shared by the Certs card and Profile).
  /// Turning on asks the OS for permission.
  SetRemindersEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setRemindersEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setRemindersEnabledHash();

  @$internal
  @override
  $ProviderElement<Future<void> Function(bool enabled)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<void> Function(bool enabled) create(Ref ref) {
    return setRemindersEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<void> Function(bool enabled) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<void> Function(bool enabled)>(
        value,
      ),
    );
  }
}

String _$setRemindersEnabledHash() =>
    r'35918d9dd86ffbefae90d6131080f8fd408cb41e';

/// "Simulate expiry reminder" / bell: logs `notify.reminder`, fires a local
/// notification when reminders are on, and returns the text for the
/// in-app banner (null when there is no certificate to remind about).

@ProviderFor(simulateReminder)
final simulateReminderProvider = SimulateReminderProvider._();

/// "Simulate expiry reminder" / bell: logs `notify.reminder`, fires a local
/// notification when reminders are on, and returns the text for the
/// in-app banner (null when there is no certificate to remind about).

final class SimulateReminderProvider
    extends
        $FunctionalProvider<
          Future<({String body, String title})?> Function(),
          Future<({String body, String title})?> Function(),
          Future<({String body, String title})?> Function()
        >
    with $Provider<Future<({String body, String title})?> Function()> {
  /// "Simulate expiry reminder" / bell: logs `notify.reminder`, fires a local
  /// notification when reminders are on, and returns the text for the
  /// in-app banner (null when there is no certificate to remind about).
  SimulateReminderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simulateReminderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simulateReminderHash();

  @$internal
  @override
  $ProviderElement<Future<({String body, String title})?> Function()>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Future<({String body, String title})?> Function() create(Ref ref) {
    return simulateReminder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Future<({String body, String title})?> Function() value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<Future<({String body, String title})?> Function()>(
            value,
          ),
    );
  }
}

String _$simulateReminderHash() => r'4813e14908b1bda4456e0a7f6adc22888afee1ab';

/// Uploads a certificate (CERT-3) and refreshes the list.

@ProviderFor(uploadCertificate)
final uploadCertificateProvider = UploadCertificateProvider._();

/// Uploads a certificate (CERT-3) and refreshes the list.

final class UploadCertificateProvider
    extends
        $FunctionalProvider<
          Future<Certification> Function({
            required DateTime? expiresOn,
            required DateTime issuedOn,
            required String name,
          }),
          Future<Certification> Function({
            required DateTime? expiresOn,
            required DateTime issuedOn,
            required String name,
          }),
          Future<Certification> Function({
            required DateTime? expiresOn,
            required DateTime issuedOn,
            required String name,
          })
        >
    with
        $Provider<
          Future<Certification> Function({
            required DateTime? expiresOn,
            required DateTime issuedOn,
            required String name,
          })
        > {
  /// Uploads a certificate (CERT-3) and refreshes the list.
  UploadCertificateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadCertificateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadCertificateHash();

  @$internal
  @override
  $ProviderElement<
    Future<Certification> Function({
      required DateTime? expiresOn,
      required DateTime issuedOn,
      required String name,
    })
  >
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Future<Certification> Function({
    required DateTime? expiresOn,
    required DateTime issuedOn,
    required String name,
  })
  create(Ref ref) {
    return uploadCertificate(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Future<Certification> Function({
      required DateTime? expiresOn,
      required DateTime issuedOn,
      required String name,
    })
    value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            Future<Certification> Function({
              required DateTime? expiresOn,
              required DateTime issuedOn,
              required String name,
            })
          >(value),
    );
  }
}

String _$uploadCertificateHash() => r'b86be3aef4250dc6453b668668f23efb10e2c6e8';
