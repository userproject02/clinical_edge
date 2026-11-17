import 'package:clinical_edge/features/admin/domain/cohort.dart';
import 'package:clinical_edge/seed/seed_loader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cohort_repository.g.dart';

/// Admin aggregates (cohort dashboard, insights).
abstract interface class CohortRepository {
  /// Cohort aggregates (demo figures in v1).
  Future<CohortStats> stats();
}

/// Mock [CohortRepository] reading `cohort.json`.
class MockCohortRepository implements CohortRepository {
  /// Creates the repository.
  new({required this.seed});

  /// Seed source.
  final SeedLoader seed;

  @override
  Future<CohortStats> stats() async =>
      CohortStats.fromJson(await seed.load(SeedFile.cohort));
}

/// The cohort repository.
@Riverpod(keepAlive: true)
CohortRepository cohortRepository(Ref ref) =>
    throw UnimplementedError('Override cohortRepositoryProvider.');
