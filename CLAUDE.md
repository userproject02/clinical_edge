@AGENTS.md

# ClinicalEdge — project context

> Read this before every change. Update it in the same commit as every change.

## Product in one paragraph

Flutter mobile app (iOS + Android only) for UAE healthcare professionals to take courses and quizzes, track certifications and CPD/CME credits, and get competencies signed off by supervisors, with an admin view of cohort progress and an append-only audit log. v1 is a clickable prototype on mock local data; every data source sits behind an interface so Firebase and a UAE payment gateway can replace the mocks later. Requirements: `docs/REQUIREMENTS.md`. Build plan: 11 phases (0–10).

## Current status

- Phase: **Phase 2 done, next: Phase 3 Auth, roles, settings**
- Done: 0 Repo and context · 1 Scaffold and design system · 2 Core and seed (Clock, Money, ActivityLogger + hash-chained AuditStore, PaymentGateway + MockGateway, Hive persistence + reset, 9 repositories with mocks, bilingual seed)
- App code: every route is still a placeholder; repositories are wired but no screen reads them yet
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
| debug menu (TEMP) | — (`lib/app/debug/`) | all of the above + clockModeProvider, mockGatewayModeProvider | — | manual |
| core: clock + money | — (`lib/core/clock.dart`, `money.dart`) | clockProvider, clockModeProvider | — | test/core/money_clock_test.dart |
| core: logging | — (`lib/core/logging/`) | activityLoggerProvider, auditStoreProvider, usageStoreProvider, crashReporterProvider, currentActorProvider | AuditStore, UsageStore | test/core/logging_test.dart |
| core: payments | — (`lib/core/payments/`) | paymentGatewayProvider, mockGatewayModeProvider | PaymentGateway (MockGateway) | test/core/payments_test.dart |
| core: persistence + seed | — (`lib/core/persistence/`, `lib/seed/`) | localDbProvider, seedLoaderProvider, demoSeederProvider | LocalDb (HiveLocalDb / InMemoryLocalDb) | test/core/hive_local_db_test.dart, test/seed/seed_test.dart |
| auth (data) | `/sign-in` (Phase 3 UI) | authRepositoryProvider | AuthRepository | test/features/repositories_test.dart |
| courses (data) | `/learn` (Phase 4 UI) | courseRepositoryProvider, progressRepositoryProvider | CourseRepository, ProgressRepository | test/features/repositories_test.dart |
| assessments (data) | `/assess` (Phase 5 UI) | assessmentRepositoryProvider | AssessmentRepository | test/features/repositories_test.dart |
| certifications (data) | `/certs` (Phase 6 UI) | certificationRepositoryProvider, cpdRepositoryProvider | CertificationRepository, CpdRepository | test/features/repositories_test.dart |
| competencies (data) | `/signoffs`, `/queue` (Phase 7 UI) | competencyRepositoryProvider | CompetencyRepository | test/features/repositories_test.dart |
| checkout (data) | `/learn/:id/checkout` (Phase 8 UI) | checkoutRepositoryProvider | CheckoutRepository | test/features/repositories_test.dart |
| admin (data) | `/cohort` (Phase 9 UI) | cohortRepositoryProvider | CohortRepository | test/features/repositories_test.dart |
| mock wiring | — (`lib/app/mock_overrides.dart`) | every repository override, `resetDemoData` | all mocks | test/helpers/test_container.dart |

Later phases add one row per feature (auth, home, courses, assessments, certifications, competencies, checkout, admin, settings).

## Do-not-break contracts

Change only with a `BREAKING` log line.

Implemented:

