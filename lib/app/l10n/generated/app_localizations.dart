import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Product name shown in the OS task switcher and brand areas.
  ///
  /// In en, this message translates to:
  /// **'ClinicalEdge'**
  String get appTitle;

  /// Tagline under the product name on sign-in.
  ///
  /// In en, this message translates to:
  /// **'Training · Certification · CPD'**
  String get brandTag;

  /// Organisation name shown as the tab app bar subtitle.
  ///
  /// In en, this message translates to:
  /// **'Demo Health Network · Dubai'**
  String get tenant;

  /// Bottom bar label: learner home tab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom bar label: course catalogue tab.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get navLearn;

  /// Bottom bar label: assessments tab.
  ///
  /// In en, this message translates to:
  /// **'Assess'**
  String get navAssess;

  /// Bottom bar label: certifications tab.
  ///
  /// In en, this message translates to:
  /// **'Certs'**
  String get navCerts;

  /// Bottom bar label: learner competency sign-offs tab.
  ///
  /// In en, this message translates to:
  /// **'Sign-offs'**
  String get navSignoffs;

  /// Bottom bar label: supervisor sign-off queue tab.
  ///
  /// In en, this message translates to:
  /// **'Queue'**
  String get navQueue;

  /// Bottom bar label: supervisor recently decided tab.
  ///
  /// In en, this message translates to:
  /// **'Decided'**
  String get navDecided;

  /// Bottom bar label: admin cohort dashboard tab.
  ///
  /// In en, this message translates to:
  /// **'Cohort'**
  String get navCohort;

  /// Bottom bar label: admin audit log tab.
  ///
  /// In en, this message translates to:
  /// **'Audit'**
  String get navAudit;

  /// Bottom bar label: admin usage insights tab.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// Screen title: sign-in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get titleSignIn;

  /// Screen title: learner home dashboard.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get titleHome;

  /// Screen title: course catalogue.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get titleCourses;

  /// Screen title: course detail.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get titleCourseDetail;

  /// Screen title: lesson player.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get titleLesson;

  /// Screen title: checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get titleCheckout;

  /// Screen title: payment receipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get titleReceipt;

  /// Screen title: assessments and history.
  ///
  /// In en, this message translates to:
  /// **'Assessments'**
  String get titleAssessments;

  /// Screen title: quiz in progress.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get titleQuiz;

  /// Screen title: certifications and CPD credits.
  ///
  /// In en, this message translates to:
  /// **'Certifications & CPD'**
  String get titleCerts;

  /// Title of the upload certificate bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Upload certificate'**
  String get titleUploadCert;

  /// Screen title: learner competency checklists.
  ///
  /// In en, this message translates to:
  /// **'Competencies'**
  String get titleCompetencies;

  /// Screen title: supervisor sign-off queue.
  ///
  /// In en, this message translates to:
  /// **'Sign-off queue'**
  String get titleQueue;

  /// Screen title: supervisor review and decide.
  ///
  /// In en, this message translates to:
  /// **'Review sign-off'**
  String get titleReview;

  /// Screen title: supervisor decision history.
  ///
  /// In en, this message translates to:
  /// **'Recently decided'**
  String get titleDecided;

  /// Screen title: admin cohort dashboard.
  ///
  /// In en, this message translates to:
  /// **'Cohort dashboard'**
  String get titleCohort;

  /// Screen title: admin audit log.
  ///
  /// In en, this message translates to:
  /// **'Audit log'**
  String get titleAudit;

  /// Screen title: admin usage insights.
  ///
  /// In en, this message translates to:
  /// **'Usage insights'**
  String get titleInsights;

  /// Screen title: profile and settings.
  ///
  /// In en, this message translates to:
  /// **'Profile & settings'**
  String get titleProfile;

  /// Body text of a placeholder screen during the scaffold phase.
  ///
  /// In en, this message translates to:
  /// **'This screen arrives in a later phase.'**
  String get placeholderBody;

  /// Accessibility label of the app bar back button.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get actionBack;

  /// Accessibility label for closing a sheet or dialog.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// Accessibility label of the bell button.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get actionNotifications;

  /// Accessibility label of the avatar button.
  ///
  /// In en, this message translates to:
  /// **'Profile and settings'**
  String get actionProfile;

  /// Accessibility label while content or an action is loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// Role name: learner.
  ///
  /// In en, this message translates to:
  /// **'Learner'**
  String get roleLearner;

  /// Role name: supervisor.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get roleSupervisor;

  /// Role name: admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// Label for the theme picker.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// Theme option that follows the device setting.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Theme option: light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Theme option: dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Label for the language picker.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// Language name, always shown in English.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Language name, always shown in Arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// App name line in a simulated push notification banner.
  ///
  /// In en, this message translates to:
  /// **'CLINICALEDGE'**
  String get notificationAppName;

  /// Time label of a notification that just arrived.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get notificationNow;

  /// Banner title when there are no notifications.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get notificationsEmptyTitle;

  /// Banner body when there are no notifications.
  ///
  /// In en, this message translates to:
  /// **'Expiry reminders will appear here.'**
  String get notificationsEmptyBody;

  /// Accessibility label for a bottom bar badge.
  ///
  /// In en, this message translates to:
  /// **'{count} new'**
  String navBadge(int count);

  /// Money amount in UAE dirham. amount is already formatted with two decimals.
  ///
  /// In en, this message translates to:
  /// **'AED {amount}'**
  String aedAmount(String amount);

  /// Title and button label of the temporary developer menu (debug builds only).
  ///
  /// In en, this message translates to:
  /// **'Debug menu'**
  String get debugMenu;

  /// Debug menu: section listing routes to open.
  ///
  /// In en, this message translates to:
  /// **'Jump to route'**
  String get debugRoutes;

  /// Debug menu: clock source section.
  ///
  /// In en, this message translates to:
  /// **'Clock'**
  String get debugClock;

  /// Debug menu: fixed demo clock (17 Nov 2026, 09:00 Dubai).
  ///
  /// In en, this message translates to:
  /// **'Demo date'**
  String get debugClockDemo;

  /// Debug menu: real device clock.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get debugClockSystem;

  /// Debug menu: forced outcome of the mock payment gateway.
  ///
  /// In en, this message translates to:
  /// **'Mock payment'**
  String get debugGateway;

  /// Mock payment outcome: success.
  ///
  /// In en, this message translates to:
  /// **'Succeed'**
  String get debugGatewaySucceed;

  /// Mock payment outcome: declined.
  ///
  /// In en, this message translates to:
  /// **'Fail'**
  String get debugGatewayFail;

  /// Mock payment outcome: 3-D Secure challenge.
  ///
  /// In en, this message translates to:
  /// **'3-D Secure'**
  String get debugGateway3ds;

  /// Debug menu: wipe local data and reload the seed.
  ///
  /// In en, this message translates to:
  /// **'Reset demo data'**
  String get debugReset;

  /// Snackbar after the demo data was reset.
  ///
  /// In en, this message translates to:
  /// **'Demo data reset'**
  String get debugResetDone;

  /// Sign-in hero headline.
  ///
  /// In en, this message translates to:
  /// **'Clinical training that keeps every licence current.'**
  String get heroHeadline;

  /// Sign-in hero supporting copy.
  ///
  /// In en, this message translates to:
  /// **'Courses, assessments, certifications and competency sign-off for UAE healthcare teams.'**
  String get heroBody;

  /// Sign-in card heading.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInTitle;

  /// Email field label.
  ///
  /// In en, this message translates to:
  /// **'Work email'**
  String get signInEmail;

  /// Password field label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signInPassword;

  /// Label of the demo role picker.
  ///
  /// In en, this message translates to:
  /// **'Demo role'**
  String get signInDemoRole;

  /// Sign-in button.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInButton;

  /// Note under the sign-in button.
  ///
  /// In en, this message translates to:
  /// **'Demo build: any password works. No real authentication.'**
  String get signInDemoNote;

  /// Inline error: empty email.
  ///
  /// In en, this message translates to:
  /// **'Enter your work email'**
  String get signInEmailRequired;

  /// Inline error: empty password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get signInPasswordRequired;

  /// Accessibility label: reveal password.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get signInShowPassword;

  /// Accessibility label: hide password.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get signInHidePassword;

  /// Home subtitle before 12:00.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// Home subtitle 12:00–16:59.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// Home subtitle from 17:00.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// Snackbar title after a demo role switch.
  ///
  /// In en, this message translates to:
  /// **'Role switched'**
  String get roleSwitchedTitle;

  /// Snackbar body after a demo role switch.
  ///
  /// In en, this message translates to:
  /// **'Now viewing as {name}'**
  String roleSwitchedBody(String name);

  /// Notifications switch label.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get settingsPush;

  /// Notifications switch description.
  ///
  /// In en, this message translates to:
  /// **'Expiry reminders and sign-off decisions'**
  String get settingsPushBody;

  /// Tech stack card title.
  ///
  /// In en, this message translates to:
  /// **'Under the hood · Flutter'**
  String get settingsHoodTitle;

  /// Tech chip: feature-first folders.
  ///
  /// In en, this message translates to:
  /// **'Feature-first'**
  String get settingsHoodFeatureFirst;

  /// Tech chip: mock repositories.
  ///
  /// In en, this message translates to:
  /// **'Mock repositories'**
  String get settingsHoodMockRepos;

  /// Tech stack card description.
  ///
  /// In en, this message translates to:
  /// **'Each feature reads through a repository interface; mock implementations swap for Firebase later without touching the UI.'**
  String get settingsHoodBody;

  /// Sign-out button.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// Version line on Profile & settings.
  ///
  /// In en, this message translates to:
  /// **'ClinicalEdge 0.1.0 (prototype) · mock data only'**
  String get appVersion;

  /// Home hero ring caption.
  ///
  /// In en, this message translates to:
  /// **'Overall progress'**
  String get homeOverall;

  /// Home hero summary.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} lessons · {courses} courses'**
  String homeLessonsSummary(int done, int total, int courses);

  /// Home hero button: next lesson.
  ///
  /// In en, this message translates to:
  /// **'Resume: {title}'**
  String homeResume(String title);

  /// Home hero button when nothing is left.
  ///
  /// In en, this message translates to:
  /// **'All lessons complete'**
  String get homeAllDone;

  /// Expiry alert title.
  ///
  /// In en, this message translates to:
  /// **'{code} expires in {days} days'**
  String homeExpiryTitle(String code, int days);

  /// Expiry alert body.
  ///
  /// In en, this message translates to:
  /// **'Renew before {date}'**
  String homeRenewBefore(String date);

  /// CPD card title.
  ///
  /// In en, this message translates to:
  /// **'CPD/CME credits · {cycle}'**
  String homeCredits(String cycle);

  /// CPD card footer.
  ///
  /// In en, this message translates to:
  /// **'{left} credits to go · cycle ends {date}'**
  String homeCreditsToGo(int left, String date);

  /// CPD card footer when the target is met.
  ///
  /// In en, this message translates to:
  /// **'Target reached · cycle ends {date}'**
  String homeCreditsReached(String date);

  /// Home section title.
  ///
  /// In en, this message translates to:
  /// **'Continue learning'**
  String get homeContinue;

  /// Link to the catalogue.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get homeViewAll;

  /// Home section title.
  ///
  /// In en, this message translates to:
  /// **'Recent scores'**
  String get homeRecentScores;

  /// Label of the pass-mark line.
  ///
  /// In en, this message translates to:
  /// **'Pass 80%'**
  String get homePassLine;

  /// Recent scores empty state.
  ///
  /// In en, this message translates to:
  /// **'No attempts yet'**
  String get homeNoScores;

  /// Home section title.
  ///
  /// In en, this message translates to:
  /// **'Supervisor sign-off'**
  String get homeSignoffs;

  /// Course progress tag.
  ///
  /// In en, this message translates to:
  /// **'Lesson {n} of {total}'**
  String lessonOfTotal(int n, int total);

  /// Tag for a finished course.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get courseCompleted;

  /// Sign-off status.
  ///
  /// In en, this message translates to:
  /// **'Not requested'**
  String get signoffNone;

  /// Sign-off status.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get signoffPending;

  /// Sign-off status.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get signoffApproved;

  /// Sign-off status.
  ///
  /// In en, this message translates to:
  /// **'Changes requested'**
  String get signoffRejected;

  /// Search bar hint.
  ///
  /// In en, this message translates to:
  /// **'Search courses'**
  String get catalogueSearch;

  /// Category chip: all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get catalogueAll;

  /// Empty search result.
  ///
  /// In en, this message translates to:
  /// **'No courses match'**
  String get catalogueEmptyTitle;

  /// Empty search result body.
  ///
  /// In en, this message translates to:
  /// **'Try another search or category.'**
  String get catalogueEmptyBody;

  /// Lesson count tag.
  ///
  /// In en, this message translates to:
  /// **'{n} lessons'**
  String courseLessons(int n);

  /// CPD credits tag.
  ///
  /// In en, this message translates to:
  /// **'{n} CPD'**
  String courseCpd(int n);

  /// Tag next to a price before VAT.
  ///
  /// In en, this message translates to:
  /// **'+5% VAT'**
  String get coursePlusVat;

  /// Duration hours and minutes.
  ///
  /// In en, this message translates to:
  /// **'{h}h {m}m'**
  String durationHm(int h, int m);

  /// Course detail tag.
  ///
  /// In en, this message translates to:
  /// **'8-question quiz'**
  String get courseQuiz;

  /// Course detail card title.
  ///
  /// In en, this message translates to:
  /// **'Your progress'**
  String get courseYourProgress;

  /// Course detail progress text.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} lessons completed'**
  String courseLessonsDone(int done, int total);

  /// Course detail section title.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get courseLessonsHeading;

  /// Lesson state.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get lessonStateDone;

  /// Lesson state: next to take.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get lessonStateNow;

  /// Lesson state.
  ///
  /// In en, this message translates to:
  /// **'To do'**
  String get lessonStateTodo;

  /// Lesson state: course not owned.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get lessonStateLocked;

  /// Lesson type.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get lessonTypeVideo;

  /// Lesson type.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get lessonTypePdf;

  /// Lesson type.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get lessonTypeReading;

  /// Minutes.
  ///
  /// In en, this message translates to:
  /// **'{n} min'**
  String minutesShort(int n);

  /// Course CTA.
  ///
  /// In en, this message translates to:
  /// **'Continue · lesson {n}'**
  String ctaContinue(int n);

  /// Course CTA.
  ///
  /// In en, this message translates to:
  /// **'Start course'**
  String get ctaStart;

  /// Course CTA when complete.
  ///
  /// In en, this message translates to:
  /// **'Review course'**
  String get ctaReview;

  /// Course CTA for unowned course; price incl. VAT.
  ///
  /// In en, this message translates to:
  /// **'Buy · {price}'**
  String ctaBuy(String price);

  /// Lesson meta line.
  ///
  /// In en, this message translates to:
  /// **'Lesson {n} of {total} · {type}'**
  String lessonMeta(int n, int total, String type);

  /// PDF lesson placeholder.
  ///
  /// In en, this message translates to:
  /// **'PDF placeholder · page 1 of 6'**
  String get lessonPdfPlaceholder;

  /// Reading lesson placeholder.
  ///
  /// In en, this message translates to:
  /// **'Reading lesson placeholder. Authored content renders here with headings, callouts and inline knowledge checks; learners can bookmark and resume.'**
  String get lessonReadingPlaceholder;

  /// Reading lesson callout.
  ///
  /// In en, this message translates to:
  /// **'Key point callout placeholder'**
  String get lessonKeyPoint;

  /// Reading lesson body.
  ///
  /// In en, this message translates to:
  /// **'Further body text placeholder.'**
  String get lessonFurther;

  /// Lesson outline title.
  ///
  /// In en, this message translates to:
  /// **'Up next'**
  String get lessonUpNext;

  /// Lesson button.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get lessonPrevious;

  /// Lesson button.
  ///
  /// In en, this message translates to:
  /// **'Mark complete'**
  String get lessonMarkComplete;

  /// Lesson button after completion.
  ///
  /// In en, this message translates to:
  /// **'Next lesson'**
  String get lessonNext;

  /// Lesson button on the last completed lesson.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get lessonCompleted;

  /// Accessibility label of the play button.
  ///
  /// In en, this message translates to:
  /// **'Play video'**
  String get lessonPlay;

  /// Snackbar title.
  ///
  /// In en, this message translates to:
  /// **'Course complete'**
  String get courseCompleteTitle;

  /// Snackbar body.
  ///
  /// In en, this message translates to:
  /// **'+{n} CPD/CME credits added'**
  String courseCompleteBody(int n);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
