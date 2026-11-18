# ClinicalEdge — Mobile Requirements & Architecture (v1 prototype)

Nov 17, 2026 · @Guruprasath J

## Overview

ClinicalEdge v1 is a clickable Flutter prototype for iOS and Android that runs entirely on mock, local data. It lets UAE healthcare professionals (physicians, residents, nurses, midwives) take courses and quizzes, track certifications and CPD/CME credits, and get competencies signed off. Supervisors approve sign-offs and admins watch cohort progress and the audit trail.

**Goals for v1**

- Prove every core flow end to end on a phone, for all three roles, with a demo role switcher.
- Look production-grade: Material 3, light/dark themes, English and Arabic (RTL).
- Be built so a real backend (Firebase), real payments (a UAE gateway such as Network International) and real analytics replace the mocks without UI changes.

**In scope:** mobile only (phones first, tablets reflow), mocked sign-in, courses and lessons, quizzes, certifications and CPD, competency sign-off, mock checkout with AED pricing and 5% VAT, admin cohort dashboard, audit and usage logging, seed data.

**Out of scope for v1:** a web product (a phone-sized web preview exists for demos only), real backend or auth, offline sync, real payments, MFA, security rules, compliance work, push notification delivery (reminders are simulated in-app).

The interactive design lives on the ClinicalEdge canvas; screen references below (01–14, S1–S3, A1–A3) match its storyboard.

## Users and roles

Three roles share one app; the active role decides the bottom-bar tabs and what each screen allows. In v1 any user can switch role from sign-in or Profile & settings, and each switch is an audit event.

| Role | Seed user | Bottom-bar tabs | Can do |
| --- | --- | --- | --- |
| Learner | Dr. Layla Haddad, Resident · Internal Medicine | Home, Learn, Assess, Certs, Sign-offs | Take courses and quizzes, buy courses, upload certificates, request competency sign-off |
| Supervisor | Dr. Omar Al Mansoori, Consultant · Emergency Medicine | Queue, Decided, Learn | Review sign-off requests; approve, or reject with a mandatory comment |
| Admin | Sara Khan, Education & Compliance Admin | Cohort, Audit, Insights | View cohort progress, search and export the audit log, view usage insights |

**Permission rules**

- Only a supervisor can decide a sign-off; a learner cannot approve their own request.
- Only an admin can open the audit log, export CSV or see cohort data.
- Every role can browse the course catalogue and open Profile & settings.
- In production, role assignment moves to the backend (custom claims); the in-app switcher is demo-only and must be removed or feature-flagged off.

## Functional requirements

Each requirement has an ID for tickets and tests; "must" items are needed for the v1 demo, "should" items can slip.

