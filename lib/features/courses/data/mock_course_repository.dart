import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:clinical_edge/seed/demo_seeder.dart';
import 'package:clinical_edge/seed/seed_loader.dart';

/// Mock [CourseRepository]: catalogue from seed, ownership in [LocalDb].
class MockCourseRepository implements CourseRepository {
  /// Creates the repository.
  new({required this.seed, required this.db, required this.seeder});

  /// Seed source.
  final SeedLoader seed;

  /// Persistence.
  final LocalDb db;

  /// Ensures demo data exists.
  final DemoSeeder seeder;

  @override
  Future<List<CourseCategory>> categories() async =>
      (await seed.load(SeedFile.courses))
          .objects('categories')
          .map(CourseCategory.fromJson)
          .toList();

  @override
  Future<List<Course>> catalogue() async =>
      (await seed.load(SeedFile.courses))
          .objects('courses')
          .map(Course.fromJson)
          .toList();

  @override
  Future<Course?> byId(String courseId) async {
    for (final c in await catalogue()) {
      if (c.id == courseId) return c;
    }
    return null;
  }

  @override
  Future<Set<String>> ownedCourseIds(String userId) async {
    await seeder.ready;
    final rows = await (await db.open(Collections.ownership)).values();
    return <String>{
      for (final r in rows)
        if (r['userId'] == userId) r['courseId']! as String,
    };
  }

  @override
  Future<bool> isOwned(String userId, String courseId) async =>
      (await ownedCourseIds(userId)).contains(courseId);

  @override
  Future<void> grantOwnership(String userId, String courseId) async {
    await seeder.ready;
    await (await db.open(Collections.ownership)).put(
      '$userId|$courseId',
      <String, Object?>{'userId': userId, 'courseId': courseId},
    );
  }
}

/// Mock [ProgressRepository] on [LocalDb].
class MockProgressRepository implements ProgressRepository {
  /// Creates the repository.
  new({required this.db, required this.seeder, required this.clock});

  /// Persistence.
  final LocalDb db;

  /// Ensures demo data exists.
  final DemoSeeder seeder;

  /// Time source for completion stamps.
  final Clock clock;

  @override
  Future<List<LessonProgress>> forUser(String userId) async {
    await seeder.ready;
    final rows = await (await db.open(Collections.progress)).values();
    return rows
        .where((r) => r['userId'] == userId)
        .map(LessonProgress.fromJson)
        .toList();
  }

  @override
  Future<LessonProgress> markComplete(String userId, String lessonId) async {
    await seeder.ready;
    final col = await db.open(Collections.progress);
    final key = '$userId|$lessonId';
    final existing = await col.get(key);
    if (existing != null) return LessonProgress.fromJson(existing);
    final p = LessonProgress(
      userId: userId,
      lessonId: lessonId,
      completedAt: clock.now(),
    );
    await col.put(key, p.toJson());
    return p;
  }
}
