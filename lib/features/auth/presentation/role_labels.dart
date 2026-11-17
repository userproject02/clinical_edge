import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/core/role.dart';

/// Localized role name.
String roleLabel(AppLocalizations l, Role role) => switch (role) {
  Role.learner => l.roleLearner,
  Role.supervisor => l.roleSupervisor,
  Role.admin => l.roleAdmin,
};
