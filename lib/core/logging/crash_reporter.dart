import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'crash_reporter.g.dart';

/// Receives errors. Never writes to the audit store (later: Crashlytics).
abstract interface class CrashReporter {
  /// Records an error with an optional short reason.
  void record(Object error, StackTrace stack, {String? reason});
}

/// Prints errors to the debug console in debug and profile builds; silent
/// in release (errors could carry user data).
class ConsoleCrashReporter implements CrashReporter {
  /// Creates the reporter.
  const new();

  @override
  void record(Object error, StackTrace stack, {String? reason}) {
    if (kReleaseMode) return;
    debugPrint('CrashReporter${reason == null ? '' : ' [$reason]'}: $error');
    debugPrintStack(stackTrace: stack, maxFrames: 8);
  }
}

/// The app crash reporter.
@Riverpod(keepAlive: true)
CrashReporter crashReporter(Ref ref) => const ConsoleCrashReporter();
