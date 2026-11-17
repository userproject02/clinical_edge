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
| TC-PH0-02 | Phase 0 | Widget | App smoke test | App boots to the sign-in placeholder with the ClinicalEdge title (updated in Phase 1) | `test/app_smoke_test.dart` | Passing |
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
| TC-PH1-51 | Phase 1 | Integration | On device | Roles, dark mode and Arabic RTL on a simulator/emulator | `integration_test/scaffold_test.dart` | Planned (device) |
| TC-PH1-52 | NFR Design system | Golden | 18 shared-widget compositions × light/dark × LTR/RTL (72 images) | Pixel match within 0.5 % | `test/core/widgets/*_test.dart` → `test/core/widgets/goldens/` | Passing |
