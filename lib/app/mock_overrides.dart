import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/app/state/session.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/features/admin/data/cohort_repository.dart';
import 'package:clinical_edge/features/assessments/data/assessment_repository.dart';
import 'package:clinical_edge/features/auth/data/auth_repository.dart';
import 'package:clinical_edge/features/auth/data/mock_auth_repository.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/features/certifications/data/certification_repository.dart';
import 'package:clinical_edge/features/checkout/data/checkout_repository.dart';
import 'package:clinical_edge/features/competencies/data/competency_repository.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:clinical_edge/features/courses/data/mock_course_repository.dart';
import 'package:clinical_edge/seed/demo_seeder.dart';
import 'package:clinical_edge/seed/seed_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:shared_preferences/shared_preferences.dart';

/// Provider overrides that plug the v1 mocks in. Swapping to Firebase
/// means a second list like this one, with no widget changes.
List<Override> mockOverrides({
  required LocalDb db,
  required SharedPreferences prefs,
  SeedLoader? seed,
}) {
  return <Override>[
    sharedPreferencesProvider.overrideWithValue(prefs),
    localDbProvider.overrideWithValue(db),
    if (seed != null) seedLoaderProvider.overrideWithValue(seed),
    // Phase 1 session stub → actor. Phase 3 reads the auth user instead.
    currentActorProvider.overrideWith(
      (ref) => () {
        final role = ref.read(sessionProvider).role;
        return (userId: SeedUsers.forRole(role), role: role);
      },
    ),
    authRepositoryProvider.overrideWith(
      (ref) => MockAuthRepository(
        seed: ref.watch(seedLoaderProvider),
        db: ref.watch(localDbProvider),
        seeder: ref.watch(demoSeederProvider),
      ),
    ),
    courseRepositoryProvider.overrideWith(
      (ref) => MockCourseRepository(
        seed: ref.watch(seedLoaderProvider),
        db: ref.watch(localDbProvider),
        seeder: ref.watch(demoSeederProvider),
      ),
    ),
    progressRepositoryProvider.overrideWith(
      (ref) => MockProgressRepository(
        db: ref.watch(localDbProvider),
        seeder: ref.watch(demoSeederProvider),
        clock: ref.watch(clockProvider),
      ),
    ),
    assessmentRepositoryProvider.overrideWith(
      (ref) => MockAssessmentRepository(
        seed: ref.watch(seedLoaderProvider),
        db: ref.watch(localDbProvider),
        seeder: ref.watch(demoSeederProvider),
      ),
    ),
    certificationRepositoryProvider.overrideWith(
      (ref) => MockCertificationRepository(
        db: ref.watch(localDbProvider),
        seeder: ref.watch(demoSeederProvider),
      ),
    ),
    cpdRepositoryProvider.overrideWith(
      (ref) => MockCpdRepository(
        seed: ref.watch(seedLoaderProvider),
        db: ref.watch(localDbProvider),
        seeder: ref.watch(demoSeederProvider),
      ),
    ),
    competencyRepositoryProvider.overrideWith(
      (ref) => MockCompetencyRepository(
        seed: ref.watch(seedLoaderProvider),
        db: ref.watch(localDbProvider),
        seeder: ref.watch(demoSeederProvider),
        clock: ref.watch(clockProvider),
      ),
    ),
    checkoutRepositoryProvider.overrideWith(
      (ref) => MockCheckoutRepository(
        seed: ref.watch(seedLoaderProvider),
        db: ref.watch(localDbProvider),
        seeder: ref.watch(demoSeederProvider),
        clock: ref.watch(clockProvider),
      ),
    ),
    cohortRepositoryProvider.overrideWith(
      (ref) => MockCohortRepository(seed: ref.watch(seedLoaderProvider)),
    ),
  ];
}

/// "Reset demo data": wipes local state, re-seeds and signs out.
Future<void> resetDemoData(WidgetRef ref) async {
  await ref.read(demoSeederProvider).reset();
  ref.read(sessionProvider.notifier).signOut();
}
