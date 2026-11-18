@AGENTS.md

# ClinicalEdge — project context

> Read this before every change. Update it in the same commit as every change.

## Product in one paragraph

Flutter mobile app (iOS + Android; a web build exists only as a phone-sized preview) for UAE healthcare professionals to take courses and quizzes, track certifications and CPD/CME credits, and get competencies signed off by supervisors, with an admin view of cohort progress and an append-only audit log. v1 is a clickable prototype on mock local data; every data source sits behind an interface so Firebase and a UAE payment gateway can replace the mocks later. Requirements: `docs/REQUIREMENTS.md`. Build plan: 11 phases (0–10).

## Current status

- Phase: **v1 prototype complete** (v0.1.0+1, Phase 10 done). Next: production work (see Next up)
- Done: 0 Repo and context · 1 Scaffold and design system · 2 Core and seed · 3 Auth, roles, settings · 4 Home and courses (dashboard, catalogue, course detail, lesson player, completion + CPD award) · 5 Assessments (Assess tab, quiz with instant feedback, result + quiz.score audit) · 6 Certifications and CPD (certs tab, CPD ring + ledger, upload sheet, expiry reminders) · 7 Competency sign-off (learner checklists, supervisor queue, review, decided) · 8 Checkout (order summary, card + mock Apple Pay, PurchaseCourse, receipt + PDF) · 9 Admin (cohort dashboard, audit log + CSV export, usage insights) · 10 Polish and release (a11y + privacy tests, tablet reflow, mock latency, E2E journey, README, icon + splash, builds)
- App code: sign-in, Profile & settings, Help & user guide, bell notifications sheet, home, catalogue, course detail, lesson player, Assess tab, quiz, Certs tab, upload sheet, sign-offs, queue, review and decided, checkout, receipt, cohort, audit log and insights are real; no placeholder screens remain
- Since v1: web preview (Safari; public Cloud Run demo), bell → notifications sheet, `/help` per-role guide, gap-free tablet columns, Home score-chart fix, no ECG animation on the sign-in/Home heroes
- Last updated: 2026-11-18 · claude/gurus-macbook-air

## Module map

