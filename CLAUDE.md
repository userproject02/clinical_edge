@AGENTS.md

# ClinicalEdge — project context

> Read this before every change. Update it in the same commit as every change.

## Product in one paragraph

Flutter mobile app (iOS + Android only) for UAE healthcare professionals to take courses and quizzes, track certifications and CPD/CME credits, and get competencies signed off by supervisors, with an admin view of cohort progress and an append-only audit log. v1 is a clickable prototype on mock local data; every data source sits behind an interface so Firebase and a UAE payment gateway can replace the mocks later. Requirements: `docs/REQUIREMENTS.md`. Build plan: 11 phases (0–10).

## Current status

- Phase: **0 of 10 done** — Repo and context files
- Done: 0 Repo and context (AGENTS.md, CLAUDE.md, subagents, TESTCASES.md, Claude Code hooks, lefthook, CI)
- App code: placeholder `ClinicalEdgeApp` only (no features yet)
- Last updated: 2026-11-17 · claude/gurus-macbook-air

## Module map

| Feature | Entry route | Providers | Repository | Tests |
| --- | --- | --- | --- | --- |
| app shell | — | — | — | test/app_smoke_test.dart |

Phase 1 adds the router, theme and shared widgets; later phases add one row per feature (auth, home, courses, assessments, certifications, competencies, checkout, admin, settings).

## Do-not-break contracts

None are implemented yet. These become contracts as they land (change only with a `BREAKING` log line):

- Repository interfaces in `lib/features/*/data/*_repository.dart`
- Route paths in `lib/app/router.dart` (table in `docs/REQUIREMENTS.md` → Navigation and screens)
- `ActivityEvent` fields and action names (audit hash chain and CSV export depend on them)
- Seed JSON schema in `lib/seed/`
- `PaymentGateway` interface and `PaymentResult` variants
- Money in integer fils; VAT = round(subtotal * 5 / 100)

## Decisions (newest first)

- 2026-11-17 · Kept the existing `clinical_edge` project and package name (created with the current Flutter template that uses `package:material_ui`). Why: avoid churn; the name is used in imports.
- 2026-11-17 · Removed web, linux, macos and windows targets. Why: v1 is iOS + Android only.
- 2026-11-17 · Bundle IDs `ae.clinicaledge.clinicalEdge` (iOS) and `ae.clinicaledge.clinical_edge` (Android); Android minSdk 26, iOS 15. Why: requirements NFR "Platforms".
- 2026-11-17 · Lints: `very_good_analysis` replaces `flutter_lints`. Why: stricter, matches requirements.
- 2026-11-17 · SDK pinned to Flutter 3.50.0 stable (Dart 3.14) locally and in CI. Why: reproducible builds; the template needs Dart ^3.14.

## Known issues / TODO

- [ ] `docs/design/` screenshots of the prototype still to be added (needed from Phase 1).
- [ ] Push to GitHub and enable branch protection with the CI checks required.

## Next up

Phase 1 — Scaffold and design system: themes (light/dark tokens), fonts, EN/AR + RTL, go_router role shells, shared widgets, motion constants.

## Change log (newest first; last 30 entries, older in docs/changelog/)

- 2026-11-17 · claude/gurus-macbook-air · CI pinned to Flutter 3.50.0 stable; removed one-off bootstrap script · .github/workflows/ci.yml, CLAUDE.md · match local SDK
- 2026-11-17 · claude/gurus-macbook-air · Phase 0: AGENTS.md, CLAUDE.md, subagents, TESTCASES.md, hooks, lefthook, CI, placeholder app, iOS/Android only · repo root, .claude/, tool/, .github/, docs/ · bootstrap context so any session can work safely

## Commands

`flutter pub get` · `flutter analyze` · `dart format .` · `flutter test` · `dart run build_runner build -d` · `tool/ci/context_guard.sh worktree` · `lefthook install`
