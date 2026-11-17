import 'package:clinical_edge/core/json_converters.dart';
import 'package:clinical_edge/core/logging/activity_event.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/seed/seed_loader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'demo_seeder.g.dart';

/// Copies the mutable parts of the seed into [LocalDb] on first run, so the
/// mock repositories start from the same demo state and then persist
/// changes across restarts. Static data (catalogue, question bank,
/// checklists, cohort) is always read straight from the seed.
class DemoSeeder {
  /// Creates the seeder.
  new({required this.db, required this.seed, required this.auditStore});

  /// Bump when the seed schema or contents change to re-seed on update.
  static const int seedVersion = 3;

  /// Persistence.
  final LocalDb db;

  /// Seed source.
  final SeedLoader seed;

  /// Where historical audit events are appended.
  final AuditStore auditStore;

  Future<void>? _ready;

  /// Completes once the database holds the demo data.
  Future<void> get ready => _ready ??= _ensure();

  /// "Reset demo data": wipes every collection and seeds again.
  Future<void> reset() async {
    await _ready?.catchError((Object _) {});
    await db.clearAll();
    _ready = _seed();
    await _ready;
  }

  Future<void> _ensure() async {
    final meta = await db.open(Collections.meta);
    final info = await meta.get('seed');
    if (info?['version'] == seedVersion) return;
    await db.clearAll();
    await _seed();
  }

  Future<void> _seed() async {
    const utc = UtcDateTimeConverter();

    final courses = await seed.load(SeedFile.courses);
    final ownership = await db.open(Collections.ownership);
    final progress = await db.open(Collections.progress);
    for (final e in courses.objects('enrolments')) {
      final userId = e['userId']! as String;
      final courseId = e['courseId']! as String;
      if (e['owned'] == true) {
        await ownership.put('$userId|$courseId', <String, Object?>{
          'userId': userId,
          'courseId': courseId,
        });
      }
      for (final c in e.objects('completed')) {
        final lessonId = c['lessonId']! as String;
        await progress.put('$userId|$lessonId', <String, Object?>{
          'userId': userId,
          'lessonId': lessonId,
          'completedAt': utc.toJson(utc.fromJson(c['completedAt']! as String)),
        });
      }
    }

    final bank = await seed.load(SeedFile.questionBank);
    final attempts = await db.open(Collections.attempts);
    for (final a in bank.objects('history')) {
      await attempts.put(a['id']! as String, <String, Object?>{
        ...a,
        'submittedAt': utc.toJson(utc.fromJson(a['submittedAt']! as String)),
      });
    }

    await _copy(
      SeedFile.certifications,
      'certifications',
      Collections.certifications,
    );
    await _copy(SeedFile.cpd, 'ledger', Collections.cpd);
    await _copy(SeedFile.signoffs, 'requests', Collections.signoffs);

    final demo = await seed.load(SeedFile.demo);
    final audit = await seed.load(SeedFile.auditSeed);
    for (final e in audit.objects('events')) {
      await auditStore.append(
        AuditDraft(
          id: e['id']! as String,
          ts: utc.fromJson(e['ts']! as String),
          userId: e['userId']! as String,
          role: Role.values.byName(e['role']! as String),
          action: AuditAction.fromWire(e['action']! as String),
          target: e['target']! as String,
          platform: e['platform']! as String,
        ),
      );
    }

    final meta = await db.open(Collections.meta);
    await meta.put('invoice', <String, Object?>{
      'next': demo['nextInvoiceSeq'],
    });
    await meta.put('seed', <String, Object?>{'version': seedVersion});
  }

  Future<void> _copy(SeedFile file, String listKey, String collection) async {
    final doc = await seed.load(file);
    final col = await db.open(collection);
    for (final item in doc.objects(listKey)) {
      await col.put(item['id']! as String, _normaliseTimes(item));
    }
  }

  /// Stores instants as UTC ISO strings so ordering by string works.
  Json _normaliseTimes(Json item) {
    const utc = NullableUtcDateTimeConverter();
    return <String, Object?>{
      for (final MapEntry(:key, :value) in item.entries)
        key: value is String && key.endsWith('At')
            ? utc.toJson(utc.fromJson(value))
            : value,
    };
  }
}

/// The demo seeder (shared by every mock repository).
@Riverpod(keepAlive: true)
DemoSeeder demoSeeder(Ref ref) => DemoSeeder(
  db: ref.watch(localDbProvider),
  seed: ref.watch(seedLoaderProvider),
  auditStore: ref.watch(auditStoreProvider),
);
