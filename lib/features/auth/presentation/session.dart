import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/data/auth_repository.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/features/auth/domain/auth_use_cases.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.g.dart';

/// The signed-in user and the active role.
@immutable
class Session {
  /// Creates a session.
  const new({required this.user, required this.role});

  /// Signed-in user.
  final AppUser user;

  /// Active role (the demo switcher changes it).
  final Role role;

  @override
  bool operator ==(Object other) =>
      other is Session && other.user == user && other.role == role;

  @override
  int get hashCode => Object.hash(user, role);
}

/// The session: null when signed out. Persisted by [AuthRepository], so a
/// restart keeps the user signed in. The router redirect reads it.
@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  @override
  Future<Session?> build() async {
    final user = await ref.watch(authRepositoryProvider).currentUser();
    return user == null ? null : Session(user: user, role: user.role);
  }

  /// AUTH-1. Throws [InvalidCredentialsException] for empty fields.
  Future<Session> signIn({
    required String email,
    required String password,
    required Role role,
  }) async {
    final user = await SignIn(ref.read(authRepositoryProvider))(
      email: email,
      password: password,
      role: role,
    );
    final session = Session(user: user, role: user.role);
    state = AsyncData<Session?>(session);
    ref.read(firstHomeLoadProvider.notifier).arm();
    ref
        .read(activityLoggerProvider)
        .usage(UsageAction.authSignin, target: 'Session started');
    return session;
  }

  /// AUTH-2 (demo only): switches role and writes `role.change`.
  Future<Session> switchRole(Role to) async {
    final current = state.value;
    if (current == null) throw StateError('Not signed in');
    if (current.role == to) return current;
    late Session next;
    await SwitchRole(
      ref.read(authRepositoryProvider),
      ref.read(activityLoggerProvider),
    )(
      from: current.role,
      to: to,
      afterSwitch: (user) {
        next = Session(user: user, role: user.role);
        state = AsyncData<Session?>(next);
      },
    );
    return next;
  }

  /// AUTH-3: logs `auth.signout`, clears the session.
  Future<void> signOut() async {
    await SignOut(
      ref.read(authRepositoryProvider),
      ref.read(activityLoggerProvider),
    )();
    state = const AsyncData<Session?>(null);
  }
}

/// How long the first home load after sign-in shows its skeleton.
const Duration firstHomeLoadDelay = Duration(milliseconds: 900);

/// True between sign-in and the end of the first home load's skeleton.
@Riverpod(keepAlive: true)
class FirstHomeLoad extends _$FirstHomeLoad {
  @override
  bool build() => false;

  /// Called on sign-in.
  void arm() => state = true;

  /// Called once the skeleton has been shown.
  void done() => state = false;
}

/// Where the router should land after it is rebuilt for a role switch
/// (e.g. stay on `/profile`). Consumed once.
@Riverpod(keepAlive: true)
class ResumeLocation extends _$ResumeLocation {
  @override
  String? build() => null;

  /// Sets the location for the next router rebuild.
  // ignore: use_setters_to_change_properties
  void set(String? location) => state = location;
}

/// The demo account for each role (sign-in pre-fills its email).
@Riverpod(keepAlive: true)
Future<Map<Role, AppUser>> demoAccounts(Ref ref) async {
  final repo = ref.watch(authRepositoryProvider);
  return <Role, AppUser>{
    for (final r in Role.values)
      r: (await repo.userById(SeedUsers.forRole(r)))!,
  };
}

/// Organisation name shown under the user on Profile and as the tab app
/// bar subtitle.
@Riverpod(keepAlive: true)
Future<LocalizedText> tenant(Ref ref) =>
    ref.watch(authRepositoryProvider).tenant();
