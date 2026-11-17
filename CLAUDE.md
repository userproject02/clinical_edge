@AGENTS.md

# ClinicalEdge — project context

> Read this before every change. Update it in the same commit as every change.

## Product in one paragraph

Flutter mobile app (iOS + Android only) for UAE healthcare professionals to take courses and quizzes, track certifications and CPD/CME credits, and get competencies signed off by supervisors, with an admin view of cohort progress and an append-only audit log. v1 is a clickable prototype on mock local data; every data source sits behind an interface so Firebase and a UAE payment gateway can replace the mocks later. Requirements: `docs/REQUIREMENTS.md`. Build plan: 11 phases (0–10).

## Current status

- Phase: **Phase 7 done, next: Phase 8 Checkout**
- Done: 0 Repo and context · 1 Scaffold and design system · 2 Core and seed · 3 Auth, roles, settings · 4 Home and courses (dashboard, catalogue, course detail, lesson player, completion + CPD award) · 5 Assessments (Assess tab, quiz with instant feedback, result + quiz.score audit) · 6 Certifications and CPD (certs tab, CPD ring + ledger, upload sheet, expiry reminders) · 7 Competency sign-off (learner checklists, supervisor queue, review, decided)
- App code: sign-in, Profile & settings, home, catalogue, course detail, lesson player, Assess tab, quiz, Certs tab, upload sheet, sign-offs, queue, review and decided are real; checkout, receipt and admin screens are placeholders
- Last updated: 2026-11-17 · claude/gurus-macbook-air

## Module map

