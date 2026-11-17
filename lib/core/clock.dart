import 'package:clinical_edge/app/state/preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

/// Source of the current time. Inject it; never call `DateTime.now()`
/// outside [SystemClock] (AGENTS.md → Architecture rules).
abstract interface class Clock {
  /// The current instant, in UTC.
  DateTime now();
}

/// The real device clock.
class SystemClock implements Clock {
  /// Creates the system clock.
  const new();

  @override
  DateTime now() => DateTime.now().toUtc();
}

/// A clock frozen at a given instant (tests and the stable demo).
class FixedClock implements Clock {
  /// Creates a clock that always returns [instant].
  new(DateTime instant) : _instant = instant.toUtc();

  final DateTime _instant;

  @override
  DateTime now() => _instant;
}

/// Demo time: 2026-11-17 09:00 in Asia/Dubai (UTC+4) = 05:00 UTC. Every
/// expiry in the seed is computed from this, so the demo always reads the
/// same (BLS renews in 56 days, ACLS valid for 317).
final DateTime demoNow = DateTime.utc(2026, 11, 17, 5);

/// UAE time has no daylight saving: always UTC+4.
const Duration dubaiOffset = Duration(hours: 4);

/// Calendar helpers on a [Clock].
extension ClockDates on Clock {
  /// Today's calendar date in Asia/Dubai, as a UTC-midnight `DateTime`.
  DateTime today() => dubaiDate(now());
}

/// Calendar date in Asia/Dubai of a UTC [instant] (UTC midnight value).
DateTime dubaiDate(DateTime instant) {
  final local = instant.toUtc().add(dubaiOffset);
  return DateTime.utc(local.year, local.month, local.day);
}

/// Whole days from [from] to [to] (both calendar dates).
int daysBetween(DateTime from, DateTime to) {
  final a = DateTime.utc(from.year, from.month, from.day);
  final b = DateTime.utc(to.year, to.month, to.day);
  return b.difference(a).inDays;
}

/// Which clock the app uses.
enum ClockMode {
  /// Frozen at [demoNow] (default, stable demo).
  fixedDemo,

  /// Real device time.
  system,
}

/// Clock mode, persisted; switchable from the debug menu.
@Riverpod(keepAlive: true)
class ClockModeNotifier extends _$ClockModeNotifier {
  static const String _key = 'debug.clockMode';

  @override
  ClockMode build() {
    final saved = ref.watch(sharedPreferencesProvider).getString(_key);
    return ClockMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => ClockMode.fixedDemo,
    );
  }

  /// Switches and saves the mode.
  Future<void> set(ClockMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(_key, mode.name);
  }
}

/// The app clock.
@Riverpod(keepAlive: true)
Clock clock(Ref ref) => switch (ref.watch(clockModeProvider)) {
  ClockMode.fixedDemo => FixedClock(demoNow),
  ClockMode.system => const SystemClock(),
};
