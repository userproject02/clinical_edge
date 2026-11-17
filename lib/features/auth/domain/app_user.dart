import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// A ClinicalEdge user (staff only; there is no patient data anywhere).
@freezed
abstract class AppUser with _$AppUser {
  /// Creates a user.
  const factory({
    required String id,
    required LocalizedText name,
    required LocalizedText shortName,
    required LocalizedText title,
    required String department,
    required String email,
    required Role role,
    required String initials,
    @Default(false) bool cohort,
    @Default('en') String locale,
  }) = _AppUser;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$AppUserFromJson(json);
}

/// Seed user ids of the three demo accounts.
abstract final class SeedUsers {
  /// Dr. Layla Haddad (learner).
  static const String learner = 'u-layla';

  /// Dr. Omar Al Mansoori (supervisor).
  static const String supervisor = 'u-omar';

  /// Sara Khan (admin).
  static const String admin = 'u-sara';

  /// The demo account for [role].
  static String forRole(Role role) => switch (role) {
    Role.learner => learner,
    Role.supervisor => supervisor,
    Role.admin => admin,
  };
}
