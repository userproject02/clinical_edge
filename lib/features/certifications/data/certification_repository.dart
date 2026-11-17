import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/seed/demo_seeder.dart';
import 'package:clinical_edge/seed/seed_loader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'certification_repository.g.dart';

/// Certifications.
abstract interface class CertificationRepository {
  /// Certifications of [userId], soonest expiry first.
  Future<List<Certification>> list(String userId);

  /// Stores an uploaded certificate as "verifying".
  Future<Certification> upload({
    required String userId,
    required LocalizedText name,
    required LocalizedText issuer,
    required DateTime issuedOn,
    required DateTime expiresOn,
    String? fileRef,
  });
}

/// CPD credits.
abstract interface class CpdRepository {
  /// Cycle target (config).
  Future<CpdConfig> config();

  /// Ledger of [userId], newest first.
  Future<List<CpdEntry>> ledger(String userId);

  /// Sum of the ledger.
  Future<int> total(String userId);

  /// Adds a ledger line (e.g. on course completion).
  Future<CpdEntry> add(CpdEntry entry);
}

/// Mock [CertificationRepository] on [LocalDb].
class MockCertificationRepository implements CertificationRepository {
  /// Creates the repository.
  new({required this.db, required this.seeder, Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  /// Persistence.
  final LocalDb db;

  /// Ensures demo data exists.
  final DemoSeeder seeder;

  final Uuid _uuid;

  @override
  Future<List<Certification>> list(String userId) async {
    await seeder.ready;
    final rows = await (await db.open(Collections.certifications)).values();
    return rows
        .map(Certification.fromJson)
        .where((c) => c.userId == userId)
        .toList()
      ..sort((a, b) => a.expiresOn.compareTo(b.expiresOn));
  }

  @override
  Future<Certification> upload({
    required String userId,
    required LocalizedText name,
    required LocalizedText issuer,
    required DateTime issuedOn,
    required DateTime expiresOn,
    String? fileRef,
  }) async {
    await seeder.ready;
    final cert = Certification(
      id: 'cert-${_uuid.v4()}',
      userId: userId,
      name: name,
      issuer: issuer,
      issuedOn: issuedOn,
      expiresOn: expiresOn,
      verification: Verification.pending,
      fileRef: fileRef,
    );
    await (await db.open(Collections.certifications))
        .put(cert.id, cert.toJson());
    return cert;
  }
}

/// Mock [CpdRepository]: config from seed, ledger in [LocalDb].
class MockCpdRepository implements CpdRepository {
  /// Creates the repository.
  new({required this.seed, required this.db, required this.seeder});

  /// Seed source.
  final SeedLoader seed;

  /// Persistence.
  final LocalDb db;

  /// Ensures demo data exists.
  final DemoSeeder seeder;

  @override
  Future<CpdConfig> config() async =>
      CpdConfig.fromJson(await seed.load(SeedFile.cpd));

  @override
  Future<List<CpdEntry>> ledger(String userId) async {
    await seeder.ready;
    final rows = await (await db.open(Collections.cpd)).values();
    return rows.map(CpdEntry.fromJson).where((e) => e.userId == userId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<int> total(String userId) async =>
      (await ledger(userId)).fold<int>(0, (sum, e) => sum + e.credits);

  @override
  Future<CpdEntry> add(CpdEntry entry) async {
    await seeder.ready;
    await (await db.open(Collections.cpd)).put(entry.id, entry.toJson());
    return entry;
  }
}

/// The certification repository.
@Riverpod(keepAlive: true)
CertificationRepository certificationRepository(Ref ref) =>
    throw UnimplementedError('Override certificationRepositoryProvider.');

/// The CPD repository.
@Riverpod(keepAlive: true)
CpdRepository cpdRepository(Ref ref) =>
    throw UnimplementedError('Override cpdRepositoryProvider.');
