import 'dart:convert';

import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'seed_loader.g.dart';

/// Seed files in `lib/seed/`. Their schema is a contract.
enum SeedFile {
  /// Demo constants (demo time, seller, invoice sequence).
  demo('demo.json'),

  /// Tenant and users.
  users('users.json'),

  /// Categories, courses, lessons, enrolments.
  courses('courses.json'),

  /// Question bank, quiz definitions, learner quiz history.
  questionBank('question_bank.json'),

  /// Certifications and status rule.
  certifications('certifications.json'),

  /// CPD target and ledger.
  cpd('cpd.json'),

  /// Competency checklists.
  checklists('checklists.json'),

  /// Sign-off requests.
  signoffs('signoffs.json'),

  /// Admin cohort aggregates (demo figures).
  cohort('cohort.json'),

  /// Historical audit events.
  auditSeed('audit_seed.json');

  new(this.fileName);

  /// File name under `lib/seed/`.
  final String fileName;
}

/// Reads seed documents.
abstract interface class SeedLoader {
  /// Parsed JSON of [file].
  Future<Json> load(SeedFile file);
}

/// Loads seed files from the asset bundle (cached).
class AssetSeedLoader implements SeedLoader {
  /// Creates the loader.
  new({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;
  final Map<SeedFile, Future<Json>> _cache = <SeedFile, Future<Json>>{};

  @override
  Future<Json> load(SeedFile file) => _cache[file] ??= _bundle
      // cache: false — rootBundle's global cache would share one pending
      // load across ProviderContainers (and test zones); we cache per loader.
      .loadString('lib/seed/${file.fileName}', cache: false)
      .then((s) => (jsonDecode(s) as Map).cast<String, Object?>());
}

/// The seed loader.
@Riverpod(keepAlive: true)
SeedLoader seedLoader(Ref ref) => AssetSeedLoader();

/// Typed helpers for raw seed JSON.
extension JsonRead on Json {
  /// List of objects at [key].
  List<Json> objects(String key) => (this[key]! as List)
      .map((e) => (e as Map).cast<String, Object?>())
      .toList();

  /// Object at [key].
  Json object(String key) => (this[key]! as Map).cast<String, Object?>();
}