| Feature | Entry route | Providers | Repository | Tests |
| --- | --- | --- | --- | --- |
| app shell | — (`lib/app/app.dart`) | themeModeProvider, localeProvider, routerProvider | — | test/app_smoke_test.dart |
| routing + role shells | all routes (`lib/app/routes.dart`, `router.dart`, `screens/tab_scaffold.dart`) | routerProvider, sessionProvider, resumeLocationProvider, rootNavigatorContextProvider | — | test/app/router_test.dart |
| auth (UI) | `/sign-in` | sessionProvider, demoAccountsProvider, tenantProvider, firstHomeLoadProvider | AuthRepository | test/features/auth_settings_test.dart |
| settings | `/profile` | themeModeProvider, localeProvider, notificationsEnabledProvider, sessionProvider | SharedPreferences, AuthRepository | test/features/auth_settings_test.dart |
| help (user guide) | `/help` (root push from Profile, all roles; `lib/features/settings/presentation/help_screen.dart`) | sessionProvider (+ `helpTopicsFor(l, role)`) | — (ARB strings only) | test/features/help_test.dart |
| notifications (bell) | bell → `showInbox` sheet, no route (`lib/features/notifications/`) | inboxProvider, inboxSeenProvider (keepAlive, in memory), inboxUnreadProvider | none; derived from myCertificationsProvider, mySignOffsProvider, signOffQueueProvider, cohortLearnersProvider | test/features/notifications_test.dart, test/features/certifications_test.dart |
| web preview | — (`lib/app/web_frame.dart` `WebFrame`, `web/`, `tool/web/`, `tool/deploy_web_gcp.sh`) | — | — | test/app/web_frame_test.dart |
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
| home | `/home` | learnerOverviewProvider, myCertificationsProvider, cpdConfigProvider, cpdLedgerProvider, quizHistoryProvider, checklistsProvider, mySignOffsProvider | Course/Progress/Certification/Cpd/Assessment/Competency | test/features/courses_test.dart, test/features/assessments_test.dart (scores chart) |
| courses | `/learn`, `/learn/:courseId`, `/learn/:courseId/lesson/:n` | catalogueProvider, categoriesProvider, courseProgressListProvider, courseProgressProvider, completeLessonProvider, logCourseViewProvider, logLessonViewProvider | CourseRepository, ProgressRepository, CpdRepository | test/features/courses_test.dart |
| assessments | `/assess`, `/assess/:quizId/run` (root navigator, no bottom nav) | assessmentRepositoryProvider, quizCardsProvider, quizRunProvider(quizId), attemptIdFactoryProvider, quizHistoryProvider | AssessmentRepository (+ SubmitAttempt use case) | test/features/assessments_test.dart, test/features/repositories_test.dart, integration_test/assessments_test.dart |
| certifications | `/certs`, `/certs/upload` (root sheet) | certificationRepositoryProvider, cpdRepositoryProvider, certificateFilePickerProvider, myCertificationsProvider, cpdConfigProvider, cpdLedgerProvider, reminderServiceProvider, dueCertificateProvider, reminderSyncProvider, setRemindersEnabledProvider, simulateReminderProvider, uploadCertificateProvider | CertificationRepository, CpdRepository, CertificateFilePicker (+ UploadCertificate, ReminderService) | test/features/certifications_test.dart, integration_test/reminders_test.dart |
| core: local notifications | — (`lib/core/notifications/`) | localNotificationsProvider | LocalNotifier (PluginLocalNotifier in main.dart except on web, RecordingLocalNotifier in tests) | test/features/certifications_test.dart |
| competencies | `/signoffs` (learner), `/queue`, `/queue/:requestId`, `/decided` (supervisor) | competencyRepositoryProvider, checklistsProvider, mySignOffsProvider, usersByIdProvider, signOffSupervisorProvider, checklistsByIdProvider, signOffQueueProvider, decidedSignOffsProvider, signOffRequestProvider, queueStatsProvider, requestSignOffProvider, decideSignOffProvider | CompetencyRepository (+ RequestSignOff, DecideSignOff) | test/features/competencies_test.dart, test/features/repositories_test.dart |
| checkout | `/learn/:courseId/checkout`, `/learn/:courseId/receipt/:orderId` | checkoutRepositoryProvider, paymentGatewayProvider, mockGatewayModeProvider, sellerProvider, orderProvider, logCheckoutStartProvider, purchaseCourseProvider, complete3dsProvider | CheckoutRepository, PaymentGateway (+ PurchaseCourse, CardRules) | test/features/checkout_test.dart, test/features/repositories_test.dart |
| admin | `/cohort` (admin home), `/audit`, `/insights` | cohortRepositoryProvider, cohortStatsProvider, cohortLearnersProvider, auditEventsProvider, usageEventsProvider, chainResultProvider, auditFilterStateProvider, filteredEventsProvider, auditFilterOptionsProvider, exportAuditCsvProvider, insightsProvider | CohortRepository, AuditStore, UsageStore (+ AuditFilter, auditCsv, InsightsView) | test/features/admin_test.dart |
| core: file sharing | — (`lib/core/sharing/`) | fileSharerProvider | FileSharer (PluginFileSharer in main.dart, RecordingFileSharer in tests) | test/features/admin_test.dart |
| mock wiring | — (`lib/app/mock_overrides.dart`) | every repository override, `resetDemoData`; device services (notifier, file picker, file sharer; web keeps the mock notifier + picker) | all mocks; `LatencyLocalDb` (300–900 ms on list queries, `main.dart` only) | test/helpers/test_container.dart |
| a11y + privacy | — | — | — | test/a11y_test.dart, test/privacy_test.dart |
| end-to-end | — | — | — | integration_test/demo_journey_test.dart (TC-E2E-01), assessments, reminders, scaffold |

Later phases add one row per feature (auth, home, courses, assessments, certifications, competencies, checkout, admin, settings).

## Do-not-break contracts

Change only with a `BREAKING` log line.

Implemented:

- Route paths in `lib/app/routes.dart` (`AppRoutes`, `RouteAccess`) exactly as `docs/REQUIREMENTS.md` → Navigation and screens, plus `/help` (`AppRoutes.help`, root push from Profile, allowed for every role like `/profile`). Role homes: learner `/home`, supervisor `/queue`, admin `/cohort`. `/learn` and `/learn/:courseId` are learner + supervisor; lesson, checkout and receipt are learner-only; admin has no `/learn` (redirects to `/cohort`).
- Provider names `themeModeProvider`, `localeProvider`, `notificationsEnabledProvider`, `sessionProvider` (AsyncNotifier of `Session?` = AppUser + role; signIn / switchRole / signOut), `routerProvider`, `sharedPreferencesProvider` (overridden in `main.dart` and tests). `main.dart` awaits `sessionProvider.future` before the first frame.
- Preference keys `PrefKeys.themeMode` / `PrefKeys.locale` / `PrefKeys.notifications` (renaming loses users' saved settings).
- Role switch audit target: `"<From> → <To> (demo)"` with English role names; `kDemoRoleSwitcher` (`lib/app/feature_flags.dart`, `--dart-define=DEMO_ROLE_SWITCHER=false` turns it off).
- `AppColors` token names and values (match the prototype canvas); shared widget public APIs in `lib/core/widgets/`.
- `Motion` constant names in `lib/core/motion.dart`.

- Quiz audit target: `"<quiz title EN> · <score>% (pass|fail)"`, e.g. `BLS Assessment · 88% (pass)`. Score = `QuizRules.scorePct` (half up), pass ≥ 80. Quiz ids `bls` (8 questions) and `ipc` (7, unlocks when c2 is complete).
- `LocalNotifier` (requestPermission, showNow, replaceSchedule) and `CertificateFilePicker` (pick → name + size only); Android channel id `expiry_reminders`. Cert upload audit target `"<name> · pending verification"`; reminder usage target `"<code> · <days> days"`. Reminders fire at 09:00 Dubai on 90/60/30/7 days before expiry for verified certificates.
- Sign-off audit targets: request = checklist name (EN); decision = `"<checklist> · <learner> · approved|rejected"` (never the comment). Default approval comment "Competent. Observed and signed off." stored in EN and AR.
- Purchase audit target `"<course EN> · AED <0.00> · <invoiceNo>"`; `checkout.start` usage target = course title. Card number, expiry and CVC live only in the form controllers, are validated locally, cleared on success and never stored, logged or sent; the gateway gets a mock token (`card_mock_<uuid>` / `applepay_mock_<uuid>`) and the order keeps only `cardLast4`.
- Audit export: CSV columns `ts,user,role,action,target,platform,kind,prevHash,hash`, RFC 4180, CRLF, file `clinicaledge-audit-YYYY-MM-DD.csv`; audit target `"CSV · N rows"`. Insights are built from `UsageStore` + seed only (`InsightsView.build` rejects audit events).
- Repository interfaces in `lib/features/*/data/*_repository.dart`: AuthRepository, CourseRepository, ProgressRepository, AssessmentRepository, CertificationRepository, CpdRepository, CompetencyRepository, CheckoutRepository, CohortRepository.
- `ActivityEvent` fields: id, ts (UTC), userId, role, action, target, platform (`ios`/`android`), kind (`audit`/`usage`), prevHash, hash (audit only). Action wire names: `AuditAction` (role.change, quiz.score, signoff.request, signoff.decision, purchase, cert.upload, course.complete, audit.export) and `UsageAction` (auth.signin, auth.signout, course.view, lesson.view, lesson.complete, checkout.start, notify.reminder).
- Audit hash: `SHA-256(prevHash|ts|userId|role|action|target|platform)` lower hex; ts = ISO-8601 UTC (`toIso8601String`), role = enum name; first prevHash = 64 zeros. `AuditStore` exposes append + list only. Targets pass `TargetSanitizer` (≤ 120 chars; no card numbers, CVC, emails, passwords).
- Seed JSON schema in `lib/seed/*.json` (`SeedFile` enum) and `DemoSeeder.seedVersion` (bump it when seed contents change so installed demos re-seed). Every user-facing seed string is `{en, ar}`.
- `LocalDb` collection names (`Collections`) and key formats (`userId|courseId`, `userId|lessonId`, zero-padded audit/usage sequence).
- `PaymentGateway` (createIntent, confirm), `PaymentMethod` (CardMethod, ApplePayMethod — tokens only), `PaymentResult` (PaymentSucceeded, PaymentFailed, PaymentNeeds3ds), `Order` fields.
- Money in integer fils (`Money`); VAT = round(subtotal × 5 / 100) half up, integer maths (`vatOf`). Invoice numbers `CE-YYYY-000000` from a persisted sequence starting at 1041.
- Demo clock: `FixedClock(demoNow)` = 2026-11-17 09:00 Asia/Dubai; calendar maths in Dubai time (UTC+4). Cert status: ≤ 0 days expired, ≤ 90 renew soon, else valid; pending verification → verifying.

## Decisions (newest first)

- 2026-11-18 · Web is a phone-sized preview, not a product target: `WebFrame` (in `MaterialApp.builder`, web only) shows the app in a centred 480 dp column with outline borders and its own MediaQuery size when the window is wider than 600 dp, and fills phone-width windows; web keeps the mock notifier and file picker, `Platform` calls are guarded with `!kIsWeb`, `web/**` is excluded from analysis. Native builds are untouched. Why: user wanted to try the app in Safari on Mac and iPhone; iOS + Android stay the targets.
- 2026-11-18 · Public web demo on Cloud Run (`tool/deploy_web_gcp.sh`): nginx:1.27-alpine serves `build/web` on port 8080 (SPA fallback to index.html, `Cache-Control: no-cache`, gzip), public, 256Mi, 0–3 instances, europe-west1. Live: project `clinicaledge-demo-1kicb4` (billing "RE Billing App"; the other account hit its project quota), https://clinicaledge-web-665747333105.europe-west1.run.app. The script grants `roles/run.builder` to the compute default SA. Why: new projects fail source deploys without it; scale to zero keeps the demo cheap.
- 2026-11-18 · The bell opens an in-app notifications sheet built per role from live providers (learner: expired/expiring/verifying certificates, then sign-off decisions; supervisor: pending queue newest first; admin: cohort certificates within 90 days, then the pending sign-off count). No store and no new `ActivityEvent` actions; seen ids are in memory per app session. The bell no longer posts a device notification or logs `notify.reminder`; Certs → Simulate still does (CERT-4). Why: the bell showed nothing useful.
- 2026-11-18 · Help & user guide at `/help` (root push from a Profile card, all roles): role intro, then numbered step topics per role plus shared bell/settings/demo topics, all from ARB strings (EN + AR). Why: user asked for a manual for each role.
- 2026-11-18 · No ECG animation on the sign-in hero or the Home hero card (user request); `EcgLine` stays in the lesson player.
- 2026-11-18 · Tablets: dashboard lists (`SectionList`) reflow into two independent columns when the available width is ≥ 700 dp (LayoutBuilder, not screen width): start gets the 1st, 3rd… sections, end the 2nd, 4th…, each column stacked on its own (no row pairs), mirrored in RTL. Why: NFR Platforms; row pairs left gaps beside tall cards; LayoutBuilder keeps tests on the phone layout.
- 2026-11-18 · `StatusTag` never wraps; if squeezed it fades its label instead of overflowing. Rows that pair a long name with a tag use `Wrap` or put the tag under the text. Why: 1.3× text and Arabic overflowed (a11y tests).
- 2026-11-18 · Theme-independent colours live in `FixedColors` (transparent, shadows, Apple Pay sheet); no `Color(0x…)` literals in widgets. `CrashReporter` prints only outside release.
- 2026-11-18 · Android `compileSdk = 37` (flutter_local_notifications 23 requires it; the Android build had been failing since Phase 6). Why: build fix.
- 2026-11-18 · App icon and splash generated from the logo mark (`tool/icon/render_icon_test.dart` → `assets/icon/`, flutter_launcher_icons + flutter_native_splash). Version 0.1.0+1.
- 2026-11-18 · Goldens are re-rendered on Linux by the manual workflow `.github/workflows/update-goldens.yml` (commits images + a CLAUDE.md log line). Why: macOS renders differ; CI compares on Linux.
- 2026-11-18 · Numbers inside seed text (quiz prompts, options, explanations) are LTR-isolated at render time (`ltrNumbers`). Why: "60–80" read reversed in Arabic.

- 2026-11-18 · Vertical charts (department progress, expiries, BLS drop-off) use fl_chart bars with titles off and our own labels below; bar order is reversed in RTL so the first item sits on the right; bars grow from 0 after `Motion.barDelay` (instant with reduced motion). Horizontal bars and the platform split are `LinearMeter`/custom widgets. Why: fl_chart titles are `flutter/material` widgets and it does not mirror; meters already mirror.
- 2026-11-18 · `FileSharer` interface for CSV export and receipt PDF (share_plus in `main.dart`, recording fake by default). Why: platform channels don't run in widget tests; widgets stay off plugins.
- 2026-11-18 · Cohort seed gains `kpis.supervisors` and per-learner `nextExpiryCode`/`nextExpiryDays` (demo figures); Layla's row uses live progress and her live soonest certificate; `DemoSeeder.seedVersion` → 6. BREAKING (additive model fields).
- 2026-11-18 · Cohort is the admin home (greeting title + first-load skeleton). Audit and Insights re-read the stores each time the tab is built and on pull-to-refresh. Why: live events from other roles.
- 2026-11-18 · Insights merge rule: seed views + live `course.view`/`lesson.view` matched by course title; seed platform shares count as 100 sessions plus live `auth.signin` by platform; pass rates stay seed-only (quiz scores are audit events). Why: ADM-4 never reads the audit store.
- 2026-11-18 · Apple Pay is a mock sheet only in v1. Plan: integrate Apple Pay through the chosen UAE gateway's SDK (e.g. Network International) with a merchant ID and payment-processing certificate, behind `PaymentGateway` + `ApplePayMethod(token)`; no widget changes. Why: brief; no real payments in v1.
- 2026-11-18 · `Order.cardLast4` added (BREAKING, additive) and `CheckoutRepository.completeOrder` takes optional `cardLast4`. Why: receipt shows "Card •••• 4242" from the last 4 only.
- 2026-11-18 · Success navigates with `go` to the receipt (checkout leaves the stack; receipt back → `/learn`). Why: go_router `replace` from a declaratively reached page reported `/learn/c3` as the location.
- 2026-11-18 · Receipt PDF is English-only (pdf package default font). Why: Arabic shaping needs an embedded Arabic font; revisit in Phase 10.
- 2026-11-18 · Seller renamed to "ClinicalEdge (demo)" in `demo.json`; `DemoSeeder.seedVersion` → 5. Why: brief's receipt copy. Invoice sequence still starts at CE-YYYY-001041 (contract).
- 2026-11-18 · Git commits are authored as `userproject02` with the GitHub no-reply email (user request); AGENTS.md → Git updated. Earlier commits keep the old author.
- 2026-11-18 · Queue stats are computed: pending = queue size, this month = requests received this calendar month (Dubai), turnaround = mean request→decision time over decided requests (seed gives 1.7d, the brief's mock showed 1.4d). Why: no hard-coded numbers in UI.
- 2026-11-18 · `MockCompetencyRepository.decide` keeps each `decidedAt` strictly after the latest decision. Why: under the fixed demo clock, "newest first" on Decided would tie.
- 2026-11-18 · `DecideSignOff` enforces "only a supervisor decides, never their own request" in the domain, not just the router. Why: permission rules in REQUIREMENTS.
- 2026-11-18 · `/queue` is the supervisor's home (greeting title + first-load skeleton like Home). Why: matches role-home behaviour from Phase 3; TC-PH1-43 now checks the queue list instead of the placeholder text.
- 2026-11-18 · Learner checklist items show as self-assessed (static ok checks); comments render in a start-bar quote card without quotation marks. Why: brief ("no curly quotes in Arabic").

Older decisions (Phases 0–7, still in force): `docs/decisions/v1-phases-0-7.md`.

## Known issues / TODO

- [ ] Goldens in the repo are macOS renders; run the *Update goldens (Linux)* workflow once so CI's golden comparison passes. `settings_*` are stale since Profile gained the Help card; `sign_in_*` and `home_*` are likely stale too (hero ECG removed, score bars re-anchored).
- [ ] iOS real local notification not confirmed automatically (the simulator permission prompt needs a tap): run the app, tap Allow when enabling reminders, then Certs → Simulate expiry reminder (the bell only opens the sheet now). Android confirmed.
- [ ] Bell "seen" state is in memory per app session (`inboxSeenProvider`); persist it per user if the dot should stay cleared after a restart.
- [ ] Web preview: `ActivityEvent.platform` reads `android` on desktop browsers (`defaultTargetPlatform` is not iOS; the contract has only ios/android); no device notifications or file picker on web (mocks).
- [ ] Android notification small icon uses the launcher mipmap and shows as a plain circle; add a monochrome `ic_notification` drawable.
- [ ] A snackbar can briefly cover a sticky bottom button on the next screen; consider dismissing snackbars on navigation.
- [ ] 60 fps profile check in DevTools not recorded in this session; animations are reduced-motion aware and no text scales.
- [ ] Clinical and native-Arabic review of all seed content (see `docs/TESTCASES.md` → Review notes). Receipt PDF is English-only (needs an embedded Arabic font).
- [ ] `HiveLocalDb` stores demo data in plain JSON on device; add encryption if real data ever lands.
- [ ] `docs/design/` has no screenshots (built from the prototype canvas); export frames when convenient.
- [ ] Remove `MaterialUiCompatibilityBridge` when fl_chart migrates to `material_ui`.
- [ ] Enable branch protection on GitHub with the CI checks required.

## Next up

Production (see README → What to build next): real auth/SSO with role claims (remove the demo switcher, `kDemoRoleSwitcher=false`), Firestore repositories + security rules, server-side audit chain, Firebase Analytics/Crashlytics behind `ActivityLogger`/`CrashReporter`, a UAE payment gateway adapter (real Apple Pay, 3-D Secure, invoices with TRN), FCM push, offline cache, PDPL/health-data and accessibility audits. Answer the open questions in REQUIREMENTS.md first.

## Change log (newest first; last 30 entries, older in docs/changelog/)

- 2026-11-18 · claude/gurus-macbook-air · Web preview (`web/` shell with loading spinner, `WebFrame` 480 dp phone column on wide windows, mock notifier + picker on web, `kIsWeb` guards) and public Cloud Run demo (`tool/deploy_web_gcp.sh`, nginx Dockerfile + conf; live in `clinicaledge-demo-1kicb4`); bell → per-role notifications sheet (`lib/features/notifications/`, real unread dot; Simulate on Certs keeps the device notification + notify.reminder); Help & user guide `/help` with per-role topics and a Profile card (55 ARB keys EN + AR); ECG animation removed from the sign-in and Home heroes; `SectionList` tablet layout as two independent columns (no gaps); Home recent-scores bars anchored to the chart bottom with the Pass 80% label in its own gutter; TC-AUTH-3-01 settles after scrolling · lib/app (app, router, routes, tab_scaffold, web_frame, l10n), lib/main.dart, lib/core (notifications, widgets/section_list), lib/features (notifications, settings, home, auth, certifications), web/, tool/web/, tool/deploy_web_gcp.sh, analysis_options.yaml, test/ (web_frame, section_list, notifications, help, assessments, auth_settings, certifications) · user requests: check the app in Safari, bell showed nothing, a manual per role, remove the hero animation, tablet gaps, chart pass line · BREAKING: new route `/help` (`AppRoutes.help`, allowed for every role in `RouteAccess`); additive, callers need no change
- 2026-11-18 · claude/gurus-macbook-air · iOS device signing: `DEVELOPMENT_TEAM = 5KT2A88653` set on the Runner target (Debug/Release/Profile) in `ios/Runner.xcodeproj/project.pbxproj`; install on iPhone still needs an Apple ID signed in under Xcode → Settings → Accounts (and Developer Mode on the phone). `admin_providers.g.dart` shows a pre-existing local regeneration diff (not from this change) · ios/Runner.xcodeproj · user request: install on iPhone

- 2026-11-18 · claude/gurus-macbook-air · Setup and deploy: `tool/setup.sh` (new-laptop setup, Flutter 3.50.0 pinned), `cloudbuild.yaml` + `tool/deploy_gcp.sh` (Cloud Build → Cloud Storage, optional Firebase App Distribution; Android only), DEPLOY.md, FEATURES.md, README links · tool/, cloudbuild.yaml, .gcloudignore, docs at repo root · user request: set up another laptop and deploy to GCP
- 2026-11-18 · claude/gurus-macbook-air · Phase 10: requirements sweep; a11y tests (tap targets, labels, contrast, 1.3× text EN/AR) and fixes (Resume 48 dp, locked/learner rows, StatusTag fade, admin card subtitle, legend wrap); privacy test; FixedColors (no colour literals); CrashReporter silent in release; SectionList two-column reflow on tablets; LatencyLocalDb 300–900 ms in main; ltrNumbers for Arabic ranges; TC-E2E-01 journey (EN light + AR dark) on iOS and Android; Android compileSdk 37 build fix; icon + splash; version 0.1.0+1; README; golden workflow; CLAUDE.md compacted (old log → docs/changelog/phase-10.md, old decisions → docs/decisions/v1-phases-0-7.md) · lib/core, lib/features, lib/app, lib/main.dart, android, ios, assets/icon, tool/icon, test/, integration_test/, README.md, .github/workflows · NFR, all requirement IDs

- 2026-11-18 · claude/gurus-macbook-air · Phase 9: Cohort dashboard (2×2 KPIs with live pending sign-offs, completion by course, progress by department and expiries charts with entry animation, RTL mirroring and semantics, learners with live row for Layla), Audit log (chain banner ok/broken from AuditChain.verify, kind/period chips, user/action dropdowns from data, target search, count line, audit and usage cards with hash link, paging by 50, Export CSV via share sheet + audit.export + snackbar), Usage insights (views, BLS drop-off with biggest drop highlighted, pass-rate rings, platform split, note) from usage events only; FileSharer service; route-title test replaces the placeholder test · lib/features/admin, lib/core/sharing, lib/app (router, mock overrides, l10n), lib/main.dart, lib/seed/cohort.json, test/features/admin_test.dart, test/app/router_test.dart · ADM-1..4 · BREAKING: `CohortKpis.supervisors` and `CohortLearner.nextExpiryCode/nextExpiryDays` (new optional fields); `mockOverrides` gains `sharer`; receipt Share PDF now goes through `fileSharerProvider`
- 2026-11-18 · claude/gurus-macbook-air · Phase 8: checkout (order summary with cover tile, Subtotal/VAT/Total via Money, Card / Apple Pay method cards, card form with 4-digit grouping + Luhn + expiry + obscured CVC, mock black Apple Pay sheet with pulsing Face ID glyph, lock note, sticky Pay with processing state, double-tap and back guard, decline banner with retry, mock 3-D Secure Approve/Cancel), PurchaseCourse use case (order, gateway, invoice, ownership, purchase audit), receipt (burst + check animation, invoice line, seller/buyer/item/method rows, totals, Share PDF via pdf + share_plus, Start course), checkout.start usage; git author switched to userproject02 · lib/features/checkout, lib/core/payments, lib/core/money.dart, lib/app (router, l10n), lib/seed/demo.json, AGENTS.md, test/features/checkout_test.dart · PAY-1..2 · BREAKING: `Order.cardLast4` (new field) and `CheckoutRepository.completeOrder(cardLast4:)`; MockCheckoutRepository updated

## Commands

`bash tool/setup.sh` (new laptop) · `bash tool/deploy_gcp.sh --project <id>` (GCP build) · `bash tool/deploy_web_gcp.sh --project <id> [--region europe-west1] [--service clinicaledge-web] [--skip-build]` (web demo → Cloud Run) · `flutter build web --release` (web preview) · `flutter pub get` · `flutter analyze` · `dart format .` · `flutter test` (macOS: `--exclude-tags golden`) · `flutter test --update-goldens --tags golden` · `dart run build_runner build` · `flutter gen-l10n` · `tool/ci/context_guard.sh worktree` · `lefthook install`