- Route paths in `lib/app/routes.dart` (`AppRoutes`, `RouteAccess`) exactly as `docs/REQUIREMENTS.md` → Navigation and screens. Role homes: learner `/home`, supervisor `/queue`, admin `/cohort`. `/learn` and `/learn/:courseId` are learner + supervisor; lesson, checkout and receipt are learner-only; admin has no `/learn` (redirects to `/cohort`).
- Provider names `themeModeProvider`, `localeProvider`, `sessionProvider`, `routerProvider`, `sharedPreferencesProvider` (`sharedPreferencesProvider` must be overridden in `main.dart` and tests).
- Preference keys `PrefKeys.themeMode` / `PrefKeys.locale` (renaming loses users' saved settings).
- `AppColors` token names and values (match the prototype canvas); shared widget public APIs in `lib/core/widgets/`.
- `Motion` constant names in `lib/core/motion.dart`.

- Repository interfaces in `lib/features/*/data/*_repository.dart`: AuthRepository, CourseRepository, ProgressRepository, AssessmentRepository, CertificationRepository, CpdRepository, CompetencyRepository, CheckoutRepository, CohortRepository.
- `ActivityEvent` fields: id, ts (UTC), userId, role, action, target, platform (`ios`/`android`), kind (`audit`/`usage`), prevHash, hash (audit only). Action wire names: `AuditAction` (role.change, quiz.score, signoff.request, signoff.decision, purchase, cert.upload, course.complete, audit.export) and `UsageAction` (auth.signin, auth.signout, course.view, lesson.view, lesson.complete, checkout.start, notify.reminder).
- Audit hash: `SHA-256(prevHash|ts|userId|role|action|target|platform)` lower hex; ts = ISO-8601 UTC (`toIso8601String`), role = enum name; first prevHash = 64 zeros. `AuditStore` exposes append + list only. Targets pass `TargetSanitizer` (≤ 120 chars; no card numbers, CVC, emails, passwords).
- Seed JSON schema in `lib/seed/*.json` (`SeedFile` enum) and `DemoSeeder.seedVersion` (bump it when seed contents change so installed demos re-seed). Every user-facing seed string is `{en, ar}`.
- `LocalDb` collection names (`Collections`) and key formats (`userId|courseId`, `userId|lessonId`, zero-padded audit/usage sequence).
- `PaymentGateway` (createIntent, confirm), `PaymentMethod` (CardMethod, ApplePayMethod — tokens only), `PaymentResult` (PaymentSucceeded, PaymentFailed, PaymentNeeds3ds), `Order` fields.
- Money in integer fils (`Money`); VAT = round(subtotal × 5 / 100) half up, integer maths (`vatOf`). Invoice numbers `CE-YYYY-000000` from a persisted sequence starting at 1041.
- Demo clock: `FixedClock(demoNow)` = 2026-11-17 09:00 Asia/Dubai; calendar maths in Dubai time (UTC+4). Cert status: ≤ 0 days expired, ≤ 90 renew soon, else valid; pending verification → verifying.

## Decisions (newest first)

- 2026-11-17 · Persistence on `hive_ce` with JSON strings in `Box<String>` behind a `LocalDb` interface (InMemoryLocalDb in tests). Why: no type adapters to maintain; the seed JSON schema stays the single contract.
- 2026-11-17 · Static seed data (catalogue, question bank, checklists, cohort, CPD target) is read from `lib/seed` each time; only mutable state (session, ownership, progress, attempts, certifications, CPD ledger, sign-offs, orders, audit, usage) is copied into `LocalDb` by `DemoSeeder`. Why: a seed fix ships with the app; reset only needs to rewrite mutable state.
- 2026-11-17 · Default clock is `FixedClock` at 2026-11-17 09:00 Dubai, switchable to `SystemClock` from the debug menu (persisted). Why: the demo's expiries and "days left" always read the same.
- 2026-11-17 · Repository providers throw unless overridden; `mockOverrides()` is the single wiring list for `main.dart` and tests. Why: a missing override fails loudly instead of silently using a mock in production.
- 2026-11-17 · The audit store, not the logger, computes `prevHash`/`hash` and serialises appends. Why: one place guarantees the chain, including for historical seed events.
- 2026-11-17 · Lesson type `reading` (not `text` as in the REQUIREMENTS domain table). Why: the Phase 2 brief and the UI copy say "Reading".
- 2026-11-17 · Quiz draw is deterministic (quiz `topicOrder`, bank order) and the BLS quiz is the 8 resuscitation questions. Why: stable demo, per the brief.
- 2026-11-17 · `Order` lives in `lib/core/payments` (not the checkout feature). Why: `PaymentGateway.createIntent(Order)` is core and core must not import features.
- 2026-11-17 · Seed learners get demo completion figures in `cohort.json` (Layla 55 %, Aisha 82 %, Mariam 64 %, Yousef 47 %, Priya 71 %) for the ADM-1 learner list. Why: the brief gave aggregates only; the values are labelled demo figures.
- 2026-11-17 · Logger actor comes from the Phase 1 session stub (`currentActorProvider` override maps role → seed user). Why: Phase 3 replaces it with the auth user without touching the logger.

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
- [ ] TEMPORARY: `lib/app/debug/` debug menu and the `sessionProvider` stub (with `stubInitials`). Phase 3 replaces both with auth (AuthRepository is ready), the role switcher and Profile & settings; then point `currentActorProvider` at the auth user.
- [ ] Clinical and native-Arabic review of all seed content (see `docs/TESTCASES.md` → Review notes).
- [ ] `HiveLocalDb` stores everything in plain JSON on device; fine for demo data, revisit (encryption) if real data ever lands.
- [ ] Remove `MaterialUiCompatibilityBridge` when fl_chart migrates to `material_ui`.
- [ ] Repo is on GitHub (`userproject02/clinical_edge`); enable branch protection with the CI checks required.

## Next up

Phase 3 — Auth, roles, settings: sign-in screen with role picker on `AuthRepository` (AUTH-1), audit-logged role switch (AUTH-2), sign-out (AUTH-3), Profile & settings with language/theme/notifications (SET-1); replace the session stub and debug menu; logger actor from the auth user. Test cases TC-AUTH-*, TC-SET-1-01.

## Change log (newest first; last 30 entries, older in docs/changelog/)

- 2026-11-17 · claude/cloud-session · Phase 2: Clock (FixedClock demo default), Money/VAT in fils, ActivityLogger + append-only hash-chained AuditStore + UsageStore + TargetSanitizer + CrashReporter, PaymentGateway + MockGateway (debug outcomes), LocalDb on Hive CE + DemoSeeder + reset, 9 repository interfaces with mocks and providers, bilingual seed (users, courses, 20-question bank, certs, CPD, checklists, sign-offs, cohort, audit seed), debug menu clock/gateway/reset · lib/core, lib/features/*/data+domain, lib/seed, lib/app/mock_overrides.dart, main.dart, test/ · core services and demo data for every feature phase

- 2026-11-17 · claude/cloud-session · Phase 1: Material 3 theme from prototype tokens + `AppColors` extension, bundled fonts, `motion.dart`, EN/AR ARB + RTL, LTR-isolated formatting, go_router with 3 role shells and placeholder screens, persisted theme/locale providers, session stub, temporary debug menu, 16 shared widgets with 72 goldens, Android desugaring + iOS `ar` localization · lib/app, lib/core, test/, integration_test/, assets/fonts, pubspec, android/app, ios/Runner/Info.plist · scaffold and design system for every later phase
- 2026-11-17 · claude/gurus-macbook-air · CI pinned to Flutter 3.50.0 stable; removed one-off bootstrap script · .github/workflows/ci.yml, CLAUDE.md · match local SDK
- 2026-11-17 · claude/gurus-macbook-air · Phase 0: AGENTS.md, CLAUDE.md, subagents, TESTCASES.md, hooks, lefthook, CI, placeholder app, iOS/Android only · repo root, .claude/, tool/, .github/, docs/ · bootstrap context so any session can work safely

## Commands

`flutter pub get` · `flutter analyze` · `dart format .` · `flutter test` (macOS: `--exclude-tags golden`) · `flutter test --update-goldens --tags golden` · `dart run build_runner build` · `flutter gen-l10n` · `tool/ci/context_guard.sh worktree` · `lefthook install`
