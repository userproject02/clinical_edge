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
  String get debugSession => 'Session';

  @override
  String get debugSignedOut => 'Signed out';

  @override
  String get debugRoutes => 'Jump to route';
}