| ID | Feature | Requirement | Acceptance criteria | Priority |
| --- | --- | --- | --- | --- |
| AUTH-1 | Sign-in | Email and password sign-in against a mock auth repository | Any non-empty password signs in; empty fields show inline errors; `auth.signin` is logged | Must |
| AUTH-2 | Demo roles | Role picker on sign-in and in Profile & settings | Switching role changes tabs and home screen at once; logs `role.change` as an audit event | Must |
| AUTH-3 | Sign-out | Sign out from Profile & settings | Returns to sign-in, clears session state, logs `auth.signout` | Must |
| HOME-1 | Learner home | Dashboard with overall progress, next expiry, CPD credits, continue-learning carousel, recent scores, sign-off status | Values match repository data; a skeleton shows while data loads (\~1 s simulated latency) | Must |
| CRS-1 | Catalogue | List the 3 seed courses with search and category chips | Owned courses show progress; unowned show AED price + VAT note | Must |
| CRS-2 | Course detail | Header, lessons list with state (to do, now, done, locked), sticky CTA | CTA reads Continue / Start / Buy; locked lessons route to checkout | Must |
| CRS-3 | Lesson view | Video, PDF and reading placeholders; previous and mark-complete actions | Mark complete updates progress everywhere and advances; logs `lesson.view` and `lesson.complete` | Must |
| CRS-4 | Course completion | Finishing all lessons awards the course's CPD credits | Credit meter increases; logs `course.complete` (audit) | Must |
| QZ-1 | Quiz | 8 multiple-choice questions drawn from a 20-question bank | One answer per question; correct/incorrect shown immediately with an explanation | Must |
| QZ-2 | Scoring | Score, pass mark 80%, result screen | Pass or fail state shown; attempt added to history; logs `quiz.score` (audit) | Must |
| QZ-3 | Score history | Attempts list with date and score on the Assess tab | Newest first; best score and attempt count shown | Must |
| CERT-1 | Certifications | List with issuer, expiry date, days left and status (valid, renew soon ≤ 90 days, verifying) | Status and expiry bar computed from the current date | Must |
| CERT-2 | CPD meter | Credits earned against the cycle target (demo target 40) with a ledger | Meter and ledger agree; target is config, not hard-coded in UI | Must |
| CERT-3 | Upload | Bottom sheet to upload a certificate (mocked file pick or camera) | New certificate appears as "Verifying"; logs `cert.upload` (audit) | Must |
| CERT-4 | Reminders | Expiry reminders at 90, 60, 30 and 7 days, with an in-app simulate button and a settings toggle | Simulated reminder shows a notification banner; logs `notify.reminder` | Must |
| COMP-1 | Request sign-off | Learner sees 2 competency checklists and requests sign-off | Status moves None → Pending; request appears in the supervisor queue; logs `signoff.request` (audit) | Must |
| COMP-2 | Decide sign-off | Supervisor reviews items, adds a comment, approves or rejects | Reject needs a comment; decision and comment show on the learner's card; logs `signoff.decision` (audit) | Must |
| PAY-1 | Checkout | Order summary in AED with 5% VAT; card form or Apple Pay sheet (both mocked) | Total = price × 1.05, rounded to 2 decimals; pay shows a processing state | Must |
| PAY-2 | Receipt | Tax-invoice style receipt with number, date, VAT line and seller TRN placeholder | Course unlocks; logs `purchase` (audit); share action is mocked | Must |
| ADM-1 | Cohort dashboard | KPIs, completion by course, progress by department, expiries by month, learner list | Charts render from repository data with entrance animation | Must |
| ADM-2 | Audit log | Search and filter by user, action, kind and date; newest first | Filters combine; each audit row shows its hash link to the previous row | Must |
| ADM-3 | CSV export | Export the filtered log | Produces a CSV file via the share sheet; logs `audit.export` (audit) | Must |
| ADM-4 | Usage insights | Most-used courses, lesson drop-off, quiz pass rates, sessions by platform | Built from usage events only, never from audit events | Should |
| SET-1 | Settings | Language (EN/AR), theme (light/dark), notifications toggle | Changes apply instantly and persist across restarts (local storage) | Must |

## Non-functional requirements

