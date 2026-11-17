# AGENTS.md — rules for every coding agent on ClinicalEdge

Read this file and `CLAUDE.md` before every change. These rules apply to any agent (Claude Code, Codex, Cursor, Gemini, Copilot) and to people.

## Product

- ClinicalEdge is a training, certification and CPD/CME progress app for healthcare professionals in the UAE (physicians, residents, nurses, midwives).
- Flutter, one codebase, **iOS and Android only**. There is no web, desktop or macOS target.
- v1 is a clickable prototype on **mock, local data**: no real backend, authentication, payments or push delivery.
- Roles: **Learner** (courses, quizzes, certifications, credits), **Supervisor** (signs off competencies), **Admin** (cohort progress, audit log). A demo role switcher is part of v1.
- Full requirements: `docs/REQUIREMENTS.md` (requirement IDs such as AUTH-1, CRS-3, PAY-1 are the source of truth).

**Out of scope for v1:** web build, real backend or auth, offline sync, real payments, MFA, security rules, compliance work, real push delivery (reminders are simulated in-app plus local notifications).

## Architecture rules

- Feature-first folders:

  ```
  lib/
    main.dart            ProviderScope + overrides (mock now, Firebase later)
    app/                 app.dart, router.dart, theme/, l10n/
    core/                logging/, payments/, clock.dart, money.dart, motion.dart, widgets/
    features/<feature>/  data/ domain/ presentation/
    seed/                JSON seed data
  ```

- Layers: presentation (widgets + Riverpod notifiers) → domain (pure Dart models + use cases) → data (repository interfaces + implementations).
- **Widgets never call repositories.** Widgets read providers; notifiers call use cases; use cases call repository interfaces and `ActivityLogger`.
- Every data source sits behind an interface. Mock implementations are chosen with Riverpod `ProviderScope` overrides in `main.dart`. Swapping to Firebase means new implementations plus new overrides, with no widget changes.
- `Clock` and `Random` are injected, never read directly (`DateTime.now()` is banned outside `SystemClock`).
- One `PaymentGateway` interface (`MockGateway` in v1). One `ActivityLogger` interface (mock audit + usage stores in v1).

## Packages

Pin versions here when they are added (Phase 1 adds the main set).

| Package | Version | Why |
| --- | --- | --- |
| very_good_analysis | see pubspec.yaml | lint rules |

## Coding conventions

- Models are `freezed` + `json_serializable`; IDs are strings.
- **Money is integer fils** (1 AED = 100 fils). VAT = `round(subtotal * 5 / 100)`. Never use `double` for money.
- No hard-coded user-facing strings: everything goes through ARB files (`lib/app/l10n/app_en.arb`, `app_ar.arb`).
- No hard-coded colours in widgets: use `Theme.of(context)` and the `AppColors` theme extension.
- RTL-safe layout only: `EdgeInsetsDirectional`, `AlignmentDirectional`, `start`/`end`, never `left`/`right`. Numbers, percentages, AED amounts, emails, card numbers and hashes are isolated LTR.
- Accessibility: touch targets ≥ 48 dp, `Semantics` labels on icon buttons, rings and charts, text contrast ≥ 4.5:1, works at 1.3× text scale.
- Motion: use the constants in `lib/core/motion.dart`; respect `MediaQuery.disableAnimations`; **never animate scale on widgets that contain text** (it renders blurry). Use opacity and translate.
- Dart: `very_good_analysis` must pass with zero issues; `dart format` with default settings.

## Logging and privacy rules

- **Never log** passwords, card numbers, CVC, free-text comments, file contents, or any patient data. There is no patient data anywhere in this app.
- `ActivityLogger` fills `user`, `role`, `platform` and `ts` itself; callers pass only `action` and a short `target` label (≤ 120 chars).
- Audit events (append-only, hash-chained): `role.change`, `quiz.score`, `signoff.request`, `signoff.decision`, `purchase`, `cert.upload`, `course.complete`, `audit.export`.
- Usage events (separate store, may be lossy): `auth.signin`, `auth.signout`, `course.view`, `lesson.view`, `lesson.complete`, `checkout.start`, `notify.reminder`.
- Crashes go to `CrashReporter`, never to the audit store.

## Commands

| Task | Command |
| --- | --- |
| Get packages | `flutter pub get` |
| Code generation | `dart run build_runner build -d` |
| Run (iOS simulator / Android emulator) | `flutter run -d <device>` |
| Analyze | `flutter analyze` |
| Format | `dart format .` (CI: `dart format --output=none --set-exit-if-changed .`) |
| Unit + widget tests | `flutter test` |
| Update goldens | `flutter test --update-goldens` |
| Integration test | `flutter test integration_test` |
| Install git hooks | `lefthook install` (once per clone; needs `brew install lefthook`) |
| Context check (same as CI) | `tool/ci/context_guard.sh worktree` |

## Change protocol (every session, every change)

1. Pull the latest code, then read `CLAUDE.md` and this file before touching anything.
2. Look up the area you are changing in the **module map** and the **do-not-break contracts** in `CLAUDE.md`.
3. Make the change **with tests**, then run `flutter analyze` and `flutter test` (and the app on iOS and Android for UI changes).
4. In the **same commit**, update `CLAUDE.md`: add one change-log line and update the module map, contracts, status and known issues if they changed. Update `docs/TESTCASES.md` for any requirement touched. (Claude Code: run the `context-keeper` subagent.)
5. A change to a contract (repository interface, route path, model field, `ActivityEvent` field or action name, seed JSON schema, `PaymentGateway`) is **BREAKING**: mark the log line `BREAKING`, say what callers must change, and fix every caller in the same commit.
6. If `CLAUDE.md` conflicts between two sessions, keep **both** change-log lines in time order. Never drop another session's entries.

Change-log line format:

```
YYYY-MM-DD · <who/machine> · <what changed> · <files or feature> · <why> [· BREAKING: <impact>]
```

Enforcement: the Claude Code `Stop` hook, the lefthook pre-commit hook and CI all fail when app files change without `CLAUDE.md`.

## Phase gate (end of every phase)

- [ ] `flutter analyze` and `dart format` clean; all tests green.
- [ ] `docs/TESTCASES.md` has rows for every requirement in the phase, with up-to-date statuses.
- [ ] `CLAUDE.md` reviewed as a whole: status, module map, contracts, decisions, known issues, next up.
- [ ] Change log compacted: entries beyond the last 30 move to `docs/changelog/phase-N.md`.
- [ ] `AGENTS.md` updated if any rule or command changed.
- [ ] Commit `phase-N: <name> complete` and tag `phase-N`.

## Git

- Commit author email: `guruprasathjay@gmail.com`.
- Do **not** add `Co-Authored-By` or session trailers for AI tools to commit messages.
- Small commits; message style `<area>: <what>` (e.g. `courses: mark lesson complete`).
