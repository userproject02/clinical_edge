# Test cases

One row per test case, linked to a requirement ID in `docs/REQUIREMENTS.md`. Test ID format: `TC-<REQ>-NN` (TC-LOG for the audit chain, TC-E2E for end-to-end journeys). Every requirement ID needs at least one **Passing** row before its phase closes. Status: Planned, Passing or Failing.

| Test ID | Requirement | Type | Case | Expected | Test file | Status |
| --- | --- | --- | --- | --- | --- | --- |
| TC-AUTH-1-01 | AUTH-1 | Widget | Sign in with empty email or password | Inline errors, no navigation | — | Planned |
| TC-AUTH-1-02 | AUTH-1 | Widget | Sign in with any non-empty password | Lands on the role's home; auth.signin usage event | — | Planned |
| TC-AUTH-2-01 | AUTH-2 | Widget | Switch role from sign-in and from Profile | Tabs and home change at once; role.change audit event | — | Planned |
| TC-AUTH-3-01 | AUTH-3 | Widget | Sign out from Profile | Back to sign-in, session cleared, auth.signout logged | — | Planned |
| TC-HOME-1-01 | HOME-1 | Widget | Learner home with seed data | 55% ring, 6/11 lessons, 26/40 credits, BLS 56 days; skeleton while loading | — | Planned |
| TC-CRS-1-01 | CRS-1 | Widget | Catalogue search and category chips | Filters the 3 seed courses; owned show progress, unowned show AED + VAT note | — | Planned |
| TC-CRS-2-01 | CRS-2 | Widget | Course detail CTA and lesson states | Continue / Start / Buy labels; locked lessons route to checkout | — | Planned |
| TC-CRS-3-01 | CRS-3 | Widget | Mark lesson complete | Progress updates everywhere; lesson.view and lesson.complete logged | — | Planned |
| TC-CRS-4-01 | CRS-4 | Unit | Finish all lessons of c1 | Credits 26 → 30; course.complete audit event | — | Planned |
| TC-QZ-1-01 | QZ-1 | Widget | Answer a question | Answer locks; correct/incorrect shown with explanation | — | Planned |
| TC-QZ-2-01 | QZ-2 | Unit | Score 7/8 and 6/8 | 88% pass, 75% fail; quiz.score audit event | — | Planned |
| TC-QZ-3-01 | QZ-3 | Widget | Score history | Newest first; best score and attempt count | — | Planned |
| TC-CERT-1-01 | CERT-1 | Unit | Expiry status at 91/90/1/0 days | Valid / Renew soon / Renew soon / Expired | — | Planned |
| TC-CERT-2-01 | CERT-2 | Unit | CPD meter vs ledger | Ring total equals ledger sum; target from config | — | Planned |
| TC-CERT-3-01 | CERT-3 | Widget | Upload certificate | Appears as Verifying; cert.upload audit event | — | Planned |
| TC-CERT-4-01 | CERT-4 | Unit | Reminder schedule and simulate | 90/60/30/7-day dates; banner shown; notify.reminder logged | — | Planned |
| TC-COMP-1-01 | COMP-1 | Widget | Learner requests sign-off | None → Pending; appears in supervisor queue; signoff.request audit | — | Planned |
| TC-COMP-2-01 | COMP-2 | Widget | Supervisor rejects without comment, then approves | Reject blocked; decision + comment on learner card; signoff.decision audit | — | Planned |
| TC-PAY-1-01 | PAY-1 | Unit | VAT and totals | AED 350→367.50, 250→262.50, 300→315.00 | — | Planned |
| TC-PAY-2-01 | PAY-2 | Widget | Successful purchase | Receipt with invoice no. and VAT line; course unlocks; purchase audit | — | Planned |
| TC-ADM-1-01 | ADM-1 | Widget | Cohort dashboard | KPIs and charts from repository data; live pending count | — | Planned |
| TC-ADM-2-01 | ADM-2 | Widget | Audit log filters | User, action, kind and date filters combine; hash link shown | — | Planned |
| TC-ADM-3-01 | ADM-3 | Unit | CSV export | RFC 4180 CSV of filtered rows; audit.export logged | — | Planned |
| TC-ADM-4-01 | ADM-4 | Unit | Usage insights | Built from usage events only, never audit events | — | Planned |
| TC-SET-1-01 | SET-1 | Widget | Language, theme, notifications | Apply instantly and persist across restarts | — | Planned |
| TC-LOG-01 | Audit | Unit | Edit a stored audit event | AuditChain.verify() reports the first broken event | — | Planned |
| TC-E2E-01 | All | Integration | Full demo journey across three roles | Every audit action appears in the log with a verified chain | — | Planned |
| TC-PH0-01 | Phase 0 | Script | context_guard.sh: app change without CLAUDE.md | Blocked in worktree, staged and range modes; passes when CLAUDE.md changes | `tool/ci/context_guard.sh` (manual + CI) | Passing |
| TC-PH0-02 | Phase 0 | Widget | App smoke test | Placeholder app renders the ClinicalEdge title | `test/app_smoke_test.dart` | Passing |
