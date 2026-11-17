/// Compile-time feature flags.
library;

/// Demo role switcher on sign-in and in Profile & settings (AUTH-2).
/// v1 only: in production roles come from the backend (custom claims) and
/// this must be off (REQUIREMENTS.md → Users and roles).
const bool kDemoRoleSwitcher = bool.fromEnvironment(
  'DEMO_ROLE_SWITCHER',
  defaultValue: true,
);
