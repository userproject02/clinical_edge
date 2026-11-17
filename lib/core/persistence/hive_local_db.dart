import 'dart:convert';

import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// [LocalDb] on Hive CE. Each collection is a `Box<String>` of JSON text,
/// so no type adapters are needed and the seed schema stays the contract.
class HiveLocalDb implements LocalDb {
  new _();

  /// Initialises Hive in [directory] (tests, tools).
  factory atPath(String directory) {
    Hive.init(directory);
    return HiveLocalDb._();
  }

  /// Initialises Hive in the app documents directory.
  static Future<HiveLocalDb> init() async {
    await Hive.initFlutter('clinical_edge');
    return HiveLocalDb._();
  }

  /// Closes every open box.
  Future<void> close() async {
    for (final b in _boxes.values) {
      await b.close();
    }
    _boxes.clear();
  }

  final Map<String, Box<String>> _boxes = <String, Box<String>>{};

  Future<Box<String>> _box(String name) async =>
      _boxes[name] ??= await Hive.openBox<String>(name);

  @override
  Future<LocalCollection> open(String name) async =>
      _HiveCollection(await _box(name));

  @override
  Future<void> clearAll() async {
    for (final name in Collections.all) {
      await (await _box(name)).clear();
    }
  }
}

class _HiveCollection implements LocalCollection {
  new(this._box);

  final Box<String> _box;

  @override
  Future<Json?> get(String key) async {
    final raw = _box.get(key);
    return raw == null
        ? null
        : (jsonDecode(raw) as Map).cast<String, Object?>();
  }

  @override
  Future<void> put(String key, Json value) => _box.put(key, jsonEncode(value));

  @override
  Future<List<Json>> values() async {
    final keys = _box.keys.cast<String>().toList()..sort();
    return <Json>[
      for (final k in keys)
        (jsonDecode(_box.get(k)!) as Map).cast<String, Object?>(),
    ];
  }

  @override
  Future<int> count() async => _box.length;

  @override
  Future<void> delete(String key) => _box.delete(key);
}
