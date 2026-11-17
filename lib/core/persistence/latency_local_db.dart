import 'dart:math';

import 'package:clinical_edge/core/persistence/local_db.dart';

/// Wraps a [LocalDb] so list queries (`values()`) take 300–900 ms, like a
/// network call, and the app shows its loading states (NFR Performance).
/// Single-row reads and writes are not delayed. Used by `main.dart` only;
/// tests use the plain database.
class LatencyLocalDb implements LocalDb {
  /// Creates the wrapper. [random] is injected (AGENTS.md: no ambient
  /// randomness).
  new(this.inner, {required this.random, this.min = 300, this.max = 900});

  /// Wrapped database.
  final LocalDb inner;

  /// Shortest delay in ms.
  final int min;

  /// Longest delay in ms.
  final int max;

  /// Latency source.
  final Random random;

  /// Next simulated latency.
  Duration nextDelay() =>
      Duration(milliseconds: min + random.nextInt(max - min + 1));

  @override
  Future<LocalCollection> open(String name) async =>
      _LatencyCollection(await inner.open(name), this);

  @override
  Future<void> clearAll() => inner.clearAll();
}

class _LatencyCollection implements LocalCollection {
  new(this._inner, this._db);

  final LocalCollection _inner;
  final LatencyLocalDb _db;

  @override
  Future<Json?> get(String key) => _inner.get(key);

  @override
  Future<void> put(String key, Json value) => _inner.put(key, value);

  @override
  Future<List<Json>> values() async {
    await Future<void>.delayed(_db.nextDelay());
    return await _inner.values();
  }

  @override
  Future<int> count() => _inner.count();

  @override
  Future<void> delete(String key) => _inner.delete(key);
}
