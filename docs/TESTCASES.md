# Test cases

One row per test case, linked to a requirement ID in `docs/REQUIREMENTS.md`. Test ID format: `TC-<REQ>-NN` (TC-LOG for the audit chain, TC-E2E for end-to-end journeys). Every requirement ID needs at least one **Passing** row before its phase closes. Status: Planned, Passing or Failing.

| Test ID | Requirement | Type | Case | Expected | Test file | Status |
| --- | --- | --- | --- | --- | --- | --- |
| TC-AUTH-1-01 | AUTH-1 | Widget | Sign in with empty email or password | Inline errors under each empty field; stays on /sign-in; no session | `test/features/auth_settings_test.dart` | Passing |
| TC-AUTH-1-02 | AUTH-1 | Widget | Sign in with any non-empty password | Learner → /home, supervisor → /queue, admin → /cohort; email pre-filled per role; ~900 ms skeleton; greeting + first name; auth.signin logged | `test/features/auth_settings_test.dart` | Passing |
| TC-AUTH-2-01 | AUTH-2 | Widget | Switch role from sign-in and from Profile | Profile switch: session + tabs change, stays on Profile, snackbar "Role switched · Now viewing as …", audit role.change "Learner → Supervisor (demo)" | `test/features/auth_settings_test.dart` | Passing |
| TC-AUTH-3-01 | AUTH-3 | Widget | Sign out from Profile | Back to /sign-in, session cleared (also after restart), auth.signout logged | `test/features/auth_settings_test.dart` | Passing |
| TC-HOME-1-01 | HOME-1 | Widget | Learner home with seed data | 55% ring, 6 of 11 lessons · 2 courses, 26 / 40, BLS 56 days, resume lesson 5, carousel tag, scores 63/75, sign-off tags; skeleton on first load (TC-AUTH-1-02) | `test/features/courses_test.dart` | Passing |
| TC-CRS-1-01 | CRS-1 | Widget | Catalogue search and category chips | Category chips and search filter the 3 seed courses; unowned shows AED 300.00 + "+5% VAT"; tap logs course.view | `test/features/courses_test.dart` | Passing |
| TC-CRS-2-01 | CRS-2 | Widget | Course detail CTA and lesson states | Continue · lesson 5 / 3, Buy · AED 315.00 (incl. VAT), Locked lessons route to checkout | `test/features/courses_test.dart` | Passing |
| TC-CRS-3-01 | CRS-3 | Widget | Mark lesson complete | Mark complete advances to the next lesson; lesson.view + lesson.complete logged; home ring 64 %, 7 of 11, carousel update | `test/features/courses_test.dart` | Passing |
| TC-CRS-4-01 | CRS-4 | Unit | Finish all lessons of c1 | Finishing c1: snackbar "+4 CPD/CME credits added", course.complete audit, CPD 26 → 30, CTA Review course | `test/features/courses_test.dart` | Passing |
| TC-QZ-1-01 | QZ-1 | Widget | Answer a question | Answer locks; correct/incorrect shown with explanation (covered by TC-QZ-1-03) | `test/features/assessments_test.dart` | Passing |
| TC-QZ-2-01 | QZ-2 | Unit | Score 7/8 and 6/8 | 88% pass, 75% fail; quiz.score audit event (covered by TC-QZ-2-03) | `test/features/assessments_test.dart` | Passing |
| TC-QZ-3-01 | QZ-3 | Widget | Score history | Newest first; best score and attempt count (covered by TC-QZ-3-04, TC-QZ-2-05) | `test/features/assessments_test.dart` | Passing |
| TC-CERT-1-01 | CERT-1 | Unit | Expiry status at 91/90/1/0 days | Valid / Renew soon / Renew soon / Expired; BLS 56 days renew soon, ACLS 317 valid on the demo clock; uploaded → Verifying | `test/features/repositories_test.dart` | Passing |
| TC-CERT-2-01 | CERT-2 | Unit | CPD meter vs ledger | Total (26) equals ledger sum; target 40 from cpd.json config | `test/features/repositories_test.dart` | Passing |
| TC-CERT-3-01 | CERT-3 | Widget | Upload certificate | Appears as Verifying; cert.upload audit event (covered by TC-CERT-3-04) | `test/features/certifications_test.dart` | Passing |
| TC-CERT-4-01 | CERT-4 | Unit | Reminder schedule and simulate | 90/60/30/7-day dates; banner shown; notify.reminder logged (covered by TC-CERT-4-03, TC-CERT-4-05) | `test/features/certifications_test.dart` | Passing |
| TC-COMP-1-01 | COMP-1 | Widget | Learner requests sign-off | None → Pending; appears in supervisor queue; signoff.request audit | `test/features/competencies_test.dart` | Passing |
| TC-COMP-2-01 | COMP-2 | Widget | Supervisor rejects without comment, then approves | Reject blocked; decision + comment on learner card; signoff.decision audit | `test/features/competencies_test.dart` | Passing |
| TC-PAY-1-01 | PAY-1 | Unit | VAT and totals (fils) | 35000→1750→36750, 25000→1250→26250, 30000→1500→31500 | `test/core/money_clock_test.dart` | Passing |
| TC-PAY-2-01 | PAY-2 | Widget | Successful purchase | Receipt with invoice no. and VAT line; course unlocks; purchase audit | `test/features/checkout_test.dart` | Passing |
| TC-ADM-1-01 | ADM-1 | Widget | Cohort dashboard | KPIs and charts from repository data; live pending count | — | Planned |
| TC-ADM-2-01 | ADM-2 | Widget | Audit log filters | User, action, kind and date filters combine; hash link shown | — | Planned |
| TC-ADM-3-01 | ADM-3 | Unit | CSV export | RFC 4180 CSV of filtered rows; audit.export logged | — | Planned |
| TC-ADM-4-01 | ADM-4 | Unit | Usage insights | Built from usage events only, never audit events | — | Planned |
| TC-SET-1-01 | SET-1 | Widget | Language, theme, notifications | Theme, notifications and language apply instantly (RTL mirrors) and survive a restart | `test/features/auth_settings_test.dart` | Passing |
| TC-LOG-01 | Audit | Unit | Append, verify, edit and remove stored audit events | Chain verifies; an edited event is reported as content break, a removed one as link break, at the right index | `test/core/logging_test.dart` | Passing |
| TC-E2E-01 | All | Integration | Full demo journey across three roles | Every audit action appears in the log with a verified chain | — | Planned |
| TC-PH0-01 | Phase 0 | Script | context_guard.sh: app change without CLAUDE.md | Blocked in worktree, staged and range modes; passes when CLAUDE.md changes | `tool/ci/context_guard.sh` (manual + CI) | Passing |
| TC-PH0-02 | Phase 0 | Widget | App smoke test | App boots with the mock overrides to the sign-in placeholder (updated in Phases 1 and 2) | `test/app_smoke_test.dart` | Passing |
| TC-PH1-01 | NFR Localisation | Unit | AED formatting | AED 315.00 (en), 315.00 د.إ (ar), LTR-isolated | `test/core/formatting_and_motion_test.dart` | Passing |
| TC-PH1-02 | NFR Localisation | Unit | Percent, integer, dates | Western digits, locale month names | `test/core/formatting_and_motion_test.dart` | Passing |
| TC-PH1-03 | NFR Motion | Widget | Reduced motion | Motion.duration returns zero when disableAnimations | `test/core/formatting_and_motion_test.dart` | Passing |
| TC-PH1-04 | NFR Motion | Unit | Motion constants | Durations and curve match the prototype | `test/core/formatting_and_motion_test.dart` | Passing |
| TC-PH1-05 | NFR Motion | Widget | Push transition direction | Slides from the end edge; mirrored in RTL | `test/core/formatting_and_motion_test.dart` | Passing |
| TC-PH1-06 | NFR Motion | Widget | Shake | Moves sideways then settles | `test/core/formatting_and_motion_test.dart` | Passing |
| TC-PH1-07 | NFR Design system | Unit | Colour tokens | Light/dark/hero/course tokens match the prototype | `test/app/theme_test.dart` | Passing |
| TC-PH1-08 | NFR Design system | Unit | ColorScheme + AppColors | Scheme roles and extension built from tokens; Material 3 | `test/app/theme_test.dart` | Passing |
| TC-PH1-09 | NFR Design system | Unit | Typography | Type scale; Inter vs IBM Plex Sans Arabic; no tracking in Arabic | `test/app/theme_test.dart` | Passing |
| TC-PH1-10 | NFR Design system | Widget | AppScaffold tab bar | Subtitle, title, bell, avatar callbacks | `test/core/widgets/app_scaffold_test.dart` | Passing |
| TC-PH1-11 | NFR Localisation | Widget | AppScaffold detail back arrow | Arrow on the start edge, mirrors in RTL, pops | `test/core/widgets/app_scaffold_test.dart` | Passing |
| TC-PH1-12 | NFR Design system | Widget | AppScaffold coloured detail bar | Uses the given colour | `test/core/widgets/app_scaffold_test.dart` | Passing |
| TC-PH1-13 | NFR Design system | Widget | BottomNavBar | Selects, badge with semantics | `test/core/widgets/bottom_nav_bar_test.dart` | Passing |
| TC-PH1-14 | NFR Accessibility | Widget | PrimaryButton | 52 dp, stadium, tappable | `test/core/widgets/buttons_test.dart` | Passing |
| TC-PH1-15 | NFR Design system | Widget | PrimaryButton loading | Spinner, same width, taps ignored, semantics | `test/core/widgets/buttons_test.dart` | Passing |
| TC-PH1-16 | NFR Design system | Widget | SecondaryButton | Disabled when no handler; 52 dp | `test/core/widgets/buttons_test.dart` | Passing |
| TC-PH1-17 | NFR Accessibility | Widget | SegmentedPicker | Selects; ≥ 48 dp | `test/core/widgets/pickers_test.dart` | Passing |
| TC-PH1-18 | NFR Localisation | Widget | SegmentedPicker RTL | Order follows text direction | `test/core/widgets/pickers_test.dart` | Passing |
| TC-PH1-19 | NFR Design system | Widget | FilterChipRow | Selects; horizontal scroll | `test/core/widgets/pickers_test.dart` | Passing |
| TC-PH1-20 | NFR Design system | Widget | StatusTag tones | Foreground/background per tone | `test/core/widgets/status_and_tiles_test.dart` | Passing |
| TC-PH1-21 | NFR Design system | Widget | StatTile | Label, value, caption, tap | `test/core/widgets/status_and_tiles_test.dart` | Passing |
| TC-PH1-22 | NFR Design system | Widget | EmptyState | Title, message, action | `test/core/widgets/status_and_tiles_test.dart` | Passing |
| TC-PH1-23 | NFR Motion | Widget | ProgressRing sweep | 100 ms delay, 1.3 s sweep, semantics label + value | `test/core/widgets/meters_test.dart` | Passing |
| TC-PH1-24 | NFR Accessibility | Widget | ProgressRing label at 1.3× text | One line, never wraps, stays centred | `test/core/widgets/meters_test.dart` | Passing |
| TC-PH1-25 | NFR Motion | Widget | ProgressRing reduced motion | Final value drawn at once | `test/core/widgets/meters_test.dart` | Passing |
| TC-PH1-26 | NFR Localisation | Widget | LinearMeter direction | Grows from left (LTR) / right (RTL) | `test/core/widgets/meters_test.dart` | Passing |
| TC-PH1-27 | NFR Motion | Widget | LinearMeter growth | Animates over ~1.15 s | `test/core/widgets/meters_test.dart` | Passing |
| TC-PH1-28 | NFR Motion | Widget | AppSnackBar | Slides up, stays, auto-dismisses | `test/core/widgets/feedback_test.dart` | Passing |
| TC-PH1-29 | NFR Motion | Widget | NotificationBanner | Drops from top, auto-dismisses | `test/core/widgets/feedback_test.dart` | Passing |
| TC-PH1-30 | NFR Motion | Widget | AppBottomSheet | Opens over scrim; scrim tap closes | `test/core/widgets/feedback_test.dart` | Passing |
| TC-PH1-31 | NFR Accessibility | Widget | EcgLine | Loops; excluded from semantics | `test/core/widgets/animated_decor_test.dart` | Passing |
| TC-PH1-32 | NFR Motion | Widget | Looping widgets + reduced motion | ECG, pulse, shimmer stop; skeleton static | `test/core/widgets/animated_decor_test.dart` | Passing |
| TC-PH1-33 | NFR Accessibility | Widget | SkeletonBox | Announces Loading | `test/core/widgets/animated_decor_test.dart` | Passing |
| TC-PH1-34 | NFR Accessibility | Unit | Text contrast | Every text/background token pair ≥ 4.5:1 in both themes | `test/app/theme_test.dart` | Passing |
| TC-PH1-35 | SET-1 (part) | Unit | Theme mode persistence | Defaults to system; saved and restored | `test/app/state_test.dart` | Passing |
| TC-PH1-36 | SET-1 (part) | Unit | Locale persistence | Defaults to English; toggles; saved and restored | `test/app/state_test.dart` | Passing |
| TC-PH1-37 | Phase 1 | Unit | Session stub | Sign in, switch role, sign out | `test/app/state_test.dart` | Passing |
| TC-PH1-38 | Phase 1 routing | Unit | Redirect signed out | Any route → /sign-in | `test/app/router_test.dart` | Passing |
| TC-PH1-39 | Phase 1 routing | Unit | Redirect signed in | /sign-in and / → role home | `test/app/router_test.dart` | Passing |
| TC-PH1-40 | Phase 1 routing | Unit | Wrong role | Other role's route → own home | `test/app/router_test.dart` | Passing |
| TC-PH1-41 | Phase 1 routing | Unit | Allowed routes | Every table route passes for its role | `test/app/router_test.dart` | Passing |
| TC-PH1-42 | Phase 1 routing | Widget | Cold start | Signed out starts on sign-in | `test/app/router_test.dart` | Passing |
| TC-PH1-43 | Phase 1 routing | Widget | Role shells | Learner 5 tabs, supervisor 3, admin 3; homes | `test/app/router_test.dart` | Passing |
| TC-PH1-44 | Phase 1 routing | Widget | Shared /learn | Supervisor /learn opens the supervisor Learn tab | `test/app/router_test.dart` | Passing |
| TC-PH1-45 | Phase 1 routing | Widget | Back from detail | Selects the tab the detail belongs to | `test/app/router_test.dart` | Passing |
| TC-PH1-46 | Phase 1 routing | Widget | Tab back stacks | Each tab keeps its own stack | `test/app/router_test.dart` | Passing |
| TC-PH1-47 | Phase 1 routing | Widget | Profile + upload sheet | Avatar pushes /profile; /certs/upload is a sheet | `test/app/router_test.dart` | Passing |
| TC-PH1-48 | NFR Localisation | Widget | Arabic app | Whole app RTL; tabs and back arrow mirrored | `test/app/router_test.dart` | Passing |
| TC-PH1-49 | Phase 1 routing | Widget | Placeholders | Every route shows its title | `test/app/router_test.dart` | Passing |
| TC-PH1-50 | Phase 1 routing | Widget | Sign out | Returns to sign-in | `test/app/router_test.dart` | Passing |
| TC-PH1-51 | Phase 1 | Integration | On device | Roles, dark mode and Arabic RTL on a simulator/emulator | `integration_test/scaffold_test.dart` | Passing (iOS simulator; Android pending) |
| TC-PH1-52 | NFR Design system | Golden | 18 shared-widget compositions × light/dark × LTR/RTL (72 images) | Pixel match within 0.5 % | `test/core/widgets/*_test.dart` → `test/core/widgets/goldens/` | Passing |
| TC-AUTH-1-03 | AUTH-1 | Unit | Mock auth repository | Empty fields → InvalidCredentials; any password signs in as the role's seed user; session persists; sign-out clears | `test/features/repositories_test.dart` | Passing |
| TC-HOME-1-02 | HOME-1 | Unit | Seed progress for the learner | Owns c1, c2; 6 of 11 lessons done; markComplete is idempotent and stamps the clock | `test/features/repositories_test.dart` | Passing |
| TC-QZ-1-02 | QZ-1 | Unit | BLS quiz draw | 8 resuscitation questions q01–q08, same order every time | `test/features/repositories_test.dart` | Passing |
| TC-QZ-2-02 | QZ-2 | Unit | Scoring rule | 7/8 = 88 % pass, 6/8 = 75 % fail, 5/8 = 63 %; pass mark 80 % | `test/features/repositories_test.dart` | Passing |
| TC-QZ-3-02 | QZ-3 | Unit | Attempt history | Seed 75 %, 63 % newest first; a new attempt goes on top | `test/features/repositories_test.dart` | Passing |
| TC-QZ-1-03 | QZ-1 | Widget | Start BLS, tap a wrong option, tap again | "Question 1 of 8", "Pass 80%", no bottom nav; Next disabled until answered; first tap locks (second tap ignored); "Not quite" + "Explanation: …"; correct pick shows "Correct" + check | `test/features/assessments_test.dart` | Passing |
| TC-QZ-1-04 | QZ-1 | Widget | Back after answering one question | "Leave assessment?" dialog; Stay keeps the quiz; Leave → /assess with nothing saved | `test/features/assessments_test.dart` | Passing |
| TC-QZ-1-05 | QZ-1 | Widget | Quiz in Arabic | Question and explanation from the Arabic seed; badges أ ب ج د | `test/features/assessments_test.dart` | Passing |
| TC-QZ-2-03 | QZ-2 | Unit | SubmitAttempt with 7/8 then 6/8 | 88 % pass, 75 % fail; attempts saved with answers and time; audit quiz.score "BLS Assessment · 88% (pass)" / "· 75% (fail)" | `test/features/assessments_test.dart` | Passing |
| TC-QZ-2-04 | QZ-2 | Unit | Edge scores | 0/8 = 0 %, 8/8 = 100 %, 6/7 = 86 % | `test/features/assessments_test.dart` | Passing |
| TC-QZ-2-05 | QZ-2 | Widget | Finish BLS with 7/8, Done, then 6/8 and Retake | Result 88 %, "7 / 8 correct", Passed, "Assessment passed", audit row; /assess shows best 88 %, 3 attempts, "Attempt 3" on top; Home recent scores 88 %; fail shows "Below pass mark"; Retake restarts at question 1 | `test/features/assessments_test.dart` | Passing |
| TC-QZ-3-03 | QZ-3 | Unit | Best score and attempt numbering | Best = max score; "Attempt N" counts oldest = 1 | `test/features/assessments_test.dart` | Passing |
| TC-QZ-3-04 | QZ-3 | Widget | Assess tab with seed data | "Basic Life Support", "8 questions · from a 20-question bank", pass 80 %, best 75 %, 2 attempts; history Attempt 2 (75 %, 20 Oct 2026) above Attempt 1 (63 %); IPC locked "Unlocks after all 5 lessons" | `test/features/assessments_test.dart` | Passing |
| TC-QZ-3-05 | QZ-3 | Widget | Complete all c2 lessons | IPC card unlocks; quiz runs 7 infection-control questions starting at q09 | `test/features/assessments_test.dart` | Passing |
| TC-QZ-G-01 | QZ-1..3 | Golden | Assess tab; question unanswered / correct / wrong; result pass / fail | 24 goldens, EN/AR × light/dark | `test/features/assessments_test.dart` | Passing (generated on macOS, regenerate on Linux) |
| TC-QZ-E2E-01 | QZ-1..3 | Integration | BLS quiz on device | 7/8 → "Assessment passed"; Done shows Attempt 3 (iOS simulator) | `integration_test/assessments_test.dart` | Passing |
| TC-CERT-3-02 | CERT-3 | Unit | Upload repository | Uploaded certificate stored as Verifying | `test/features/repositories_test.dart` | Passing |
| TC-CERT-1-03 | CERT-1 | Unit | Status at 91/90/1/0/-1 days on FixedClock, pending upload | Valid / Renew soon / Renew soon / Expired / Expired; pending → Verifying | `test/features/certifications_test.dart` | Passing |
| TC-CERT-1-04 | CERT-1 | Widget | Certs list with seed data | BLS: Renew soon, "Expires 12 Jan 2027", "56 days", meter 56/730; ACLS: Valid, 317 days | `test/features/certifications_test.dart` | Passing |
| TC-CERT-2-03 | CERT-2 | Widget | CPD card and ledger | Ring "26" = ledger sum, "of 40", "CPD/CME credits · 2026", "14 credits to reach your target", demo note; ledger newest first, "+2", "4 Nov 2026 · External" | `test/features/certifications_test.dart` | Passing |
| TC-CERT-2-04 | CERT-2 | Widget | Add a ledger line | Ring moves to 31, "9 credits to reach your target", new line listed | `test/features/certifications_test.dart` | Passing |
| TC-CERT-3-03 | CERT-3 | Unit | Upload validation | Name required, expiry required, expiry after issue; short name "NRP" | `test/features/certifications_test.dart` | Passing |
| TC-CERT-3-04 | CERT-3 | Widget | Upload sheet end to end | Errors on empty submit; mock file "NRP_certificate.pdf · 412 KB"; submit → /certs, snackbar "Certificate uploaded · NRP is pending verification", row Verifying; audit "… (NRP) · pending verification"; fileRef is a fake id without the file name | `test/features/certifications_test.dart` | Passing |
| TC-CERT-4-03 | CERT-4 | Unit | ReminderService | Future reminders only, 09:00 Dubai (05:00 UTC), pending certs skipped; BLS due; simulate falls back to next expiry | `test/features/certifications_test.dart` | Passing |
| TC-CERT-4-04 | CERT-4 | Widget | Reminders switch | Certs and Profile share one persisted switch; off clears the schedule; on asks permission and schedules 6 reminders with localized text | `test/features/certifications_test.dart` | Passing |
| TC-CERT-4-05 | CERT-4 | Widget | Simulate and bell | Banner "BLS certificate expires in 56 days" + "Renew before 12 Jan 2027 to stay compliant."; local notification only when the switch is on; notify.reminder "BLS · 56 days" | `test/features/certifications_test.dart` | Passing |
| TC-CERT-G-01 | CERT-1..3 | Golden | Certs tab and upload sheet | 8 goldens, EN/AR × light/dark | `test/features/certifications_test.dart` | Passing (generated on macOS, regenerate on Linux) |
| TC-CERT-E2E-01 | CERT-4 | Integration | Simulate reminder on a device with the real plugin | Banner shows and a local notification is posted | `integration_test/reminders_test.dart` | Planned (device run deferred) |
| TC-COMP-1-02 | COMP-1 | Unit | Request repository | none → pending, joins the queue; pending/approved cannot be re-requested | `test/features/repositories_test.dart` | Passing |
| TC-COMP-2-02 | COMP-2 | Unit | Decide repository | Reject without (or with blank) comment fails; approve records supervisor and time; decided list updated | `test/features/repositories_test.dart` | Passing |
| TC-COMP-1-03 | COMP-1 | Widget | Learner sign-offs tab, request cl1 | cl1 Not requested + "Goes to Dr. Omar Al Mansoori · Emergency Medicine"; cl2 Approved by Omar · 28 Oct 2026 with comment; request → Pending "Waiting for supervisor · requested 17 Nov 2026", snackbar "Sign-off requested · Sent to Dr. Omar Al Mansoori", audit signoff.request "Peripheral IV cannulation" | `test/features/competencies_test.dart` | Passing |
| TC-COMP-1-04 | COMP-1 | Unit | Permission rules | Supervisor cannot request; learner role cannot decide; nobody decides their own request; supervisor can | `test/features/competencies_test.dart` | Passing |
| TC-COMP-2-03 | COMP-2 | Widget | Supervisor queue | Pending 2, this month 2, turnaround 1.7d (computed from seed); oldest first; card shows name, title, "4 skills · requested 16 Nov 2026"; Queue tab badge 2 | `test/features/competencies_test.dart` | Passing |
| TC-COMP-2-04 | COMP-2 | Widget | Review: reject empty, approve empty, reject with comment | "A comment is required to reject." and nothing saved or logged; approve stores "Competent. Observed and signed off.", snackbar, audit "… · Aisha Rahman · approved"; reject with comment → "Returned with comments", audit "… · rejected" without the comment; empty queue "All caught up"; Decided newest first | `test/features/competencies_test.dart` | Passing |
| TC-COMP-2-05 | COMP-2 | Widget | Cross-role round trip | Layla's request appears in Omar's queue; Omar's rejection and comment show on Layla's card ("Returned by Dr. Omar Al Mansoori · 17 Nov 2026") and Home sign-off rows; she can resubmit | `test/features/competencies_test.dart` | Passing |
| TC-COMP-2-06 | COMP-2 | Widget | Router guard | Learner going to /queue or /queue/:id lands on /home | `test/features/competencies_test.dart` | Passing |
| TC-COMP-G-01 | COMP-1..2 | Golden | Sign-offs (none/approved, pending/rejected), queue, empty queue, review with error, decided | 24 goldens, EN/AR × light/dark | `test/features/competencies_test.dart` | Passing (generated on macOS, regenerate on Linux) |
| TC-PAY-1-02 | PAY-1 | Unit | Odd-fils VAT rounding | Half up (0.50 → 1, 1.45 → 1, 1.50 → 2), integer maths | `test/core/money_clock_test.dart` | Passing |
| TC-PAY-1-03 | PAY-1 | Unit | Money formatting | AED 315.00 (en), 315.00 د.إ (ar), grouping, negatives | `test/core/money_clock_test.dart` | Passing |
| TC-PAY-1-04 | PAY-1 | Unit | MockGateway default | Intent for the order total in AED; succeeds after exactly 1.5 s | `test/core/payments_test.dart` | Passing |
| TC-PAY-1-05 | PAY-1 | Unit | MockGateway debug modes | Forced Failed and Needs3ds results | `test/core/payments_test.dart` | Passing |
| TC-PAY-1-06 | PAY-1 | Unit | Order JSON | Order round-trips through JSON | `test/core/payments_test.dart` | Passing |
| TC-PAY-2-02 | PAY-2 | Unit | Checkout repository | Order 30000/1500/31500 fils; invoice CE-2026-001041 then 001042; seller TRN placeholder | `test/features/repositories_test.dart` | Passing |
| TC-PAY-1-07 | PAY-1 | Unit | VAT and totals for the three seed prices | 350 → 17.50 / 367.50; 250 → 12.50 / 262.50; 300 → 15.00 / 315.00 (fils, half up) | `test/features/checkout_test.dart` | Passing |
| TC-PAY-1-08 | PAY-1 | Unit | Card rules | Luhn pass/fail, grouping in 4s, expiry MM / YY not before this month, CVC 3–4 digits, last 4 | `test/features/checkout_test.dart` | Passing |
| TC-PAY-1-09 | PAY-1 | Widget | Checkout c3 with card | Summary "4 lessons · 2 CPD credits", AED 300.00 / 15.00 / 315.00; field errors; double tap → one order; receipt; course owned; audit purchase "Medication Safety & High-Alert Drugs · AED 315.00 · CE-2026-001041"; checkout.start logged; no card number, expiry or CVC in audit, usage or stored orders | `test/features/checkout_test.dart` | Passing |
| TC-PAY-1-10 | PAY-1 | Widget | Gateway declines, then 3-D Secure | Decline banner with retry (stays on checkout); 3DS Cancel → cancelled banner, not owned; 3DS Approve → receipt | `test/features/checkout_test.dart` | Passing |
| TC-PAY-2-03 | PAY-2 | Widget | Apple Pay (mock) | Black mock sheet, "Pay with Apple Pay · AED 315.00", receipt method "Apple Pay (mock)", catalogue no longer shows a price | `test/features/checkout_test.dart` | Passing |
| TC-PAY-2-04 | PAY-2 | Widget | Receipt fields and Start course | "Tax invoice CE-2026-001041 · 2026-11-17 09:00", seller "ClinicalEdge (demo) · TRN [YOUR TRN]", billed to Dr. Layla Haddad, "Card •••• 4242 (mock)", totals; Start course → lesson 1 (covered in TC-PAY-1-09) | `test/features/checkout_test.dart` | Passing |
| TC-PAY-G-01 | PAY-1..2 | Golden | Checkout card / Apple Pay / processing / error, receipt | 20 goldens, EN/AR × light/dark | `test/features/checkout_test.dart` | Passing (generated on macOS, regenerate on Linux) |
| TC-ADM-1-02 | ADM-1 | Unit | Cohort repository | Stats load, labelled demo figures | `test/features/repositories_test.dart` | Passing |
| TC-LOG-02 | Audit | Unit | Sanitiser rejects sensitive targets | Card numbers (13–19 digits, spaced or dashed), CVC, email, password rejected | `test/core/logging_test.dart` | Passing |
| TC-LOG-03 | Audit | Unit | Sanitiser passes labels | Invoice/amount/score labels pass; capped at 120 chars; exception never echoes the value | `test/core/logging_test.dart` | Passing |
| TC-LOG-04 | Audit | Unit | Hash formula | SHA-256 hex of prevHash|ts|userId|role|action|target|platform; ts normalised to UTC | `test/core/logging_test.dart` | Passing |
| TC-LOG-05 | Audit | Unit | Concurrent appends | 10 parallel appends keep one valid chain | `test/core/logging_test.dart` | Passing |
| TC-LOG-06 | Audit | Unit | Logger stamping | Logger fills id, ts (Clock), user, role, platform; audit and usage go to separate stores | `test/core/logging_test.dart` | Passing |
| TC-LOG-07 | Audit | Unit | Sensitive targets via logger | audit() throws; usage() drops and reports to CrashReporter | `test/core/logging_test.dart` | Passing |
| TC-LOG-08 | Audit | Unit | Action names | Wire names match the contract lists | `test/core/logging_test.dart` | Passing |
| TC-LOG-09 | Audit | Unit | Usage store is lossy | Keeps the newest N events | `test/core/logging_test.dart` | Passing |
| TC-SEED-01 | Seed | Unit | Seed files parse | Every file loads into its models; counts and totals match the brief | `test/seed/seed_test.dart` | Passing |
| TC-SEED-02 | Seed | Unit | Bilingual strings | Every {en, ar} pair non-empty; Arabic text present (pure numbers excepted) | `test/seed/seed_test.dart` | Passing |
| TC-SEED-03 | Seed | Unit | Required questions | The 8 specified questions are present with the right answers | `test/seed/seed_test.dart` | Passing |
| TC-SEED-04 | Seed | Unit | Demo time | demo.json demoNow equals the code constant | `test/seed/seed_test.dart` | Passing |
| TC-SEED-05 | Seed | Unit | No patient data | Staff-only users on the example domain; no identifiers such as MRN or Emirates ID | `test/seed/seed_test.dart` | Passing |
| TC-SEED-06 | Seed | Unit | Seeding | 10 historical audit events loaded through the store with a valid chain | `test/features/repositories_test.dart` | Passing |
| TC-PH2-01 | Phase 2 | Unit | Demo clock | 17 Nov 2026 09:00 Dubai = 05:00 UTC; Dubai calendar date | `test/core/money_clock_test.dart` | Passing |
| TC-PH2-02 | Phase 2 | Unit | Day counting | 56 days to 12 Jan 2027, 317 to 30 Sep 2027 | `test/core/money_clock_test.dart` | Passing |
| TC-PH2-03 | Phase 2 | Unit | SystemClock | Returns UTC | `test/core/money_clock_test.dart` | Passing |
| TC-PH2-04 | Phase 2 | Unit | Logger wiring | Session actor and demo clock stamped; chain stays valid | `test/features/repositories_test.dart` | Passing |
| TC-PH2-05 | Phase 2 | Unit | Persistence and reset | State survives a restart on the same DB; reset restores the seed and the audit chain | `test/features/repositories_test.dart` | Passing |
| TC-PH2-06 | Phase 2 | Unit | Clock switch | Debug clock mode switches to the device clock | `test/features/repositories_test.dart` | Passing |
| TC-PH2-07 | Phase 2 | Unit | Hive persistence | Seeded Hive boxes survive reopen; clearAll empties them | `test/core/hive_local_db_test.dart` | Passing |

