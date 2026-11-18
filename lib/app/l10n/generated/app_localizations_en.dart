// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ClinicalEdge';

  @override
  String get brandTag => 'Training · Certification · CPD';

  @override
  String get tenant => 'Demo Health Network · Dubai';

  @override
  String get navHome => 'Home';

  @override
  String get navLearn => 'Learn';

  @override
  String get navAssess => 'Assess';

  @override
  String get navCerts => 'Certs';

  @override
  String get navSignoffs => 'Sign-offs';

  @override
  String get navQueue => 'Queue';

  @override
  String get navDecided => 'Decided';

  @override
  String get navCohort => 'Cohort';

  @override
  String get navAudit => 'Audit';

  @override
  String get navInsights => 'Insights';

  @override
  String get titleSignIn => 'Sign in';

  @override
  String get titleHome => 'Home';

  @override
  String get titleCourses => 'Courses';

  @override
  String get titleCourseDetail => 'Course';

  @override
  String get titleLesson => 'Lesson';

  @override
  String get titleCheckout => 'Checkout';

  @override
  String get titleReceipt => 'Receipt';

  @override
  String get titleAssessments => 'Assessments';

  @override
  String get titleQuiz => 'Quiz';

  @override
  String get titleCerts => 'Certifications & CPD';

  @override
  String get titleUploadCert => 'Upload certificate';

  @override
  String get titleCompetencies => 'Competencies';

  @override
  String get titleQueue => 'Sign-off queue';

  @override
  String get titleReview => 'Review sign-off';

  @override
  String get titleDecided => 'Recently decided';

  @override
  String get titleCohort => 'Cohort dashboard';

  @override
  String get titleAudit => 'Audit log';

  @override
  String get titleInsights => 'Usage insights';

  @override
  String get titleProfile => 'Profile & settings';

  @override
  String get placeholderBody => 'This screen arrives in a later phase.';

  @override
  String get actionBack => 'Back';

  @override
  String get actionClose => 'Close';

  @override
  String get actionNotifications => 'Notifications';

  @override
  String get actionProfile => 'Profile and settings';

  @override
  String get loading => 'Loading';

  @override
  String get roleLearner => 'Learner';

  @override
  String get roleSupervisor => 'Supervisor';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get notificationAppName => 'CLINICALEDGE';

  @override
  String get notificationNow => 'now';

  @override
  String get notificationsEmptyTitle => 'You\'re all caught up';

  @override
  String get notificationsEmptyBody => 'Expiry reminders will appear here.';

  @override
  String navBadge(int count) {
    return '$count new';
  }

  @override
  String aedAmount(String amount) {
    return 'AED $amount';
  }

  @override
  String get debugMenu => 'Debug menu';

  @override
  String get debugRoutes => 'Jump to route';

  @override
  String get debugClock => 'Clock';

  @override
  String get debugClockDemo => 'Demo date';

  @override
  String get debugClockSystem => 'Device';

  @override
  String get debugGateway => 'Mock payment';

  @override
  String get debugGatewaySucceed => 'Succeed';

  @override
  String get debugGatewayFail => 'Fail';

  @override
  String get debugGateway3ds => '3-D Secure';

  @override
  String get debugReset => 'Reset demo data';

  @override
  String get debugResetDone => 'Demo data reset';

  @override
  String get heroHeadline =>
      'Clinical training that keeps every licence current.';

  @override
  String get heroBody =>
      'Courses, assessments, certifications and competency sign-off for UAE healthcare teams.';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get signInEmail => 'Work email';

  @override
  String get signInPassword => 'Password';

  @override
  String get signInDemoRole => 'Demo role';

  @override
  String get signInButton => 'Sign in';

  @override
  String get signInDemoNote =>
      'Demo build: any password works. No real authentication.';

  @override
  String get signInEmailRequired => 'Enter your work email';

  @override
  String get signInPasswordRequired => 'Enter your password';

  @override
  String get signInShowPassword => 'Show password';

  @override
  String get signInHidePassword => 'Hide password';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get roleSwitchedTitle => 'Role switched';

  @override
  String roleSwitchedBody(String name) {
    return 'Now viewing as $name';
  }

  @override
  String get settingsPush => 'Push notifications';

  @override
  String get settingsPushBody => 'Expiry reminders and sign-off decisions';

  @override
  String get settingsHoodTitle => 'Under the hood · Flutter';

  @override
  String get settingsHoodFeatureFirst => 'Feature-first';

  @override
  String get settingsHoodMockRepos => 'Mock repositories';

  @override
  String get settingsHoodBody =>
      'Each feature reads through a repository interface; mock implementations swap for Firebase later without touching the UI.';

  @override
  String get signOut => 'Sign out';

  @override
  String get appVersion => 'ClinicalEdge 0.1.0 (prototype) · mock data only';

  @override
  String get homeOverall => 'Overall progress';

  @override
  String homeLessonsSummary(int done, int total, int courses) {
    return '$done of $total lessons · $courses courses';
  }

  @override
  String homeResume(String title) {
    return 'Resume: $title';
  }

  @override
  String get homeAllDone => 'All lessons complete';

  @override
  String homeExpiryTitle(String code, int days) {
    return '$code expires in $days days';
  }

  @override
  String homeRenewBefore(String date) {
    return 'Renew before $date';
  }

  @override
  String homeCredits(String cycle) {
    return 'CPD/CME credits · $cycle';
  }

  @override
  String homeCreditsToGo(int left, String date) {
    return '$left credits to go · cycle ends $date';
  }

  @override
  String homeCreditsReached(String date) {
    return 'Target reached · cycle ends $date';
  }

  @override
  String get homeContinue => 'Continue learning';

  @override
  String get homeViewAll => 'View all';

  @override
  String get homeRecentScores => 'Recent scores';

  @override
  String get homePassLine => 'Pass 80%';

  @override
  String get homeNoScores => 'No attempts yet';

  @override
  String get homeSignoffs => 'Supervisor sign-off';

  @override
  String lessonOfTotal(int n, int total) {
    return 'Lesson $n of $total';
  }

  @override
  String get courseCompleted => 'Completed';

  @override
  String get signoffNone => 'Not requested';

  @override
  String get signoffPending => 'Pending';

  @override
  String get signoffApproved => 'Approved';

  @override
  String get signoffRejected => 'Changes requested';

  @override
  String get catalogueSearch => 'Search courses';

  @override
  String get catalogueAll => 'All';

  @override
  String get catalogueEmptyTitle => 'No courses match';

  @override
  String get catalogueEmptyBody => 'Try another search or category.';

  @override
  String courseLessons(int n) {
    return '$n lessons';
  }

  @override
  String courseCpd(int n) {
    return '$n CPD';
  }

  @override
  String get coursePlusVat => '+5% VAT';

  @override
  String durationHm(int h, int m) {
    return '${h}h ${m}m';
  }

  @override
  String get courseQuiz => '8-question quiz';

  @override
  String get courseYourProgress => 'Your progress';

  @override
  String courseLessonsDone(int done, int total) {
    return '$done of $total lessons completed';
  }

  @override
  String get courseLessonsHeading => 'Lessons';

  @override
  String get lessonStateDone => 'Done';

  @override
  String get lessonStateNow => 'Now';

  @override
  String get lessonStateTodo => 'To do';

  @override
  String get lessonStateLocked => 'Locked';

  @override
  String get lessonTypeVideo => 'Video';

  @override
  String get lessonTypePdf => 'PDF';

  @override
  String get lessonTypeReading => 'Reading';

  @override
  String minutesShort(int n) {
    return '$n min';
  }

  @override
  String ctaContinue(int n) {
    return 'Continue · lesson $n';
  }

  @override
  String get ctaStart => 'Start course';

  @override
  String get ctaReview => 'Review course';

  @override
  String ctaBuy(String price) {
    return 'Buy · $price';
  }

  @override
  String lessonMeta(int n, int total, String type) {
    return 'Lesson $n of $total · $type';
  }

  @override
  String get lessonPdfPlaceholder => 'PDF placeholder · page 1 of 6';

  @override
  String get lessonReadingPlaceholder =>
      'Reading lesson placeholder. Authored content renders here with headings, callouts and inline knowledge checks; learners can bookmark and resume.';

  @override
  String get lessonKeyPoint => 'Key point callout placeholder';

  @override
  String get lessonFurther => 'Further body text placeholder.';

  @override
  String get lessonUpNext => 'Up next';

  @override
  String get lessonPrevious => 'Previous';

  @override
  String get lessonMarkComplete => 'Mark complete';

  @override
  String get lessonNext => 'Next lesson';

  @override
  String get lessonCompleted => 'Completed';

  @override
  String get lessonPlay => 'Play video';

  @override
  String get courseCompleteTitle => 'Course complete';

  @override
  String courseCompleteBody(int n) {
    return '+$n CPD/CME credits added';
  }

  @override
  String assessQuestionsFromBank(int count, int bank) {
    return '$count questions · from a $bank-question bank';
  }

  @override
  String get assessPassMark => 'Pass mark';

  @override
  String get assessBestScore => 'Best score';

  @override
  String get assessAttempts => 'Attempts';

  @override
  String get assessStart => 'Start assessment';

  @override
  String get assessHistory => 'Score history';

  @override
  String get assessNoHistory =>
      'No attempts yet. Your scores will appear here.';

  @override
  String assessAttemptN(int n) {
    return 'Attempt $n';
  }

  @override
  String assessUnlocksAfter(int count) {
    return 'Unlocks after all $count lessons';
  }

  @override
  String get assessLocked => 'Locked';

  @override
  String quizQuestionOf(String n, String total) {
    return 'Question $n of $total';
  }

  @override
  String quizPassTag(String pct) {
    return 'Pass $pct';
  }

  @override
  String get quizOptionLetters => 'A|B|C|D';

  @override
  String quizOptionSemantics(String letter, String text) {
    return 'Option $letter: $text';
  }

  @override
  String get quizCorrect => 'Correct';

  @override
  String get quizNotQuite => 'Not quite';

  @override
  String quizExplanation(String text) {
    return 'Explanation: $text';
  }

  @override
  String get quizNext => 'Next question';

  @override
  String get quizSeeResults => 'See results';

  @override
  String get quizLeaveTitle => 'Leave assessment?';

  @override
  String get quizLeaveBody => 'Your answers will be lost.';

  @override
  String get quizLeaveStay => 'Stay';

  @override
  String get quizLeaveConfirm => 'Leave';

  @override
  String quizProgressSemantics(int answered, int total) {
    return '$answered of $total questions answered';
  }

  @override
  String resultCorrectCount(String correct, String total) {
    return '$correct / $total correct';
  }

  @override
  String get resultPassedTag => 'Passed';

  @override
  String get resultBelowTag => 'Below pass mark';

  @override
  String get resultPassedTitle => 'Assessment passed';

  @override
  String get resultFailedTitle => 'Not passed this time';

  @override
  String get resultPassedBody =>
      'Well done. This attempt is saved to your score history.';

  @override
  String resultFailedBody(String pct) {
    return 'You need $pct to pass. Review the course and try again.';
  }

  @override
  String get resultAudit => 'Recorded to audit trail';

  @override
  String resultScoreSemantics(String pct) {
    return 'Score $pct';
  }

  @override
  String get resultDone => 'Done';

  @override
  String get resultRetake => 'Retake';

  @override
  String reminderTitle(String code, int days) {
    return '$code certificate expires in $days days';
  }

  @override
  String reminderBody(String date) {
    return 'Renew before $date to stay compliant.';
  }

  @override
  String get reminderChannel => 'Expiry reminders';

  @override
  String get certIssuerUploaded => 'Uploaded by you';

  @override
  String certsCpdOf(String target) {
    return 'of $target';
  }

  @override
  String certsCpdToTarget(int left) {
    return '$left credits to reach your target';
  }

  @override
  String get certsCpdReached => 'You\'ve reached your target';

  @override
  String certsCpdSemantics(int total, int target) {
    return '$total of $target CPD credits';
  }

  @override
  String get certsRemindersTitle => 'Expiry reminders';

  @override
  String certsRemindersDays(String days) {
    return '$days days before';
  }

  @override
  String get certsSimulate => 'Simulate expiry reminder';

  @override
  String get certsListTitle => 'Certifications';

  @override
  String get certsLedgerTitle => 'CPD/CME ledger';

  @override
  String get certsUpload => 'Upload';

  @override
  String get certStatusValid => 'Valid';

  @override
  String get certStatusRenewSoon => 'Renew soon';

  @override
  String get certStatusVerifying => 'Verifying';

  @override
  String get certStatusExpired => 'Expired';

  @override
  String certExpires(String date) {
    return 'Expires $date';
  }

  @override
  String certDaysLeft(String days) {
    return '$days days';
  }

  @override
  String certDaysLeftSemantics(int days) {
    return '$days days left';
  }

  @override
  String get cpdSourceExternal => 'External';

  @override
  String get cpdSourceClinicaledge => 'ClinicalEdge';

  @override
  String get uploadDropZone => 'Scan with camera or choose a file';

  @override
  String get uploadDropHint => 'PDF, JPG or PNG';

  @override
  String uploadFileSize(String kb) {
    return '$kb KB';
  }

  @override
  String get uploadNameLabel => 'Certificate';

  @override
  String get uploadNameHint => 'Neonatal Resuscitation Program (NRP)';

  @override
  String get uploadIssued => 'Issued';

  @override
  String get uploadExpires => 'Expires';

  @override
  String get uploadPickDate => 'Choose date';

  @override
  String get uploadSubmit => 'Upload for verification';

  @override
  String get uploadErrorName => 'Enter the certificate name';

  @override
  String get uploadErrorExpiry => 'Choose an expiry date';

  @override
  String get uploadErrorExpiryOrder => 'Expiry must be after the issue date';

  @override
  String get uploadDoneTitle => 'Certificate uploaded';

  @override
  String uploadDoneMessage(String code) {
    return '$code is pending verification';
  }

  @override
  String get signoffRequestAction => 'Request sign-off';

  @override
  String signoffGoesTo(String name, String department) {
    return 'Goes to $name · $department';
  }

  @override
  String signoffWaiting(String date) {
    return 'Waiting for supervisor · requested $date';
  }

  @override
  String signoffApprovedBy(String name, String date) {
    return 'Approved by $name · $date';
  }

  @override
  String signoffReturnedBy(String name, String date) {
    return 'Returned by $name · $date';
  }

  @override
  String get signoffRequestedTitle => 'Sign-off requested';

  @override
  String signoffRequestedMessage(String name) {
    return 'Sent to $name';
  }

  @override
  String get signoffSelfAssessed => 'Self-assessed';

  @override
  String get queueStatPending => 'Pending';

  @override
  String get queueStatThisMonth => 'This month';

  @override
  String get queueStatTurnaround => 'Turnaround';

  @override
  String queueTurnaroundValue(String days) {
    return '${days}d';
  }

  @override
  String queueSkillsRequested(int count, String date) {
    return '$count skills · requested $date';
  }

  @override
  String get queueEmptyTitle => 'All caught up';

  @override
  String get queueEmptyBody => 'New sign-off requests appear here.';

  @override
  String get reviewObserved => 'Observed';

  @override
  String get reviewCommentLabel => 'Comment for the learner';

  @override
  String get reviewCommentHint => 'Observed technique, feedback, follow-up…';

  @override
  String get reviewLockNote =>
      'Your decision is written to the append-only audit chain.';

  @override
  String get reviewReject => 'Reject';

  @override
  String get reviewApprove => 'Approve';

  @override
  String get reviewCommentRequired => 'A comment is required to reject.';

  @override
  String get reviewDefaultApproval => 'Competent. Observed and signed off.';

  @override
  String get reviewApprovedSnack => 'Competency approved';

  @override
  String get reviewRejectedSnack => 'Returned with comments';

  @override
  String get decidedEmptyTitle => 'No decisions yet';

  @override
  String get decidedEmptyBody => 'Approved and returned sign-offs appear here.';

  @override
  String get checkoutOrderSummary => 'Order summary';

  @override
  String checkoutLessonsCredits(int lessons, int credits) {
    return '$lessons lessons · $credits CPD credits';
  }

  @override
  String get checkoutSubtotal => 'Subtotal';

  @override
  String checkoutVat(String pct) {
    return 'VAT ($pct)';
  }

  @override
  String get checkoutTotal => 'Total';

  @override
  String get checkoutMethod => 'Payment method';

  @override
  String get checkoutCard => 'Card';

  @override
  String get checkoutApplePay => 'Apple Pay';

  @override
  String get checkoutCardNumber => 'Card number';

  @override
  String get checkoutCardHint => '4242 4242 4242 4242 (test)';

  @override
  String get checkoutExpiry => 'Expiry';

  @override
  String get checkoutExpiryHint => 'MM / YY';

  @override
  String get checkoutCvc => 'CVC';

  @override
  String get checkoutErrorNumber => 'Check the card number';

  @override
  String get checkoutErrorExpiry =>
      'Enter a valid date that is not in the past';

  @override
  String get checkoutErrorCvc => '3 or 4 digits';

  @override
  String get checkoutApplePaySheet => 'Apple Pay sheet (mock)';

  @override
  String get checkoutApplePayHint => 'Confirm with Face ID on device';

  @override
  String get checkoutLockNote =>
      'PaymentGateway → MockGateway today. A Network International adapter plugs in behind the same interface. Card details are never logged.';

  @override
  String checkoutPay(String amount) {
    return 'Pay $amount';
  }

  @override
  String checkoutPayApple(String amount) {
    return 'Pay with Apple Pay · $amount';
  }

  @override
  String get checkoutProcessing => 'Processing…';

  @override
  String get checkoutDeclinedTitle => 'Payment declined';

  @override
  String get checkoutDeclinedBody =>
      'You were not charged. Check the details or try another method.';

  @override
  String get checkoutCancelledBody =>
      'Payment cancelled at 3-D Secure. You were not charged.';

  @override
  String get checkoutRetry => 'Try again';

  @override
  String get threeDsTitle => '3-D Secure (mock)';

  @override
  String threeDsBody(String amount) {
    return 'Your bank asks you to confirm a payment of $amount to ClinicalEdge.';
  }

  @override
  String get threeDsApprove => 'Approve';

  @override
  String get threeDsCancel => 'Cancel';

  @override
  String get receiptSuccess => 'Payment successful';

  @override
  String receiptInvoice(String number, String date) {
    return 'Tax invoice $number · $date';
  }

  @override
  String get receiptSeller => 'Seller';

  @override
  String receiptSellerValue(String name, String trn) {
    return '$name · TRN $trn';
  }

  @override
  String get receiptBilledTo => 'Billed to';

  @override
  String get receiptItem => 'Item';

  @override
  String get receiptMethod => 'Method';

  @override
  String receiptCardMethod(String last4) {
    return 'Card •••• $last4 (mock)';
  }

  @override
  String get receiptApplePay => 'Apple Pay (mock)';

  @override
  String receiptVat(String pct) {
    return 'VAT $pct';
  }

  @override
  String get receiptTotalPaid => 'Total paid';

  @override
  String get receiptShare => 'Share PDF';

  @override
  String get receiptStart => 'Start course';

  @override
  String get cohortActive => 'Active learners';

  @override
  String cohortActiveSplit(String nursing, String physicians) {
    return '$nursing nursing · $physicians physicians';
  }

  @override
  String get cohortAvgCompletion => 'Avg. completion';

  @override
  String cohortDelta(String delta, String compared) {
    return '$delta pts $compared';
  }

  @override
  String get cohortExpiring => 'Expiring ≤ 90 days';

  @override
  String get cohortRemindersScheduled => 'Reminders scheduled';

  @override
  String get cohortPendingSignoffs => 'Pending sign-offs';

  @override
  String cohortSupervisors(String count) {
    return '$count supervisors';
  }

  @override
  String get cohortCompletionByCourse => 'Completion by course';

  @override
  String get cohortProgressByDept => 'Average progress by department';

  @override
  String get cohortExpiries => 'Expiries next 6 months';

  @override
  String cohortExpiriesTotal(String count) {
    return '$count total';
  }

  @override
  String get cohortLearners => 'Learners';

  @override
  String cohortLearnerLine(String pct, String department) {
    return '$pct · $department';
  }

  @override
  String cohortExpiryTag(String code, String days) {
    return '$code ${days}d';
  }

  @override
  String get cohortNoExpiry => 'No expiries';

  @override
  String cohortDemoNote(String label, String date) {
    return '$label · as of $date';
  }

  @override
  String chartSemantics(String title, String values) {
    return '$title: $values';
  }

  @override
  String auditChainOk(String count, String head) {
    return 'Hash chain verified · $count append-only events · head $head';
  }

  @override
  String auditChainBroken(String index, String action, String date) {
    return 'Hash chain broken at event $index ($action · $date)';
  }

  @override
  String get auditKindAll => 'All events';

  @override
  String get auditKindAudit => 'Audit';

  @override
  String get auditKindUsage => 'Usage';

  @override
  String get auditToday => 'Today';

  @override
  String get auditWeek => '7 days';

  @override
  String get auditUser => 'User';

  @override
  String get auditAction => 'Action';

  @override
  String get auditAnyUser => 'All users';

  @override
  String get auditAnyAction => 'All actions';

  @override
  String get auditSearch => 'Search targets';

  @override
  String auditCount(String count) {
    return '$count events · newest first · no patient data, passwords or card details';
  }

  @override
  String auditMeta(String user, String role, String platform, String date) {
    return '$user · $role · $platform · $date';
  }

  @override
  String get auditUsageNote => 'usage analytics · not chained';

  @override
  String auditShowMore(String count) {
    return 'Show $count more';
  }

  @override
  String get auditExport => 'Export CSV';

  @override
  String get auditExportReady => 'Export ready';

  @override
  String auditExportRows(String count) {
    return '$count rows shared as CSV';
  }

  @override
  String get auditEmpty => 'No events match these filters';

  @override
  String get insightsMostUsed => 'Most-used courses';

  @override
  String insightsViews(String count) {
    return '$count views';
  }

  @override
  String insightsDropOff(String course) {
    return 'Drop-off · $course';
  }

  @override
  String get insightsDropCaption =>
      'Share of enrolled learners reaching each lesson.';

  @override
  String insightsLessonTag(String n) {
    return 'Lesson $n';
  }

  @override
  String insightsLessonShort(String n) {
    return 'L$n';
  }

  @override
  String get insightsPassRates => 'Assessment pass rates';

  @override
  String insightsAttempts(String count) {
    return '$count attempts';
  }

  @override
  String get insightsPlatforms => 'Sessions by platform';

  @override
  String get insightsNote =>
      'Usage analytics live apart from the audit trail and swap to Firebase Analytics behind ActivityLogger.';

  @override
  String platformShare(String platform, String pct) {
    return '$platform $pct';
  }

  @override
  String get inboxTitle => 'Notifications';

  @override
  String get inboxEmptyTitle => 'You\'re all caught up';

  @override
  String get inboxEmptyBody => 'New reminders and updates appear here.';

  @override
  String get inboxNew => 'New';

  @override
  String inboxCertExpired(String code) {
    return '$code certificate has expired';
  }

  @override
  String inboxCertExpiredBody(String date) {
    return 'Expired on $date. Upload a renewed certificate.';
  }

  @override
  String inboxCertVerifying(String name) {
    return '$name is being verified';
  }

  @override
  String get inboxCertVerifyingBody =>
      'Your training office will check it shortly.';

  @override
  String inboxSignOffApproved(String checklist) {
    return '$checklist approved';
  }

  @override
  String inboxSignOffRejected(String checklist) {
    return '$checklist: changes requested';
  }

  @override
  String inboxSignOffDecidedBody(String name, String date) {
    return 'Decided by $name on $date.';
  }

  @override
  String inboxSignOffRequest(String name) {
    return '$name requested sign-off';
  }

  @override
  String inboxSignOffRequestBody(String checklist, String date) {
    return '$checklist · requested $date';
  }

  @override
  String inboxCohortExpiry(String name, String code, int days) {
    return '$name: $code expires in $days days';
  }

  @override
  String get inboxCohortExpiryBody => 'Remind them to renew before it lapses.';

  @override
  String inboxCohortPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sign-offs awaiting supervisors',
      one: '1 sign-off awaiting a supervisor',
    );
    return '$_temp0';
  }

  @override
  String get inboxCohortPendingBody => 'See the cohort dashboard for details.';

  @override
  String get titleHelp => 'Help & user guide';

  @override
  String get helpEntryBody => 'Step-by-step guide for your role';

  @override
  String get helpIntroLearner =>
      'How to take courses and quizzes, keep certificates current and get competencies signed off.';

  @override
  String get helpIntroSupervisor =>
      'How to review learners\' competency sign-off requests and record your decisions.';

  @override
  String get helpIntroAdmin =>
      'How to follow cohort progress, check the audit log and read usage insights.';

  @override
  String helpGuideFor(String role) {
    return 'Guide for: $role';
  }

  @override
  String get helpLearnerHomeTitle => 'Your home dashboard';

  @override
  String get helpLearnerHomeBody =>
      'See your overall progress and tap Resume to continue the last lesson.\nThe orange banner warns you when a certificate is close to expiry.\nThe CPD/CME card shows credits earned this year against your target.';

  @override
  String get helpLearnerLearnTitle => 'Courses and lessons';

  @override
  String get helpLearnerLearnBody =>
      'Open Learn to browse the catalogue and filter by category.\nOpen a course to see its lessons, then tap a lesson to study it.\nTap Mark complete at the end of each lesson. Finishing a course awards CPD credits.\nFor a paid course tap Buy, pay by card or Apple Pay, and keep the PDF receipt.';

  @override
  String get helpLearnerAssessTitle => 'Quizzes';

  @override
  String get helpLearnerAssessBody =>
      'Open Assess to see the available quizzes and your best score.\nEach answer shows instant feedback with an explanation.\nYou pass with 80% or more, and you can retake a quiz at any time.\nSome quizzes unlock only after you finish the related course.';

  @override
  String get helpLearnerCertsTitle => 'Certifications and CPD';

  @override
  String get helpLearnerCertsBody =>
      'Certs lists each certificate with its status: Valid, Renew soon, Verifying or Expired.\nTap Upload to add a certificate (PDF or photo); it shows as Verifying until checked.\nTurn on expiry reminders to be told 90, 60, 30 and 7 days before a certificate expires.\nThe CPD ring and ledger show where your credits came from.';

  @override
  String get helpLearnerSignoffsTitle => 'Competency sign-off';

  @override
  String get helpLearnerSignoffsBody =>
      'Open Sign-offs to see your competency checklists.\nWhen you are ready, tap Request sign-off; it goes to your supervisor\'s queue.\nYou will see Approved or Changes requested, with your supervisor\'s comment.';

  @override
  String get helpLearnerBellBody =>
      'Tap the bell to see certificate reminders and sign-off decisions.\nA dot on the bell means there is something you have not seen yet. Tap an item to open it.';

  @override
  String get helpSupervisorQueueTitle => 'Your sign-off queue';

  @override
  String get helpSupervisorQueueBody =>
      'Your home shows pending requests, oldest first.\nThe cards at the top show how many are pending, how many arrived this month and your average turnaround.';

  @override
  String get helpSupervisorReviewTitle => 'Reviewing a request';

  @override
  String get helpSupervisorReviewBody =>
      'Tap a request to see the learner, the checklist and each skill.\nTap Approve (a standard comment is filled in for you) or Reject and explain what to practise.\nYour decision is recorded in the audit log; your comment is not.';

  @override
  String get helpSupervisorDecidedTitle => 'Decided requests';

  @override
  String get helpSupervisorDecidedBody =>
      'Open Decided to see your past decisions, newest first.';

  @override
  String get helpSupervisorLearnTitle => 'Browsing courses';

  @override
  String get helpSupervisorLearnBody =>
      'Open Learn to browse the same catalogue your learners use.\nLessons, quizzes and purchases are for learners only.';

  @override
  String get helpSupervisorBellBody =>
      'Tap the bell to see new sign-off requests.\nTap a request to open its review.';

  @override
  String get helpAdminCohortTitle => 'Cohort dashboard';

  @override
  String get helpAdminCohortBody =>
      'Your home shows key figures, course completion, progress by department and upcoming certificate expiries.\nThe learner list shows each person\'s progress and next expiring certificate.\nFigures labelled demo come from sample data.';

  @override
  String get helpAdminAuditTitle => 'Audit log';

  @override
  String get helpAdminAuditBody =>
      'Important actions (quiz scores, sign-offs, purchases, uploads, role changes) are recorded and chained, so any tampering shows.\nThe banner at the top confirms the chain is intact.\nFilter by kind, period, user or action, or search by target.\nTap Export CSV to share the filtered log.';

  @override
  String get helpAdminInsightsTitle => 'Usage insights';

  @override
  String get helpAdminInsightsBody =>
      'See lesson views by course, where learners drop off in BLS, pass rates and the iOS/Android split.\nInsights use usage events only, never the audit log.';

  @override
  String get helpAdminBellBody =>
      'Tap the bell to see cohort certificates that expire soon and sign-offs waiting for supervisors.';

  @override
  String get helpBellTitle => 'Notifications';

  @override
  String get helpSettingsTitle => 'Profile and settings';

  @override
  String get helpSettingsBody =>
      'Tap your initials at the top of any tab to open Profile & settings.\nChoose English or العربية, and a light or dark theme.\nTurn expiry reminders on or off, and sign out.';

  @override
  String get helpDemoTitle => 'About this demo';

  @override
  String get helpDemoBody =>
      'This demo uses sample data: any password works and no real payments are made.\nUse Demo role on the sign-in screen or in Profile to try the learner, supervisor and admin views.';
}
