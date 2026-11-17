import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_db.g.dart';

/// A JSON document.
typedef Json = Map<String, Object?>;

/// Local key–value persistence behind every mock repository, so demo state
/// survives restarts. Values are JSON documents; keys sort lexicographically
/// (use zero-padded keys where order matters).
abstract interface class LocalDb {
  /// Opens (or creates) a named collection.
  Future<LocalCollection> open(String name);

  /// Deletes every document in every collection ("Reset demo data").
  Future<void> clearAll();
}

/// One collection of documents.
abstract interface class LocalCollection {
  /// Document at [key], or null.
  Future<Json?> get(String key);

  /// Stores [value] at [key] (insert or replace).
  Future<void> put(String key, Json value);

  /// All documents ordered by key.
  Future<List<Json>> values();

  /// Number of documents.
  Future<int> count();

  /// Removes the document at [key].
  Future<void> delete(String key);
}

/// Collection names used by the mock repositories.
abstract final class Collections {
  /// Seeding bookkeeping.
  static const String meta = 'meta';

  /// Signed-in session.
  static const String session = 'session';

  /// Course ownership.
  static const String ownership = 'ownership';

  /// Lesson completions.
  static const String progress = 'progress';

  /// Quiz attempts.
  static const String attempts = 'attempts';

  /// Certifications.
  static const String certifications = 'certifications';

  /// CPD ledger.
  static const String cpd = 'cpd';

  /// Sign-off requests.
  static const String signoffs = 'signoffs';

  /// Orders and receipts.
  static const String orders = 'orders';

  /// Append-only audit events.
  static const String audit = 'audit';

  /// Usage events.
  static const String usage = 'usage';

  /// Every collection (cleared on reset).
  static const List<String> all = <String>[
    meta,
    session,
    ownership,
    progress,
    attempts,
    certifications,
    cpd,
    signoffs,
    orders,
    audit,
    usage,
  ];
}

/// Volatile [LocalDb] for tests.
class InMemoryLocalDb implements LocalDb {
  final Map<String, _MemoryCollection> _collections =
      <String, _MemoryCollection>{};

  @override
  Future<LocalCollection> open(String name) async =>
      _collections.putIfAbsent(name, _MemoryCollection.new);

  @override
  Future<void> clearAll() async {
    for (final c in _collections.values) {
      c.data.clear();
    }
  }
}

class _MemoryCollection implements LocalCollection {
  final Map<String, Json> data = <String, Json>{};

  @override
  Future<Json?> get(String key) async =>
      data[key] == null ? null : Map<String, Object?>.of(data[key]!);

  @override
  Future<void> put(String key, Json value) async =>
      data[key] = Map<String, Object?>.of(value);

  @override
  Future<List<Json>> values() async {
    final keys = data.keys.toList()..sort();
    return <Json>[for (final k in keys) Map<String, Object?>.of(data[k]!)];
  }

  @override
  Future<int> count() async => data.length;

  @override
  Future<void> delete(String key) async => data.remove(key);
}

/// The app's [LocalDb]. Overridden in `main.dart` (Hive) and tests
/// (in memory).
@Riverpod(keepAlive: true)
LocalDb localDb(Ref ref) {
  throw UnimplementedError('localDbProvider must be overridden.');
}
