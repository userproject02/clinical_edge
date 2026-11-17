# ClinicalEdge features (v0.1.0)

This is a high-level, end-to-end tour of every screen and what it does. All data is mock and local. Each screen works in English and Arabic (RTL) and in light and dark themes.

## Everyone

| Screen | What it does |
| --- | --- |
| **Sign in** `/sign-in` | Email + password (any password works in the demo), demo role picker, language toggle. Logs `auth.signin`. |
| **Profile & settings** `/profile` | Switch role (writes the `role.change` audit event), language, light/dark theme, reminders switch, sign out (`auth.signout`). |

## Learner

| Screen | What it does |
| --- | --- |
| **Home** `/home` | Overall progress ring + resume, expiry alert, CPD meter, continue-learning carousel, recent quiz scores, sign-off status. |
| **Courses** `/learn` | Catalogue with search and category chips; owned vs priced courses. Opening a course logs `course.view`. |
| **Course detail** `/learn/:id` | Header, progress, lesson list (done / now / locked), sticky Start · Continue · Review · Buy button. |
| **Lesson player** `/learn/:id/lesson/:n` | Video, PDF or reading placeholder; Mark complete. Finishing a course awards CPD credits and writes `course.complete`. |
| **Assess** `/assess` | BLS quiz card (pass mark, best score, attempts), score history; IPC quiz unlocks after its course. |
| **Quiz** `/assess/:id/run` | 8 questions, one tap locks the answer, instant right/wrong + explanation, leave confirmation. Result ring, pass at 80 %; writes `quiz.score`. |
| **Certs** `/certs` | CPD ring vs target, ledger, certifications with expiry status and days left, reminders switch, Simulate reminder (banner + local notification, `notify.reminder`). |
| **Upload certificate** `/certs/upload` | Pick a file (mock on simulator), name, issue/expiry dates → saved as Verifying; writes `cert.upload`. |
| **Sign-offs** `/signoffs` | Competency checklists; Request sign-off (`signoff.request`); see pending, approved or returned with the supervisor's comment. |
| **Checkout** `/learn/:id/checkout` | Order summary with 5 % VAT, card (Luhn/expiry/CVC checks, never stored or logged) or mock Apple Pay, decline + 3-D Secure paths. Logs `checkout.start`. |
| **Receipt** `/learn/:id/receipt/:order` | Tax invoice (sequential number), Share PDF, Start course. Payment unlocks the course and writes `purchase`. |

## Supervisor

| Screen | What it does |
| --- | --- |
| **Queue** `/queue` | Pending requests with stats (pending, this month, turnaround); tab badge. |
| **Review** `/queue/:id` | Learner and checklist, comment field. Reject needs a comment, Approve works without one; writes `signoff.decision`. |
| **Decided** `/decided` | Approved and returned requests, newest first. |

## Admin

| Screen | What it does |
| --- | --- |
| **Cohort** `/cohort` | KPIs (live pending sign-offs), completion and department charts, expiries by month, learner list. |
| **Audit log** `/audit` | Hash-chain check banner, filters (kind, period, user, action, search), Export CSV (`audit.export`). |
| **Insights** `/insights` | Most-used courses, lesson drop-off, pass rates, platform split. Built from usage events only. |

## Under the hood

- **Architecture:** screens → Riverpod providers → use cases → repository interfaces. Mocks are wired in one place (`lib/app/mock_overrides.dart`) and can be swapped for Firebase without touching screens.
- **Audit:** append-only, SHA-256 hash-chained store for audit events. Usage analytics are kept separately.
- **Payments:** `PaymentGateway` with `MockGateway`; money is integer fils, VAT is 5 %.
- **Reminders:** at 90/60/30/7 days before expiry, scheduled as real local notifications.
- **Tests:** 191 unit/widget/a11y/privacy tests, golden screenshots, and an end-to-end journey on iOS and Android (`integration_test/`).