| Feature | Entry route | Providers | Repository | Tests |
| --- | --- | --- | --- | --- |
| app shell | — (`lib/app/app.dart`) | themeModeProvider, localeProvider, routerProvider | — | test/app_smoke_test.dart |
| routing + role shells | all routes (`lib/app/routes.dart`, `router.dart`, `screens/tab_scaffold.dart`) | routerProvider, sessionProvider, resumeLocationProvider, rootNavigatorContextProvider | — | test/app/router_test.dart |
| auth (UI) | `/sign-in` | sessionProvider, demoAccountsProvider, tenantProvider, firstHomeLoadProvider | AuthRepository | test/features/auth_settings_test.dart |
| settings | `/profile` | themeModeProvider, localeProvider, notificationsEnabledProvider, sessionProvider | SharedPreferences, AuthRepository | test/features/auth_settings_test.dart |
| theme + tokens | — (`lib/app/theme/`) | — | — | test/app/theme_test.dart |
| l10n (EN/AR) | — (`lib/app/l10n/*.arb`, generated/) | localeProvider | — | test/core/formatting_and_motion_test.dart |
| settings state | — (`lib/app/state/`) | themeModeProvider, localeProvider, sharedPreferencesProvider | SharedPreferences | test/app/state_test.dart |
| shared widgets | — (`lib/core/widgets/`) | — | — | test/core/widgets/ (+ goldens/) |
| motion + formatting | — (`lib/core/motion.dart`, `formatting.dart`) | — | — | test/core/formatting_and_motion_test.dart |
| debug menu (debug builds) | — (`lib/app/debug/`) | clockModeProvider, mockGatewayModeProvider, `resetDemoData` | — | manual |
| core: clock + money | — (`lib/core/clock.dart`, `money.dart`) | clockProvider, clockModeProvider | — | test/core/money_clock_test.dart |
| core: logging | — (`lib/core/logging/`) | activityLoggerProvider, auditStoreProvider, usageStoreProvider, crashReporterProvider, currentActorProvider | AuditStore, UsageStore | test/core/logging_test.dart |
| core: payments | — (`lib/core/payments/`) | paymentGatewayProvider, mockGatewayModeProvider | PaymentGateway (MockGateway) | test/core/payments_test.dart |
| core: persistence + seed | — (`lib/core/persistence/`, `lib/seed/`) | localDbProvider, seedLoaderProvider, demoSeederProvider | LocalDb (HiveLocalDb / InMemoryLocalDb) | test/core/hive_local_db_test.dart, test/seed/seed_test.dart |
| auth (data) | `/sign-in` (Phase 3 UI) | authRepositoryProvider | AuthRepository | test/features/repositories_test.dart |
| home | `/home` | learnerOverviewProvider, myCertificationsProvider, cpdConfigProvider, cpdLedgerProvider, quizHistoryProvider, checklistsProvider, mySignOffsProvider | Course/Progress/Certification/Cpd/Assessment/Competency | test/features/courses_test.dart |
| courses | `/learn`, `/learn/:courseId`, `/learn/:courseId/lesson/:n` | catalogueProvider, categoriesProvider, courseProgressListProvider, courseProgressProvider, completeLessonProvider, logCourseViewProvider, logLessonViewProvider | CourseRepository, ProgressRepository, CpdRepository | test/features/courses_test.dart |
| assessments | `/assess`, `/assess/:quizId/run` (root navigator, no bottom nav) | assessmentRepositoryProvider, quizCardsProvider, quizRunProvider(quizId), attemptIdFactoryProvider, quizHistoryProvider | AssessmentRepository (+ SubmitAttempt use case) | test/features/assessments_test.dart, test/features/repositories_test.dart, integration_test/assessments_test.dart |
| certifications | `/certs`, `/certs/upload` (root sheet) | certificationRepositoryProvider, cpdRepositoryProvider, certificateFilePickerProvider, myCertificationsProvider, cpdConfigProvider, cpdLedgerProvider, reminderServiceProvider, dueCertificateProvider, reminderSyncProvider, setRemindersEnabledProvider, simulateReminderProvider, uploadCertificateProvider | CertificationRepository, CpdRepository, CertificateFilePicker (+ UploadCertificate, ReminderService) | test/features/certifications_test.dart, integration_test/reminders_test.dart |
| core: local notifications | — (`lib/core/notifications/`) | localNotificationsProvider | LocalNotifier (PluginLocalNotifier in main.dart, RecordingLocalNotifier in tests) | test/features/certifications_test.dart |
| competencies | `/signoffs` (learner), `/queue`, `/queue/:requestId`, `/decided` (supervisor) | competencyRepositoryProvider, checklistsProvider, mySignOffsProvider, usersByIdProvider, signOffSupervisorProvider, checklistsByIdProvider, signOffQueueProvider, decidedSignOffsProvider, signOffRequestProvider, queueStatsProvider, requestSignOffProvider, decideSignOffProvider | CompetencyRepository (+ RequestSignOff, DecideSignOff) | test/features/competencies_test.dart, test/features/repositories_test.dart |
| checkout (data) | `/learn/:id/checkout` (Phase 8 UI) | checkoutRepositoryProvider | CheckoutRepository | test/features/repositories_test.dart |
| admin (data) | `/cohort` (Phase 9 UI) | cohortRepositoryProvider | CohortRepository | test/features/repositories_test.dart |
| mock wiring | — (`lib/app/mock_overrides.dart`) | every repository override, `resetDemoData` | all mocks | test/helpers/test_container.dart |

Later phases add one row per feature (auth, home, courses, assessments, certifications, competencies, checkout, admin, settings).

## Do-not-break contracts

Change only with a `BREAKING` log line.

Implemented:

- Route paths in `lib/app/routes.dart` (`AppRoutes`, `RouteAccess`) exactly as `docs/REQUIREMENTS.md` → Navigation and screens. Role homes: learner `/home`, supervisor `/queue`, admin `/cohort`. `/learn` and `/learn/:courseId` are learner + supervisor; lesson, checkout and receipt are learner-only; admin has no `/learn` (redirects to `/cohort`).
- Provider names `themeModeProvider`, `localeProvider`, `notificationsEnabledProvider`, `sessionProvider` (AsyncNotifier of `Session?` = AppUser + role; signIn / switchRole / signOut), `routerProvider`, `sharedPreferencesProvider` (overridden in `main.dart` and tests). `main.dart` awaits `sessionProvider.future` before the first frame.
- Preference keys `PrefKeys.themeMode` / `PrefKeys.locale` / `PrefKeys.notifications` (renaming loses users' saved settings).
- Role switch audit target: `"<From> → <To> (demo)"` with English role names; `kDemoRoleSwitcher` (`lib/app/feature_flags.dart`, `--dart-define=DEMO_ROLE_SWITCHER=false` turns it off).
- `AppColors` token names and values (match the prototype canvas); shared widget public APIs in `lib/core/widgets/`.
- `Motion` constant names in `lib/core/motion.dart`.

- Quiz audit target: `"<quiz title EN> · <score>% (pass|fail)"`, e.g. `BLS Assessment · 88% (pass)`. Score = `QuizRules.scorePct` (half up), pass ≥ 80. Quiz ids `bls` (8 questions) and `ipc` (7, unlocks when c2 is complete).
- `LocalNotifier` (requestPermission, showNow, replaceSchedule) and `CertificateFilePicker` (pick → name + size only); Android channel id `expiry_reminders`. Cert upload audit target `"<name> · pending verification"`; reminder usage target `"<code> · <days> days"`. Reminders fire at 09:00 Dubai on 90/60/30/7 days before expiry for verified certificates.
- Sign-off audit targets: request = checklist name (EN); decision = `"<checklist> · <learner> · approved|rejected"` (never the comment). Default approval comment "Competent. Observed and signed off." stored in EN and AR.
- Repository interfaces in `lib/features/*/data/*_repository.dart`: AuthRepository, CourseRepository, ProgressRepository, AssessmentRepository, CertificationRepository, CpdRepository, CompetencyRepository, CheckoutRepository, CohortRepository.
- `ActivityEvent` fields: id, ts (UTC), userId, role, action, target, platform (`ios`/`android`), kind (`audit`/`usage`), prevHash, hash (audit only). Action wire names: `AuditAction` (role.change, quiz.score, signoff.request, signoff.decision, purchase, cert.upload, course.complete, audit.export) and `UsageAction` (auth.signin, auth.signout, course.view, lesson.view, lesson.complete, checkout.start, notify.reminder).
- Audit hash: `SHA-256(prevHash|ts|userId|role|action|target|platform)` lower hex; ts = ISO-8601 UTC (`toIso8601String`), role = enum name; first prevHash = 64 zeros. `AuditStore` exposes append + list only. Targets pass `TargetSanitizer` (≤ 120 chars; no card numbers, CVC, emails, passwords).
- Seed JSON schema in `lib/seed/*.json` (`SeedFile` enum) and `DemoSeeder.seedVersion` (bump it when seed contents change so installed demos re-seed). Every user-facing seed string is `{en, ar}`.
- `LocalDb` collection names (`Collections`) and key formats (`userId|courseId`, `userId|lessonId`, zero-padded audit/usage sequence).
- `PaymentGateway` (createIntent, confirm), `PaymentMethod` (CardMethod, ApplePayMethod — tokens only), `PaymentResult` (PaymentSucceeded, PaymentFailed, PaymentNeeds3ds), `Order` fields.
- Money in integer fils (`Money`); VAT = round(subtotal × 5 / 100) half up, integer maths (`vatOf`). Invoice numbers `CE-YYYY-000000` from a persisted sequence starting at 1041.
- Demo clock: `FixedClock(demoNow)` = 2026-11-17 09:00 Asia/Dubai; calendar maths in Dubai time (UTC+4). Cert status: ≤ 0 days expired, ≤ 90 renew soon, else valid; pending verification → verifying.

## Decisions (newest first)

- 2026-11-18 · Queue stats are computed: pending = queue size, this month = requests received this calendar month (Dubai), turnaround = mean request→decision time over decided requests (seed gives 1.7d, the brief's mock showed 1.4d). Why: no hard-coded numbers in UI.
- 2026-11-18 · `MockCompetencyRepository.decide` keeps each `decidedAt` strictly after the latest decision. Why: under the fixed demo clock, "newest first" on Decided would tie.
- 2026-11-18 · `DecideSignOff` enforces "only a supervisor decides, never their own request" in the domain, not just the router. Why: permission rules in REQUIREMENTS.
- 2026-11-18 · `/queue` is the supervisor's home (greeting title + first-load skeleton like Home). Why: matches role-home behaviour from Phase 3; TC-PH1-43 now checks the queue list instead of the placeholder text.
- 2026-11-18 · Learner checklist items show as self-assessed (static ok checks); comments render in a start-bar quote card without quotation marks. Why: brief ("no curly quotes in Arabic").

- 2026-11-17 · One switch (`notificationsEnabledProvider`, pref key unchanged) drives Profile and the Certs reminders card through `setRemindersEnabledProvider`, which asks OS permission on enable; `reminderSyncProvider` (watched by every tab scaffold) replaces the device schedule whenever the switch, certificates or language change. Why: CERT-4 "shares state"; one source of truth.
- 2026-11-17 · Home expiry alert, bell and simulate use `ReminderService` (`due` / `simulated`). Why: brief says Home reads from the same service.
- 2026-11-17 · Device services (`LocalNotifier`, `CertificateFilePicker`) are passed to `mockOverrides` (real plugins from `main.dart`, recording/mock fakes by default). Why: plugins don't run in widget tests; keeps widgets off platform APIs.
- 2026-11-17 · File picker on an iOS simulator (env `SIMULATOR_UDID`) or on picker failure returns the mock "NRP_certificate.pdf · 412 KB"; only name and size are read and the stored fileRef is `demo-upload-<uuid>`. Why: brief + privacy rules.
- 2026-11-17 · Upload FAB uses a soft brand shadow instead of Material elevation. Why: the elevation shadow rendered as a hard black ring in goldens.
- 2026-11-17 · CPD note text moved to config (`cpd.json` targetNote) with the brief's wording; `DemoSeeder.seedVersion` → 4. Why: target and note are config, not UI.

- 2026-11-17 · `SubmitAttempt` stamps a new attempt at least 1 s after the user's latest one. Why: under the fixed demo clock every attempt would share one instant and "newest first" / "Attempt N" would be ambiguous.
- 2026-11-17 · Quiz route sits on the root navigator (path unchanged `/assess/:quizId/run`). Why: the brief says no bottom nav during a quiz; TC-PH1-46 now checks tab state with `/learn/c1`.
- 2026-11-17 · Kept `drawQuiz(quizId)` (the brief says `drawQuiz(topic, 8)`); the quiz's `topicOrder` and `size` drive the draw. Why: no breaking change; IPC quiz is topic `infection_control`, 7 questions (the bank has 7).
- 2026-11-17 · Quiz `subject` field ({en, ar}) and IPC quiz added to `question_bank.json`; `DemoSeeder.seedVersion` → 3. Why: card title "Basic Life Support" differs from the quiz title used in the audit target.
- 2026-11-17 · Leave confirmation only when at least one answer is locked and no result yet. Why: nothing to lose before the first answer or after saving.

- 2026-11-17 · Progress is derived, never stored twice: `courseProgressListProvider` combines catalogue + ownership + lesson progress; `completeLessonProvider` invalidates `lessonProgressProvider` and `cpdLedgerProvider`, so home, carousel, catalogue, detail and CPD update together. Why: CRS-3 "updates everywhere".
- 2026-11-17 · `MarkLessonComplete` awards credits only on the transition to all-done (ledger id `cpd-course-<course>-<user>`), so re-completing cannot double count. Why: CRS-4.
- 2026-11-17 · Opening a course always uses `go` (Learn tab) even from Home. Why: the course routes live in the Learn branch; back returns to `/learn`.
- 2026-11-17 · Seed additions: course `blurb` ({en, ar}) and certificate `code` ("BLS"); `DemoSeeder.seedVersion` → 2. Why: course header copy and the "BLS expires in 56 days" alert.
- 2026-11-17 · Test helper `settle()` alternates real-time ticks with frames. Why: some repository futures complete only on a real event-loop turn, which pumpAndSettle never gives while a spinner animates.

- 2026-11-17 · `sessionProvider` is now an AsyncNotifier over `AuthRepository` (stub removed). Why: Phase 3 brief; the session persists via the repository. BREAKING for callers of the Phase 1 stub (fixed in the same commit).
- 2026-11-17 · Switching role on Profile sets `resumeLocationProvider` so the rebuilt router lands back on `/profile`; Profile's back falls back to the role home when there is nothing to pop. Why: the router is rebuilt per role (Phase 1 decision) and the brief says stay on Profile.
- 2026-11-17 · Theme picker on Profile is Light/Dark only (per prototype); the stored mode defaults to System until the user picks one. Why: matches the design; System stays the first-run default.
- 2026-11-17 · `AssetSeedLoader` reads assets with `cache: false` and caches per loader. Why: rootBundle's global cache shared one pending load across ProviderContainers/test zones and hung the next test.
- 2026-11-17 · Debug menu keeps only clock, mock payment outcome, reset and route jumps; theme, language and role moved to Profile & settings. Why: avoid two places for the same setting.

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
- [ ] Device runs deferred: Android for Phases 1–7 and iOS for Phases 6–7 (`integration_test/reminders_test.dart` needs the notification permission granted, then confirm the banner and a real notification on each). An Android AVD `ce_pixel` (API 36, arm64) now exists on the MacBook.
- [ ] Phase 5–7 goldens (`test/features/goldens/{assess,quiz_*,result_*,certs_*,upload_sheet_*,signoffs_*,queue*,review_*,decided_*}`) were generated on macOS; regenerate on Linux (`flutter test --update-goldens --tags golden`) so CI matches.
- [ ] Arabic numeric ranges in seed options render reversed in RTL ("80–60"); see `docs/TESTCASES.md` → Review notes.
- [ ] Clinical and native-Arabic review of all seed content (see `docs/TESTCASES.md` → Review notes).
- [ ] `HiveLocalDb` stores everything in plain JSON on device; fine for demo data, revisit (encryption) if real data ever lands.
- [ ] Remove `MaterialUiCompatibilityBridge` when fl_chart migrates to `material_ui`.
- [ ] Repo is on GitHub (`userproject02/clinical_edge`); enable branch protection with the CI checks required.

## Next up

Phase 8 — Checkout: `/learn/:courseId/checkout` with order summary, card (Luhn, expiry, CVC; never stored or logged) and mock Apple Pay, PurchaseCourse use case via PaymentGateway (success, failure, 3-D Secure), receipt with sequential invoice number, Share PDF and Start course (PAY-1, PAY-2). Test cases TC-PAY-*.

## Change log (newest first; last 30 entries, older in docs/changelog/)

- 2026-11-18 · claude/gurus-macbook-air · Phase 7: learner Sign-offs tab (checklist cards, self-assessed items, request footer with supervisor note, pending spinner, decided line + comment quote), supervisor Queue (stats, oldest-first cards, animated empty state, tab badge), Review (learner + checklist cards, comment field, lock note, Reject/Approve with required reject comment and default approval comment), Decided list; RequestSignOff / DecideSignOff use cases with signoff.request / signoff.decision audit; queue is the supervisor home · lib/features/competencies, lib/app/router.dart, lib/app/l10n, test/features/competencies_test.dart, test/app/router_test.dart · COMP-1..2

- 2026-11-17 · claude/gurus-macbook-air · Phase 6: Certs tab (CPD ring with credits over target from config, reminders card with shared switch, dashed simulate button, certifications with status / expiry / days / 730-day meter, CPD ledger newest first, extended Upload FAB), upload sheet (dashed drop zone with floating icon, mock-file fallback, name + issued/expires date pickers, validation, Verifying + cert.upload audit, snackbar), ReminderService (90/60/30/7-day schedule at 09:00 Dubai, due certificate for Home/bell/simulate), LocalNotifier on flutter_local_notifications (Android channel "Expiry reminders", iOS foreground delegate), bell wired, timezone package, DashedBorder widget, 8 goldens · lib/features/certifications, lib/core/notifications, lib/core/widgets/dashed_border.dart, lib/app (router, tab scaffold, mock overrides, l10n), lib/main.dart, lib/features/home, lib/features/settings, android manifest, ios AppDelegate, lib/seed/cpd.json, test/features/certifications_test.dart, integration_test/reminders_test.dart · CERT-1..4 · BREAKING: `mockOverrides` gains optional `notifier` and `filePicker`; `localNotificationsProvider` and `certificateFilePickerProvider` must be overridden (mockOverrides does it); Profile's switch now goes through `setRemindersEnabledProvider`

- 2026-11-17 · claude/gurus-macbook-air · Phase 5: Assess tab (BLS card with pass mark / best / attempts, score history newest first with meter + tag, IPC card locked until c2 complete), quiz on the root navigator (question N of 8, pass tag, 8-segment bar, A–D / أ–د badges, first tap locks, check draw / shake, explanation card, sticky Next → See results, leave confirmation), result (animated ring, n / 8 correct, Passed / Below pass mark, audit row, Done / Retake), SubmitAttempt use case (score, attempt, quiz.score audit), quizCardsProvider + quizRunProvider, 24 goldens, device journey; Phase 1 device test fixed for real-time pumping · lib/features/assessments, lib/app/router.dart, lib/app/l10n, lib/seed/question_bank.json, test/features/assessments_test.dart, integration_test/ · QZ-1..3 · BREAKING: `Quiz.subject` is a new required field (seed updated) and `AssessmentRepository` gains `quizzes()` and `bankSize()` (MockAssessmentRepository updated; other implementations must add them)

- 2026-11-17 · claude/cloud-session · Phase 4: learner home (hero ring + resume, expiry alert, CPD meter, continue-learning carousel, recent-scores chart with pass line, sign-off status), catalogue (search, category chips, owned/unowned cards), course detail (coloured header, progress, lesson states, sticky CTA incl. Buy with VAT → checkout), lesson player (video/PDF/reading placeholders, up-next outline, previous/mark complete), MarkLessonComplete use case (lesson.complete, course.complete audit, CPD award), course.view/lesson.view usage · lib/features/home, lib/features/courses, lib/app/router.dart, lib/seed (blurb, code), test/features/courses_test.dart · HOME-1, CRS-1..4

- 2026-11-17 · claude/cloud-session · Phase 3: sign-in screen (hero, ECG, language toggle, validation, demo role picker), AsyncNotifier session persisted via AuthRepository, use cases SignIn/SwitchRole/SignOut with auth.signin, role.change (audit) and auth.signout, Profile & settings (role, language, theme, notifications, under-the-hood, sign out, version), real tab app bar (greeting by clock, first name, avatar), 900 ms first-home skeleton, kDemoRoleSwitcher flag, trimmed debug menu · lib/features/auth/presentation, lib/features/settings, lib/app (router, screens, state), test/features/auth_settings_test.dart · AUTH-1..3, SET-1 · BREAKING: `sessionProvider` is now `AsyncValue<Session?>` (user + role) with async signIn/switchRole/signOut; `redirectFor` takes `Session?` — all callers updated

- 2026-11-17 · claude/cloud-session · Phase 2: Clock (FixedClock demo default), Money/VAT in fils, ActivityLogger + append-only hash-chained AuditStore + UsageStore + TargetSanitizer + CrashReporter, PaymentGateway + MockGateway (debug outcomes), LocalDb on Hive CE + DemoSeeder + reset, 9 repository interfaces with mocks and providers, bilingual seed (users, courses, 20-question bank, certs, CPD, checklists, sign-offs, cohort, audit seed), debug menu clock/gateway/reset · lib/core, lib/features/*/data+domain, lib/seed, lib/app/mock_overrides.dart, main.dart, test/ · core services and demo data for every feature phase

- 2026-11-17 · claude/cloud-session · Phase 1: Material 3 theme from prototype tokens + `AppColors` extension, bundled fonts, `motion.dart`, EN/AR ARB + RTL, LTR-isolated formatting, go_router with 3 role shells and placeholder screens, persisted theme/locale providers, session stub, temporary debug menu, 16 shared widgets with 72 goldens, Android desugaring + iOS `ar` localization · lib/app, lib/core, test/, integration_test/, assets/fonts, pubspec, android/app, ios/Runner/Info.plist · scaffold and design system for every later phase
- 2026-11-17 · claude/gurus-macbook-air · CI pinned to Flutter 3.50.0 stable; removed one-off bootstrap script · .github/workflows/ci.yml, CLAUDE.md · match local SDK
- 2026-11-17 · claude/gurus-macbook-air · Phase 0: AGENTS.md, CLAUDE.md, subagents, TESTCASES.md, hooks, lefthook, CI, placeholder app, iOS/Android only · repo root, .claude/, tool/, .github/, docs/ · bootstrap context so any session can work safely

## Commands

`flutter pub get` · `flutter analyze` · `dart format .` · `flutter test` (macOS: `--exclude-tags golden`) · `flutter test --update-goldens --tags golden` · `dart run build_runner build` · `flutter gen-l10n` · `tool/ci/context_guard.sh worktree` · `lefthook install`
