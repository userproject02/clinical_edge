import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

/// Thrown when sign-in fields are empty.
class InvalidCredentialsException implements Exception {
  /// Creates the exception.
  const new({required this.emailEmpty, required this.passwordEmpty});

  /// Email was empty.
  final bool emailEmpty;

  /// Password was empty.
  final bool passwordEmpty;
}

/// Users and the signed-in session. Mock in v1 (any non-empty password);
/// Firebase Auth or hospital SSO later.
abstract interface class AuthRepository {
  /// Organisation name.
  Future<LocalizedText> tenant();

  /// Every user (demo accounts and cohort learners).
  Future<List<AppUser>> users();

  /// User by id.
  Future<AppUser?> userById(String id);

  /// The signed-in user, or null.
  Future<AppUser?> currentUser();

  /// Signs in. The demo [role] picks the seed account; throws
  /// [InvalidCredentialsException] for empty fields. Never stores the
  /// password.
  Future<AppUser> signIn({
    required String email,
    required String password,
    required Role role,
  });

  /// Signs out.
  Future<void> signOut();

  /// Demo role switch: signs in as the seed account of [role].
  Future<AppUser> switchRole(Role role);
}

/// The auth repository (overridden with the mock in `main.dart`).
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    throw UnimplementedError('Override authRepositoryProvider.');
