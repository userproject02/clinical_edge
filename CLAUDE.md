@AGENTS.md

# ClinicalEdge — project context

> Read this before every change. Update it in the same commit as every change.

## Product in one paragraph

Flutter mobile app (iOS + Android only) for UAE healthcare professionals to take courses and quizzes, track certifications and CPD/CME credits, and get competencies signed off by supervisors, with an admin view of cohort progress and an append-only audit log. v1 is a clickable prototype on mock local data; every data source sits behind an interface so Firebase and a UAE payment gateway can replace the mocks later. Requirements: `docs/REQUIREMENTS.md`. Build plan: 11 phases (0–10).

## Current status

- Phase: **Phase 1 done, next: Phase 2 Core and seed**
- Done: 0 Repo and context · 1 Scaffold and design system (theme tokens, fonts, motion, EN/AR + RTL, go_router role shells, 16 shared widgets with goldens)
- App code: every route is a placeholder showing its title; no business features yet
- Last updated: 2026-11-17 · claude/cloud-session

## Module map

| Feature | Entry route | Providers | Repository | Tests |
| --- | --- | --- | --- | --- |
| app shell | — (`lib/app/app.dart`) | themeModeProvider, localeProvider, routerProvider | — | test/app_smoke_test.dart |
| routing + role shells | all routes (`lib/app/routes.dart`, `router.dart`) | routerProvider, sessionProvider (stub) | — | test/app/router_test.dart |
| theme + tokens | — (`lib/app/theme/`) | — | — | test/app/theme_test.dart |
| l10n (EN/AR) | — (`lib/app/l10n/*.arb`, generated/) | localeProvider | — | test/core/formatting_and_motion_test.dart |
| settings state | — (`lib/app/state/`) | themeModeProvider, localeProvider, sharedPreferencesProvider | SharedPreferences | test/app/state_test.dart |
| shared widgets | — (`lib/core/widgets/`) | — | — | test/core/widgets/ (+ goldens/) |
| motion + formatting | — (`lib/core/motion.dart`, `formatting.dart`) | — | — | test/core/formatting_and_motion_test.dart |
| debug menu (TEMP) | — (`lib/app/debug/`) | all of the above | — | manual |

Later phases add one row per feature (auth, home, courses, assessments, certifications, competencies, checkout, admin, settings).

## Do-not-break contracts

Change only with a `BREAKING` log line.

Implemented:

