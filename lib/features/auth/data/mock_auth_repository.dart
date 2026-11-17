import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/data/auth_repository.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/seed/demo_seeder.dart';
import 'package:clinical_edge/seed/seed_loader.dart';

/// Mock [AuthRepository] on the seed users; the session persists in
/// [LocalDb] so a demo survives a restart.
class MockAuthRepository implements AuthRepository {
  /// Creates the repository.
  new({required this.seed, required this.db, required this.seeder});

  /// Seed source.
  final SeedLoader seed;

  /// Persistence.
  final LocalDb db;

  /// Ensures demo data exists.
  final DemoSeeder seeder;

  @override
  Future<LocalizedText> tenant() async => LocalizedText.fromJson(
    (await seed.load(SeedFile.users)).object('tenant'),
  );

  @override
  Future<List<AppUser>> users() async =>
      (await seed.load(SeedFile.users))
          .objects('users')
          .map(AppUser.fromJson)
          .toList();

  @override
  Future<AppUser?> userById(String id) async {
    for (final u in await users()) {
      if (u.id == id) return u;
    }
    return null;
  }

  @override
  Future<AppUser?> currentUser() async {
    await seeder.ready;
    final s = await (await db.open(Collections.session)).get('current');
    if (s == null) return null;
    return await userById(s['userId']! as String);
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
    required Role role,
  }) async {
    final emailEmpty = email.trim().isEmpty;
    final passwordEmpty = password.isEmpty;
    if (emailEmpty || passwordEmpty) {
      throw InvalidCredentialsException(
        emailEmpty: emailEmpty,
        passwordEmpty: passwordEmpty,
      );
    }
    return await _setCurrent(role);
  }

  @override
  Future<AppUser> switchRole(Role role) => _setCurrent(role);

  @override
  Future<void> signOut() async {
    await seeder.ready;
    await (await db.open(Collections.session)).delete('current');
  }

  Future<AppUser> _setCurrent(Role role) async {
    await seeder.ready;
    final user = (await userById(SeedUsers.forRole(role)))!;
    await (await db.open(Collections.session))
        .put('current', <String, Object?>{'userId': user.id});
    return user;
  }
}