| TC-AUTH-1-04 | AUTH-1 | Widget | Restart while signed in | Lands on the role home with the same user | `test/features/auth_settings_test.dart` | Passing |
| TC-AUTH-1-05 | AUTH-1 | Widget | Language toggle on sign-in | Switches to Arabic RTL at once | `test/features/auth_settings_test.dart` | Passing |
| TC-SET-1-02 | SET-1 | Unit | Greeting by clock | Morning before 12:00, afternoon before 17:00, evening after (Dubai time) | `test/features/auth_settings_test.dart` | Passing |
| TC-PH3-01 | Phase 3 | Golden | Sign-in and Profile & settings screens | Pixel match, EN/AR × light/dark (8 images) | `test/features/goldens/` | Passing |
| TC-CRS-1-02 | CRS-1 | Widget | Arabic search | Arabic query matches Arabic titles | `test/features/courses_test.dart` | Passing |
| TC-CRS-2-02 | CRS-2 | Widget | CTA rule | Start / Continue · lesson N / Review / Buy with VAT | `test/features/courses_test.dart` | Passing |
| TC-PH4-01 | Phase 4 | Golden | Home, catalogue, course detail, lesson video/reading/PDF | Pixel match, EN/AR × light/dark (24 images) | `test/features/courses_test.dart` | Passing |

## Review notes

- **Clinical review needed:** every question in `lib/seed/question_bank.json` (q01–q20, `reviewStatus` field), the explanations and the competency checklist items in `lib/seed/checklists.json` were written from the cited guidelines (AHA 2020 / ERC 2021, WHO hand hygiene 2009, CDC PPE and sharps guidance, ISMP, Joint Commission NPSG.01.01.01, WHO Medication Without Harm). A clinician must review them before any real use.
- **Arabic review needed:** all Arabic in `lib/seed/*.json` and `lib/app/l10n/app_ar.arb` is Modern Standard Arabic written for this prototype; a native-speaking medical translator should review it, especially clinical terms (الإنعاش القلبي الرئوي، مزيل الرجفان الخارجي الآلي، معدات الوقاية الشخصية، الأدوية عالية الخطورة).
- **Arabic number ranges:** seed options such as "60–80 ضغطة في الدقيقة" render as "80–60" in RTL (bidi reorders the digits around the dash). Wrap numeric ranges in LTR isolates in the seed text or at render time.
- **Demo figures:** `lib/seed/cohort.json` (KPIs, charts, learner completion) and the CPD target of 40 are invented demo values and are labelled as such in the data (`demoFigures`, `targetIsDemo`).