| Area | Requirement |
| --- | --- |
| Platforms | iOS 15+ and Android 8.0 (API 26)+ from one Flutter codebase (Flutter 3.x stable, Dart 3); portrait phone first, tablets reflow to two columns |
| Performance | Cold start to sign-in < 2 s on a mid-range device; screen transitions at 60 fps; mock repositories add 300–900 ms latency to show loading states |
| Design system | Material 3 with one seed colour (teal #0A6E73), custom `ThemeExtension` for status colours (ok, warn, bad); Inter for Latin, IBM Plex Sans Arabic for Arabic via `google_fonts` |
| Themes | Light and dark schemes for every screen; no hard-coded colours in widgets |
| Localisation | English and Arabic through `flutter_localizations` + ARB files (`intl`); full RTL mirroring, including back arrows, progress bars and slide transitions; AED amounts and dates formatted per locale |
| Accessibility | Touch targets ≥ 48 dp; text contrast ≥ 4.5:1; `Semantics` labels on icon buttons, rings and charts; supports system text scaling to 1.3× without clipping |
| Motion | Fade-through for tab changes, shared-axis slide for pushes, animated rings and bars, sheet and snackbar transitions; all respect `MediaQuery.disableAnimations` |
| Privacy | No patient data anywhere; never log passwords, card numbers, CVC or free-text that could hold patient data; store only what the seed data needs |
| Reliability | Audit log is append-only and tamper-evident (hash chain); usage analytics are stored separately and may be lossy |
| Maintainability | Feature-first folders, every data source behind an interface, `very_good_analysis` lints, ≥ 70% unit-test coverage on domain and repository code |

## Architecture

The app is feature-first with three layers per feature: presentation (widgets + Riverpod notifiers), domain (pure Dart models and use cases), and data (repository interfaces with mock implementations). Swapping mocks for Firebase means writing new repository classes and changing provider overrides; no widget changes.

&#91;embedded content: layered architecture · mock now, Firebase later\]

Widgets talk to Riverpod notifiers. Notifiers run use cases, and use cases reach data only through interfaces. A `ProviderScope` override decides whether the mock or the production implementation answers.

**Folder structure**

```
lib/
  main.dart                 // ProviderScope + overrides (mock vs. firebase)
  app/
    app.dart                // MaterialApp.router, theme, locale
    router.dart             // go_router: StatefulShellRoute per role, guards
    theme/                  // ColorScheme.fromSeed, ThemeExtension<StatusColors>
    l10n/                   // app_en.arb, app_ar.arb
  core/
    logging/                // ActivityLogger interface, AuditChain, MockLogStore
    payments/               // PaymentGateway interface, MockGateway
    clock.dart              // injectable Clock for expiry maths and tests
    money.dart              // AED + VAT helper (integer fils, no doubles)
    widgets/                // ProgressRing, StatTile, SkeletonBox, EmptyState
  features/
    auth/        data/ domain/ presentation/
    home/        presentation/
    courses/     data/ domain/ presentation/   // catalogue, detail, lesson
    assessments/ data/ domain/ presentation/   // quiz, result, history
    certifications/ data/ domain/ presentation/ // certs, CPD ledger, upload, reminders
    competencies/ data/ domain/ presentation/   // learner requests, supervisor queue/review
    checkout/    data/ domain/ presentation/   // order, payment, receipt
    admin/       data/ domain/ presentation/   // cohort, audit log, insights
    settings/    presentation/
  seed/                     // JSON seed: courses, quiz bank, certs, checklists, users
```

**Key packages**

| Concern | Package | Notes |
| --- | --- | --- |
| State and DI | `flutter_riverpod` + `riverpod_annotation` / `riverpod_generator` | `AsyncNotifier` per screen; repositories exposed as providers so tests and Firebase can override them |
| Routing | `go_router` | `StatefulShellRoute.indexedStack` keeps each tab's stack; redirect guard by auth state and role |
| Models | `freezed` + `json_serializable` | Immutable models, JSON for seed files and later Firestore |
| Local storage | `shared_preferences` (settings), `hive_ce` or `drift` (mock stores) | Mock repos persist so a demo survives a restart |
| i18n | `flutter_localizations`, `intl` | ARB files, RTL via `Directionality` from locale |
| Charts | `fl_chart` | Bars and rings for cohort and insights; rings can also be a `CustomPainter` |
| Files and sharing | `file_picker`, `share_plus` | Mock certificate pick; CSV export and receipt share |
| Notifications | `flutter_local_notifications` | Simulated expiry reminders now, scheduled locally later |
| Hashing | `crypto` | SHA-256 for the audit hash chain |
| Fonts | `google_fonts` | Inter and IBM Plex Sans Arabic, bundled for offline |

**Rules**

- Widgets read state only through providers; they never call a repository directly.
- Every user action that matters goes through a use case, which writes to the repository and then calls `ActivityLogger`.
- `Clock` and `Random` are injected so expiry dates, receipt numbers and tests are deterministic.

## Domain model and seed data

All models are `freezed` classes; IDs are strings so they map straight to Firestore document IDs later.

| Model | Key fields | Repository interface |
| --- | --- | --- |
| `AppUser` | id, name, title, department, email, role, locale | `AuthRepository` (signIn, signOut, currentUser, switchRole) |
| `Course` | id, title (en/ar), category, colour, durationMin, cpdCredits, priceFils, lessons\[\] | `CourseRepository` (catalogue, byId, ownership) |
| `Lesson` | id, courseId, order, title, type (video, pdf, text), minutes, assetRef | part of `CourseRepository` |
| `LessonProgress` | userId, lessonId, completedAt | `ProgressRepository` (markComplete, forUser) |
| `Question` | id, bankId, prompt, options\[4\], correctIndex, explanation | `AssessmentRepository` (drawQuiz(n), submitAttempt, history) |
| `QuizAttempt` | id, userId, quizId, answers, scorePct, passed, submittedAt | part of `AssessmentRepository` |
| `Certification` | id, userId, name, issuer, issuedOn, expiresOn, status, fileRef | `CertificationRepository` (list, upload, reminders) |
| `CpdEntry` | id, userId, date, activity, source, credits | `CpdRepository` (ledger, total, target) |
| `CompetencyChecklist` | id, name, audience, items\[\] | `CompetencyRepository` (checklists) |
| `SignOffRequest` | id, learnerId, checklistId, status, requestedAt, decidedBy, decidedAt, comment | `CompetencyRepository` (request, queue, decide) |
| `Order` / `Receipt` | id, userId, courseId, subtotalFils, vatFils, totalFils, method, invoiceNo, paidAt | `CheckoutRepository` + `PaymentGateway` |
| `ActivityEvent` | id, ts, userId, role, action, target, platform, kind (audit or usage), prevHash, hash | `ActivityLogger` (see Audit section) |

Money is stored as integer fils (1 AED = 100 fils) to avoid rounding errors: VAT = round(subtotal × 5 / 100).

**Seed data (JSON in `lib/seed/`)**

- 3 courses: Basic Life Support Refresher (6 lessons, 4 CPD, AED 350), Infection Prevention & Control Essentials (5 lessons, 3 CPD, AED 250), Medication Safety & High-Alert Drugs (4 lessons, 2 CPD, AED 300, unowned so checkout can be demoed).
- A 20-question bank across resuscitation, infection control and medication safety; each quiz draws 8.
- 2 certifications: BLS Provider (expires 12 Jan 2027, triggers "renew soon") and ACLS (expires 30 Sep 2027).
- 2 competency checklists: Peripheral IV cannulation and Neonatal resuscitation skills, 4 items each.
- 3 users, one per role, plus 4 named cohort learners for the admin views.
- No patient data anywhere in seed files, fixtures or tests.

## Audit and activity logging

One `ActivityLogger` interface takes every event and sends it to one of two stores. Audit events go to an append-only, hash-chained store. Usage events go to a separate analytics store that may be lossy.

```dart
abstract interface class ActivityLogger {
  Future<void> audit(AuditAction action, {required String target});
  void usage(UsageAction action, {required String target});
}

class ActivityEvent {            // freezed in code
  String id; DateTime ts; String userId; Role role;
  String action; String target; String platform;   // ios | android
  EventKind kind;                // audit | usage
  String prevHash; String hash;  // audit only
}
```

| Kind | Actions | Store | Guarantees |
| --- | --- | --- | --- |
| Audit | `role.change`, `quiz.score`, `signoff.request`, `signoff.decision`, `purchase`, `cert.upload`, `course.complete`, `audit.export` | `AuditStore` (mock: local DB table with insert only) | Append-only: no update or delete API. Tamper-evident: `hash = SHA-256(prevHash \| ts \| userId \| role \| action \| target \| platform)` |
| Usage | `auth.signin`, `auth.signout`, `course.view`, `lesson.view`, `lesson.complete`, `checkout.start`, `notify.reminder` | `UsageStore` (mock: local DB, later Firebase Analytics) | Best effort, batched, can be sampled |

**Rules**

- `user`, `role`, `platform` and `ts` are filled in by the logger from the session, `Clock` and `Platform`, never by the caller.
- `target` is a short label (course or checklist name, score, amount). The logger rejects card numbers, passwords and free text, and never sees patient data.
- `AuditChain.verify()` recomputes every hash on the Audit screen and shows "chain verified" or the first broken event.
- CSV export covers the filtered rows: ts, user, role, action, target, platform, kind, prevHash, hash. The export is itself an audit event.
- Crashes go to a separate `CrashReporter` interface (mock: console; later Crashlytics). They never go to the audit store.

**Swapping to Firebase later:** `FirebaseUsageLogger` maps usage actions to `FirebaseAnalytics.logEvent`. Audit events move to a Cloud Function that writes to a Firestore collection with create-only security rules, and the server computes the chain.

## Payments

Checkout calls a `PaymentGateway` interface. In v1 a `MockGateway` always succeeds after 1.5 s. A UAE gateway adapter (for example Network International) plugs in later without changes to the checkout UI.

```dart
abstract interface class PaymentGateway {
  Future<PaymentIntent> createIntent(Order order);     // server-side in production
  Future<PaymentResult> confirm(PaymentIntent intent, PaymentMethod method);
}

sealed class PaymentMethod {}
class CardMethod extends PaymentMethod { final String token; }  // tokenised by gateway SDK, never raw PAN
class ApplePayMethod extends PaymentMethod { final String token; }

sealed class PaymentResult {}
class PaymentSucceeded extends PaymentResult { final String reference; }
class PaymentFailed extends PaymentResult { final String reason; }
class PaymentNeeds3ds extends PaymentResult { final Uri challengeUrl; }
```

**Pricing rules**

- Prices are stored in fils and shown as "AED 300.00"; VAT is 5% on the subtotal and shown on its own line.
- Totals in the seed data: AED 350 → 367.50, AED 250 → 262.50, AED 300 → 315.00.
- The receipt shows the invoice number (`CE-YYYY-000000`), date and time, seller name with a \[YOUR TRN\] placeholder, buyer, item, method, subtotal, VAT and total.

**Security rules, applying already in the mock**

- The card form never stores, logs or sends raw card numbers or CVC. In production the gateway's SDK or hosted fields tokenise them.
- A successful payment does three things in one use case: it records the `Order`, unlocks the course and writes the `purchase` audit event with the amount and invoice number only.
- The `PaymentNeeds3ds` branch exists in the interface now, so 3-D Secure fits in later without reshaping the flow.

## Navigation and screens

`go_router` holds one `StatefulShellRoute` per role, so each tab keeps its own back stack. A redirect sends signed-out users to `/sign-in`, and sends users who open a route for another role to their own home.

| Route | Screen | Role | Type | Canvas ref |
| --- | --- | --- | --- | --- |
| `/sign-in` | Sign-in with role picker | All | Full screen | Prototype start |
| `/home` | Learner home | Learner | Tab | 01, 14 |
| `/learn` | Course catalogue | All | Tab | 02 |
| `/learn/:courseId` | Course detail | All | Push | 03 |
| `/learn/:courseId/lesson/:n` | Lesson player | Learner | Push | 04 |
| `/learn/:courseId/checkout` | Checkout | Learner | Push | 11 |
| `/learn/:courseId/receipt/:orderId` | Receipt | Learner | Push (replaces checkout) | 12 |
| `/assess` | Assessments and history | Learner | Tab | 05 |
| `/assess/:quizId/run` | Quiz in progress and result | Learner | Push | 06, 07 |
| `/certs` | Certifications and CPD | Learner | Tab | 08 |
| `/certs/upload` | Upload certificate | Learner | Modal bottom sheet | 09 |
| `/signoffs` | Competency checklists | Learner | Tab | 10 |
| `/queue` | Sign-off queue | Supervisor | Tab | S1 |
| `/queue/:requestId` | Review and decide | Supervisor | Push | S2 |
| `/decided` | Recently decided | Supervisor | Tab | S3 |
| `/cohort` | Cohort dashboard | Admin | Tab | A1 |
| `/audit` | Audit log | Admin | Tab | A2 |
| `/insights` | Usage insights | Admin | Tab | A3 |
| `/profile` | Profile and settings | All | Push from the avatar | 13 |
| `/help` | Help & user guide (per role) | All | Push from Profile | — |

Transitions: tabs use the Material 3 fade-through and pushes use a shared-axis horizontal slide that mirrors in RTL. Sheets slide up over a scrim. The bell opens a notifications sheet for the current role (reminders, sign-off requests and decisions, cohort alerts). Snackbars are used for confirmations and a top banner for simulated push notifications.

## Testing and delivery

Each item in the build order below is a phase. Run the app on an iOS simulator and an Android emulator after each phase. A phase is done only when it passes the phase gate in the next section.

**Tests**

- Unit: VAT and money maths, quiz scoring and pass mark, expiry status from `Clock`, CPD totals, audit hash chain (append and verify, tamper detection).
- Widget: each screen in light and dark, EN and AR, using provider overrides with fixed seed data. Golden tests for home, quiz result, receipt and audit log.
- Integration (`integration_test`): sign in → finish a lesson → pass the quiz → buy a course → request sign-off → switch to supervisor and approve → switch to admin and find all of it in the audit log.
- CI: GitHub Actions runs `flutter analyze`, `dart format --set-exit-if-changed`, tests and coverage, then builds the debug APK and an iOS build with `--no-codesign`.

**Build order**

1. Scaffold: app shell, theme (light and dark), ARB files with RTL, go\_router with role shells and the sign-in redirect.
2. Core: `Clock`, money helper, `ActivityLogger` with mock stores and the hash chain, seed loader.
3. Auth and the demo role switcher, plus Profile & settings (language, theme, notifications).
4. Courses: catalogue, detail, lesson player, progress and course completion.
5. Assessments: quiz, result, history.
6. Certifications and CPD: list, ledger, upload sheet, simulated reminders.
7. Competencies: learner request, supervisor queue, review and decision.
8. Checkout: `PaymentGateway`, `MockGateway`, receipt.
9. Admin: cohort dashboard, audit log with filters and CSV export, insights.
10. Polish: animations, accessibility pass, golden tests, README with setup steps.

## Context files for Claude and other agents

The repo keeps three living files so any Claude session, on any machine, can change the app without breaking it. `CLAUDE.md` is updated **in the same commit as every change to the app**, not just at the end of a phase. CI fails any change that touches the app but leaves `CLAUDE.md` unchanged.

| File | Holds | Updated |
| --- | --- | --- |
| `AGENTS.md` (repo root) | Rules shared by every coding agent: architecture rules, folder layout, commands, coding conventions, what never to log | When a rule, command or convention changes |
| `CLAUDE.md` (repo root) | Imports `@AGENTS.md`, then adds the live state: module map, do-not-break contracts, current phase, decisions, known issues, change log | **In the same commit as every change** to app code, tests, dependencies, config or assets; reviewed again at every phase completion |
| `.claude/agents/*.md` | Claude Code subagents: `test-writer` (tests from requirement IDs), `code-reviewer` (checks architecture rules, logging rules and the contracts), `context-keeper` (writes the `CLAUDE.md` and `TESTCASES.md` updates for a change) | When a subagent's job changes |
| `docs/TESTCASES.md` | Test case catalogue: one row per case, linked to a requirement ID and its test file | In the same commit as the code it covers |

**Change protocol (every session, every change)**

1. Pull the latest code, then read `CLAUDE.md` and `AGENTS.md` before touching anything.
2. Look up the area you're changing in the module map and the do-not-break contracts.
3. Make the change and its tests, then run `flutter analyze` and `flutter test`.
4. In the same commit, run `context-keeper`. It adds one change-log line and updates the module map, contracts, status and known issues if they changed, plus `docs/TESTCASES.md`.
5. Changing a contract (an interface, route, model field, event name or seed file) needs a change-log line marked `BREAKING`, with what callers must change. Fix every caller in the same commit.
6. When `CLAUDE.md` conflicts between two sessions, keep both change-log lines in time order. Never drop another session's entries.

Change-log line format: `YYYY-MM-DD · <who/machine> · <what changed> · <files or feature> · <why> [· BREAKING: <impact>]`

**`CLAUDE.md` skeleton**

```markdown
# ClinicalEdge — project context
@AGENTS.md

> Read this before every change. Update it in the same commit as every change.

## Product in one paragraph
Flutter mobile (iOS/Android) training, certification and CPD app for UAE clinicians.
v1 = mock data only; every data source sits behind an interface.

## Current status
- Phase: 4 of 10 — Courses (in progress)
- Done: 1 Scaffold · 2 Core · 3 Auth & settings
- Last updated: <date> · <who/machine>

## Module map
| Feature | Entry route | Providers | Repository | Tests |
| courses | /learn | courseListProvider, lessonProgressProvider | CourseRepository | test/features/courses/ |
| ... one row per feature ... |

## Do-not-break contracts
- Repository interfaces in features/*/data/*_repository.dart — change only with BREAKING log
- Route paths in app/router.dart (deep links + tests depend on them)
- ActivityEvent fields and action names (audit chain + CSV export depend on them)
- Seed JSON schema in lib/seed/ (mock repos + tests load it)
- Money in integer fils; VAT = round(subtotal * 5 / 100)

## Decisions (newest first)
- <date> Money stored in fils (int). Why: no float drift.

## Known issues / TODO
- [ ] RTL golden for lesson player still flaky

## Next up
5 Assessments — QZ-1..QZ-3; test cases TC-QZ-*

## Change log (newest first; last 30 entries, older in docs/changelog/)
- 2026-11-20 · guru/macbook · lesson player marks completion · features/courses · CRS-3
- 2026-11-19 · claude/ci-runner · renamed ProgressRepository.complete → markComplete · features/courses · clarity · BREAKING: update callers

## Commands
flutter test · flutter analyze · dart run build_runner build -d
```

Keep `CLAUDE.md` short (aim for under 200 lines). Move closed decisions into `docs/decisions/` when it grows, and leave a one-line pointer behind.

**`docs/TESTCASES.md` format**

| Test ID | Requirement | Type | Case | Expected | Test file | Status |
| --- | --- | --- | --- | --- | --- | --- |
| TC-AUTH-1-01 | AUTH-1 | Widget | Sign in with empty password | Inline error, no navigation | `test/features/auth/sign_in_test.dart` | Passing |
| TC-QZ-2-01 | QZ-2 | Unit | 7 of 8 correct | 88%, passed = true | `test/features/assessments/scoring_test.dart` | Planned |
| TC-PAY-1-01 | PAY-1 | Unit | Subtotal AED 300 | VAT 15.00, total 315.00 | `test/core/money_test.dart` | Planned |
| TC-LOG-01 | Audit | Unit | Edit a stored audit event | `AuditChain.verify()` reports the broken event | `test/core/audit_chain_test.dart` | Planned |
| TC-E2E-01 | All | Integration | Full demo journey across three roles | Every audit action appears in the log | `integration_test/demo_journey_test.dart` | Planned |

Every requirement ID in Functional requirements has at least one test case before its phase closes.

**Phase gate (run at the end of every phase)**

- [ ] Tests for the phase pass; `flutter analyze` and `dart format` are clean.
- [ ] `docs/TESTCASES.md` has rows for every requirement in the phase, with up-to-date statuses.
- [ ] `CLAUDE.md` reviewed as a whole: status, module map, contracts, decisions, known issues, next phase.
- [ ] Change log compacted: entries beyond the last 30 move to `docs/changelog/phase-N.md`.
- [ ] `AGENTS.md` updated if any rule or command changed.
- [ ] Commit `phase-N: <name> complete` and tag `phase-N`.

**Enforcement, so no session can skip it**

- **CI on every push and pull request:** fails when `lib/`, `test/`, `pubspec.yaml`, `assets/` or config changed but `CLAUDE.md` did not. It also fails when a new or changed requirement ID has no row in `docs/TESTCASES.md`.
- **Git pre-commit hook** (`lefthook`): runs the same check locally, so it applies to people as well as agents.
- **Claude Code hooks** in `.claude/settings.json`: a `SessionStart` hook prints the current status and the last 5 change-log lines into context. A `Stop` hook blocks ending a turn while app files are modified but `CLAUDE.md` is not.
- New sessions on any machine start by reading `CLAUDE.md`. That way a session on another system sees what changed, what must not break and what is in progress.

## Path to production and open questions

Each mock already sits behind an interface, so production work is mostly new implementations plus the controls that were out of scope for v1.

| Area | v1 prototype | Production |
| --- | --- | --- |
| Auth | Mock email and password, demo role switcher | Firebase Auth or the hospital's SSO (OIDC/SAML); roles from custom claims; MFA; switcher removed |
| Data | Local mock repositories with seed JSON | Firestore repositories with security rules per role; Cloud Storage for lesson media and certificates |
| Audit | Local hash chain | Cloud Function writer, create-only rules, server-side chain, scheduled integrity check, export to cold storage |
| Analytics | Local usage store | Firebase Analytics + Crashlytics behind the same interfaces |
| Payments | `MockGateway` | Network International (or chosen UAE gateway) adapter, server-side intents, 3-D Secure, refunds, real tax invoices with TRN |
| Notifications | In-app simulated banner | FCM push + locally scheduled expiry reminders |
| Offline | None | Firestore offline cache, queued writes for progress and quiz attempts |
| Compliance | None | UAE PDPL and health-data residency review, DHA/DoH/MOHAP CPD rules, data retention policy, accessibility audit |

**Open questions**

- [ ] Which licensing authorities and CPD rules must the credit meter follow (DHA, DoH Abu Dhabi, MOHAP), and what is the real target per profession?
- [ ] Will sign-in use hospital SSO or ClinicalEdge accounts?
- [ ] Which payment gateway and which tax registration (TRN) will issue invoices?
- [ ] Must certificate uploads be verified by an admin, and who owns that queue?
- [ ] How long must audit events be retained, and who can export them?
- [ ] Does any content need to be fully translated into Arabic, beyond the app's own interface?
