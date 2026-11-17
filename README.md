# ClinicalEdge

Training, certification and CPD/CME progress tracking for healthcare professionals in the UAE (physicians, residents, nurses, midwives). Flutter, iOS and Android.

**Status:** v1 prototype in progress — Phase 0 (repo and context files) done. See `CLAUDE.md` → Current status.

## Start here

- `docs/REQUIREMENTS.md` — requirements and architecture (requirement IDs such as AUTH-1, CRS-3).
- `AGENTS.md` — rules for every coding agent and person: architecture, conventions, logging rules, commands, change protocol, phase gate.
- `CLAUDE.md` — live project context: status, module map, contracts, decisions, known issues, change log. **Update it in the same commit as every change.**
- `docs/TESTCASES.md` — test case catalogue linked to requirement IDs.

## Setup

```sh
flutter pub get
brew install lefthook
lefthook install
flutter test
flutter run
```

Full setup, demo walkthrough and the production roadmap arrive in Phase 10.
