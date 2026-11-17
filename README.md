# ClinicalEdge

ClinicalEdge is a Flutter mobile app (iOS and Android) for healthcare professionals in the UAE. Learners take courses and quizzes, track certifications and CPD/CME credits, and get competencies signed off by supervisors. Admins see cohort progress and an append-only, hash-chained audit log. The app is bilingual (English and Arabic, full RTL) with light and dark themes.

**This is v0.1.0, a clickable prototype.** It runs entirely on mock, local data.

| Mocked in v1 | How |
| --- | --- |
| Sign-in and roles | Any email and non-empty password; a demo role switcher (Learner, Supervisor, Admin) on sign-in and in Profile |
| Data | Seed JSON in `lib/seed/`, persisted on the device with Hive. Repositories add 300–900 ms of latency to show loading states |
| Payments | `MockGateway`: succeeds after 1.5 s; the debug menu can force a decline or 3-D Secure. Apple Pay is a mock sheet |
| Notifications | Expiry reminders are scheduled as real local notifications; "Simulate expiry reminder" shows an in-app banner. There is no push |
| File pick | Real file picker on a device; the iOS simulator uses a sample file, `NRP_certificate.pdf` |
| Audit and analytics | A local hash-chained audit store and a separate usage store |

There is no patient data anywhere in the app.

## Quick start on a new laptop

```sh
bash tool/setup.sh
```

See [DEPLOY.md](DEPLOY.md) for setup details and deploying builds to Google Cloud, and [FEATURES.md](FEATURES.md) for a one-page tour of every screen.

## Prerequisites

- Flutter **3.50.0** stable (Dart 3.14). CI uses the same version.
- Xcode 16 or later with an iOS simulator. iOS 15 is the minimum.
- Android Studio with an emulator (API 26+). Android 8.0 is the minimum. The project builds with JDK 17.
- Optional: `lefthook` for git hooks (`brew install lefthook`).

## Setup

```sh
flutter pub get
dart run build_runner build -d
lefthook install
```

## Run

```sh
flutter emulators --launch apple_ios_simulator   # or open Simulator
flutter run -d <iOS simulator id>
flutter run -d <Android emulator id>               # e.g. emulator-5554
```

## Demo walkthrough

The demo clock is fixed at 17 Nov 2026 09:00 (Dubai), so expiries always read the same. You can switch to the device clock from the debug menu.

| Role | Seed user | Try |
| --- | --- | --- |
| Learner | Dr. Layla Haddad, Resident · Internal Medicine | Home (55 % overall, BLS expires in 56 days, 26/40 credits) → Learn → BLS Refresher → finish lessons 5–6 (+4 credits) → Assess → BLS quiz (pass mark 80 %) → Certs → Simulate expiry reminder → Upload NRP → Sign-offs → Request IV cannulation → Learn → Medication Safety → Buy (AED 315.00, test card 4242 4242 4242 4242, any future expiry, any CVC) → receipt and Share PDF |
| Supervisor | Dr. Omar Al Mansoori, Consultant · Emergency Medicine | Queue → open a request → Reject without a comment (blocked) → Approve or reject with a comment → Decided |
| Admin | Sara Khan, Education & Compliance Admin | Cohort charts and learners → Audit log (verified hash chain, filters, Export CSV) → Insights |

To switch roles or languages, use Profile & settings (tap the avatar). Arabic mirrors the whole app.

**Reset demo data:** open the debug menu (debug builds) and choose *Reset demo data*. This wipes local data and seeds it again. Installing a build with a newer seed version also resets the data.

## Tests

```sh
flutter analyze
dart format --output=none --set-exit-if-changed .
flutter test                                  # unit, widget, a11y, privacy, goldens
flutter test --exclude-tags golden            # on macOS (goldens are generated on Linux)
flutter test --update-goldens --tags golden   # regenerate goldens (Linux)
flutter test integration_test -d <device>     # device journeys incl. TC-E2E-01
```

Every requirement ID maps to test cases in [docs/TESTCASES.md](docs/TESTCASES.md).

## Project structure

```
lib/
  main.dart            ProviderScope + overrides (mocks now, Firebase later)
  app/                 app shell, router (role shells), theme, l10n (ARB), state
  core/                logging (audit chain, usage), payments, notifications,
                       sharing, persistence, clock, money, motion, widgets/
  features/<feature>/  data/ (repository interfaces + mocks), domain/ (models,
                       use cases), presentation/ (screens, providers)
  seed/                demo data (JSON) and the seeder
test/                  unit, widget, golden, a11y and privacy tests
integration_test/      device journeys (TC-E2E-01 and others)
docs/                  REQUIREMENTS.md, TESTCASES.md, changelog/
```

Read `AGENTS.md` (rules) and `CLAUDE.md` (current context) before changing code.

## Swapping mocks for Firebase

Widgets never call repositories. Every data source is an interface whose Riverpod provider throws unless it is overridden. `lib/app/mock_overrides.dart` is the single list that plugs in the mocks. Going to production means writing new implementations, for example `FirestoreCourseRepository` or a `NetworkInternationalGateway`, and a second override list used by `main.dart`. No widget changes:

```dart
ProviderContainer(overrides: [
  courseRepositoryProvider.overrideWith((ref) => FirestoreCourseRepository(...)),
  paymentGatewayProvider.overrideWith((ref) => NetworkInternationalGateway(...)),
  activityLoggerProvider.overrideWith((ref) => FirebaseActivityLogger(...)),
  // ...
]);
```

## What to build next for production

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

- Which licensing authorities and CPD rules must the credit meter follow (DHA, DoH Abu Dhabi, MOHAP), and what is the real target per profession?
- Will sign-in use hospital SSO or ClinicalEdge accounts?
- Which payment gateway and which tax registration (TRN) will issue invoices?
- Must certificate uploads be verified by an admin, and who owns that queue?
- How long must audit events be retained, and who can export them?
- Does any content need to be fully translated into Arabic, beyond the app's own interface?

Also needed before real use: a clinical review of the question bank and checklists, a native Arabic medical review of all copy, and an Arabic font in the receipt PDF.