- Route paths in `lib/app/routes.dart` (`AppRoutes`, `RouteAccess`) exactly as `docs/REQUIREMENTS.md` → Navigation and screens. Role homes: learner `/home`, supervisor `/queue`, admin `/cohort`. `/learn` and `/learn/:courseId` are learner + supervisor; lesson, checkout and receipt are learner-only; admin has no `/learn` (redirects to `/cohort`).
- Provider names `themeModeProvider`, `localeProvider`, `sessionProvider`, `routerProvider`, `sharedPreferencesProvider` (`sharedPreferencesProvider` must be overridden in `main.dart` and tests).
- Preference keys `PrefKeys.themeMode` / `PrefKeys.locale` (renaming loses users' saved settings).
- `AppColors` token names and values (match the prototype canvas); shared widget public APIs in `lib/core/widgets/`.
- `Motion` constant names in `lib/core/motion.dart`.

Coming in later phases:

- Repository interfaces in `lib/features/*/data/*_repository.dart`
- `ActivityEvent` fields and action names (audit hash chain and CSV export depend on them)
- Seed JSON schema in `lib/seed/`
- `PaymentGateway` interface and `PaymentResult` variants
- Money in integer fils; VAT = round(subtotal * 5 / 100)

## Decisions (newest first)

- 2026-11-17 · Material from `package:material_ui` (not `flutter/material.dart`, deprecated on Flutter 3.47+). `MaterialUiCompatibilityBridge` in `MaterialApp.builder` passes theme and localizations to packages still on `flutter/material` (fl_chart). Why: the template and SDK channel require it; types from the two libraries are not interchangeable.
- 2026-11-17 · Fonts (Inter, IBM Plex Sans Arabic, JetBrains Mono; OFL) bundled as pubspec font families in `assets/fonts/`; `google_fonts` not added. Why: offline and deterministic rendering (goldens), and google_fonts' `TextTheme` helpers use `flutter/material` types.
- 2026-11-17 · Goldens with plain `matchesGoldenFile` + a 4-variant helper (`test/helpers/golden.dart`), 0.5 % tolerance comparator; `alchemist`/`golden_toolkit` not added. Why: their APIs take `flutter/material` `ThemeData`. Goldens are generated on Linux (CI); run `--exclude-tags golden` on macOS if anti-aliasing differs.
- 2026-11-17 · The router is rebuilt when the role changes, with the active role's shell listed first. Why: `/learn` lives in both learner and supervisor shells and go_router matches the first route.
- 2026-11-17 · Negative title letter-spacing (-0.02em) for Latin only. Why: tracking breaks Arabic letter joins.
- 2026-11-17 · Numbers, money and dates use Western digits in both languages and are wrapped in LTR isolates (`ltr()`, `LtrText`). Why: matches the prototype and keeps numeric runs readable in RTL.
- 2026-11-17 · App/widget tests run with the platform reduce-motion flag on. Why: the ECG line and pulse loop forever, so `pumpAndSettle` would never finish; the app honours reduce motion everywhere, so behaviour is unchanged otherwise.
- 2026-11-17 · Kept the existing `clinical_edge` project and package name (created with the current Flutter template that uses `package:material_ui`). Why: avoid churn; the name is used in imports.
- 2026-11-17 · Removed web, linux, macos and windows targets. Why: v1 is iOS + Android only.
- 2026-11-17 · Bundle IDs `ae.clinicaledge.clinicalEdge` (iOS) and `ae.clinicaledge.clinical_edge` (Android); Android minSdk 26, iOS 15. Why: requirements NFR "Platforms".
- 2026-11-17 · Lints: `very_good_analysis` replaces `flutter_lints`. Why: stricter, matches requirements.
- 2026-11-17 · SDK pinned to Flutter 3.50.0 stable (Dart 3.14) locally and in CI. Why: reproducible builds; the template needs Dart ^3.14.

## Known issues / TODO

- [ ] `docs/design/` has no screenshots; Phase 1 was built from the prototype canvas itself (artifact "ClinicalEdge", `Main.dc.html`). Export the storyboard frames into `docs/design/` when convenient.
- [ ] Phase 1 not yet run on an iOS simulator / Android emulator (built in a cloud session with no devices). Run `flutter run` on both and `flutter test integration_test` (TC-PH1-51), then mark it Passing.
- [ ] TEMPORARY: `lib/app/debug/` debug menu and the `sessionProvider` stub (with `stubInitials`). Phase 3 replaces both with auth, the role switcher and Profile & settings.
- [ ] Remove `MaterialUiCompatibilityBridge` when fl_chart migrates to `material_ui`.
- [ ] Repo is on GitHub (`userproject02/clinical_edge`); enable branch protection with the CI checks required.

## Next up

Phase 2 — Core and seed: `Clock`/`SystemClock`, money helper (fils, VAT), `ActivityLogger` with mock audit (hash chain, `AuditChain.verify`) and usage stores, `CrashReporter`, seed JSON + loader (freezed models). Test cases TC-LOG-01, TC-PAY-1-01 (money), seed loading.

## Change log (newest first; last 30 entries, older in docs/changelog/)

- 2026-11-17 · claude/cloud-session · Phase 1: Material 3 theme from prototype tokens + `AppColors` extension, bundled fonts, `motion.dart`, EN/AR ARB + RTL, LTR-isolated formatting, go_router with 3 role shells and placeholder screens, persisted theme/locale providers, session stub, temporary debug menu, 16 shared widgets with 72 goldens, Android desugaring + iOS `ar` localization · lib/app, lib/core, test/, integration_test/, assets/fonts, pubspec, android/app, ios/Runner/Info.plist · scaffold and design system for every later phase
- 2026-11-17 · claude/gurus-macbook-air · CI pinned to Flutter 3.50.0 stable; removed one-off bootstrap script · .github/workflows/ci.yml, CLAUDE.md · match local SDK
- 2026-11-17 · claude/gurus-macbook-air · Phase 0: AGENTS.md, CLAUDE.md, subagents, TESTCASES.md, hooks, lefthook, CI, placeholder app, iOS/Android only · repo root, .claude/, tool/, .github/, docs/ · bootstrap context so any session can work safely

## Commands

`flutter pub get` · `flutter analyze` · `dart format .` · `flutter test` (macOS: `--exclude-tags golden`) · `flutter test --update-goldens --tags golden` · `dart run build_runner build -d` · `flutter gen-l10n` · `tool/ci/context_guard.sh worktree` · `lefthook install`
