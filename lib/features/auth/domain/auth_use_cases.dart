import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/data/auth_repository.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';

/// English role label used in audit targets (the audit log is not
/// localized; the UI shows localized role names).
String roleAuditLabel(Role role) => switch (role) {
  Role.learner => 'Learner',
  Role.supervisor => 'Supervisor',
  Role.admin => 'Admin',
};

/// AUTH-1: sign in through [AuthRepository].
class SignIn {
  /// Creates the use case.
  const new(this._repo);

  final AuthRepository _repo;

  /// Signs in; throws [InvalidCredentialsException] for empty fields.
  Future<AppUser> call({
    required String email,
    required String password,
    required Role role,
  }) => _repo.signIn(email: email, password: password, role: role);
}

/// AUTH-2: demo role switch, written to the audit log.
class SwitchRole {
  /// Creates the use case.
  const new(this._repo, this._logger);

  final AuthRepository _repo;
  final ActivityLogger _logger;

  /// Switches from [from] to [to] and returns the new user. [afterSwitch]
  /// runs before the audit event so the logger stamps the new actor.
  Future<AppUser> call({
    required Role from,
    required Role to,
    required void Function(AppUser user) afterSwitch,
  }) async {
    final user = await _repo.switchRole(to);
    afterSwitch(user);
    await _logger.audit(
      AuditAction.roleChange,
      target: '${roleAuditLabel(from)} → ${roleAuditLabel(to)} (demo)',
    );
    return user;
  }
}

/// AUTH-3: sign out (usage event first, while the actor is still known).
class SignOut {
  /// Creates the use case.
  const new(this._repo, this._logger);

  final AuthRepository _repo;
  final ActivityLogger _logger;

  /// Logs `auth.signout` and clears the stored session.
  Future<void> call() async {
    _logger.usage(UsageAction.authSignout, target: 'Session ended');
    await _repo.signOut();
  }
}
