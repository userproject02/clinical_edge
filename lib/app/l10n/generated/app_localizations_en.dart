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
}
