import 'package:clinical_edge/core/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

/// TEMPORARY session stub so the router guards work in Phase 1.
///
/// Phase 3 replaces it with the auth feature (`AuthRepository`,
/// `currentUser`, `switchRole`) and the audit-logged role switch.
@freezed
abstract class Session with _$Session {
  /// Creates a session.
  const factory({
    @Default(false) bool signedIn,
    @Default(Role.learner) Role role,
  }) = _Session;
}

/// Holds the stub [Session]. Not persisted: the app starts signed out.
@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  @override
  Session build() => const Session();

  /// Signs in as [role] (stub: no credentials).
  void signIn(Role role) => state = Session(signedIn: true, role: role);

  /// Switches role while signed in.
  void switchRole(Role role) => state = state.copyWith(role: role);

  /// Signs out.
  void signOut() => state = state.copyWith(signedIn: false);
}

/// Placeholder avatar initials per role until Phase 3 provides the user.
extension RoleInitials on Role {
  /// Initials of the seed user for this role.
  String get stubInitials => switch (this) {
    Role.learner => 'LH',
    Role.supervisor => 'OM',
    Role.admin => 'SK',
  };
}
