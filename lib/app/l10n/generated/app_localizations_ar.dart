// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ClinicalEdge';

  @override
  String get brandTag => 'التدريب · الشهادات · التطوير المهني';

  @override
  String get tenant => 'شبكة الصحة التجريبية · دبي';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navLearn => 'التعلّم';

  @override
  String get navAssess => 'التقييم';

  @override
  String get navCerts => 'الشهادات';

  @override
  String get navSignoffs => 'الاعتمادات';

  @override
  String get navQueue => 'الطلبات';

  @override
  String get navDecided => 'المنجزة';

  @override
  String get navCohort => 'الدفعة';

  @override
  String get navAudit => 'التدقيق';

  @override
  String get navInsights => 'الرؤى';

  @override
  String get titleSignIn => 'تسجيل الدخول';

  @override
  String get titleHome => 'الرئيسية';

  @override
  String get titleCourses => 'الدورات';

  @override
  String get titleCourseDetail => 'الدورة';

  @override
  String get titleLesson => 'الدرس';

  @override
  String get titleCheckout => 'الدفع';

  @override
  String get titleReceipt => 'الإيصال';

  @override
  String get titleAssessments => 'التقييمات';

  @override
  String get titleQuiz => 'الاختبار';

  @override
  String get titleCerts => 'الشهادات والتطوير المهني';

  @override
  String get titleUploadCert => 'رفع شهادة';

  @override
  String get titleCompetencies => 'الكفاءات';

  @override
  String get titleQueue => 'طلبات الاعتماد';

  @override
  String get titleReview => 'مراجعة الاعتماد';

  @override
  String get titleDecided => 'القرارات الأخيرة';

  @override
  String get titleCohort => 'لوحة الدفعة';

  @override
  String get titleAudit => 'سجل التدقيق';

  @override
  String get titleInsights => 'رؤى الاستخدام';

  @override
  String get titleProfile => 'الملف والإعدادات';

  @override
  String get placeholderBody => 'تتوفر هذه الشاشة في مرحلة لاحقة.';

  @override
  String get actionBack => 'رجوع';

  @override
  String get actionClose => 'إغلاق';

  @override
  String get actionNotifications => 'الإشعارات';

  @override
  String get actionProfile => 'الملف والإعدادات';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get roleLearner => 'متعلّم';

  @override
  String get roleSupervisor => 'مشرف';

  @override
  String get roleAdmin => 'مسؤول';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get notificationAppName => 'CLINICALEDGE';

  @override
  String get notificationNow => 'الآن';

  @override
  String get notificationsEmptyTitle => 'لا جديد الآن';

  @override
  String get notificationsEmptyBody => 'ستظهر تذكيرات انتهاء الصلاحية هنا.';

  @override
  String navBadge(int count) {
    return '$count جديد';
  }

  @override
  String aedAmount(String amount) {
    return '$amount د.إ';
  }

  @override
  String get debugMenu => 'قائمة المطوّر';

  @override
  String get debugRoutes => 'الانتقال إلى مسار';

  @override
  String get debugClock => 'الساعة';

  @override
  String get debugClockDemo => 'تاريخ العرض';

  @override
  String get debugClockSystem => 'الجهاز';

  @override
  String get debugGateway => 'الدفع التجريبي';

  @override
  String get debugGatewaySucceed => 'نجاح';

  @override
  String get debugGatewayFail => 'فشل';

  @override
  String get debugGateway3ds => 'التحقق ثلاثي الأبعاد';

  @override
  String get debugReset => 'إعادة ضبط البيانات التجريبية';

  @override
  String get debugResetDone => 'تمت إعادة ضبط البيانات التجريبية';

  @override
  String get heroHeadline => 'تدريب سريري يُبقي كل ترخيص سارياً.';

  @override
  String get heroBody =>
      'دورات وتقييمات وشهادات واعتماد الكفاءات لفرق الرعاية الصحية في الإمارات.';

  @override
  String get signInTitle => 'تسجيل الدخول';

  @override
  String get signInEmail => 'بريد العمل';

  @override
  String get signInPassword => 'كلمة المرور';

  @override
  String get signInDemoRole => 'دور تجريبي';

  @override
  String get signInButton => 'تسجيل الدخول';

  @override
  String get signInDemoNote =>
      'نسخة تجريبية: أي كلمة مرور تعمل، دون مصادقة حقيقية.';

  @override
  String get signInEmailRequired => 'أدخل بريد العمل';

  @override
  String get signInPasswordRequired => 'أدخل كلمة المرور';

  @override
  String get signInShowPassword => 'إظهار كلمة المرور';

  @override
  String get signInHidePassword => 'إخفاء كلمة المرور';

  @override
  String get greetingMorning => 'صباح الخير';

  @override
  String get greetingAfternoon => 'مساء الخير';

  @override
  String get greetingEvening => 'مساء الخير';

  @override
  String get roleSwitchedTitle => 'تم تغيير الدور';

  @override
  String roleSwitchedBody(String name) {
    return 'تتصفّح الآن باسم $name';
  }

  @override
  String get settingsPush => 'الإشعارات';

  @override
  String get settingsPushBody => 'تذكيرات الانتهاء وقرارات الاعتماد';

  @override
  String get settingsHoodTitle => 'البنية التقنية · Flutter';

  @override
  String get settingsHoodFeatureFirst => 'تنظيم حسب الميزة';

  @override
  String get settingsHoodMockRepos => 'مستودعات تجريبية';

  @override
  String get settingsHoodBody =>
      'تقرأ كل ميزة بياناتها عبر واجهة مستودع، وتُستبدل التطبيقات التجريبية بـ Firebase لاحقاً دون تغيير الواجهة.';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get appVersion =>
      'ClinicalEdge 0.1.0 (نموذج أولي) · بيانات تجريبية فقط';

  @override
  String get homeOverall => 'التقدّم العام';

  @override
  String homeLessonsSummary(int done, int total, int courses) {
    return '$done من $total درساً · $courses دورات';
  }

  @override
  String homeResume(String title) {
    return 'متابعة: $title';
  }

  @override
  String get homeAllDone => 'اكتملت جميع الدروس';

  @override
  String homeExpiryTitle(String code, int days) {
    return 'تنتهي شهادة $code خلال $days يوماً';
  }

  @override
  String homeRenewBefore(String date) {
    return 'جدّد قبل $date';
  }

  @override
  String homeCredits(String cycle) {
    return 'ساعات التطوير المهني · $cycle';
  }

  @override
  String homeCreditsToGo(int left, String date) {
    return 'متبقٍ $left ساعة · تنتهي الدورة في $date';
  }

  @override
  String homeCreditsReached(String date) {
    return 'تم بلوغ الهدف · تنتهي الدورة في $date';
  }

  @override
  String get homeContinue => 'متابعة التعلّم';

  @override
  String get homeViewAll => 'عرض الكل';

  @override
  String get homeRecentScores => 'أحدث النتائج';

  @override
  String get homePassLine => 'النجاح 80%';

  @override
  String get homeNoScores => 'لا توجد محاولات بعد';

  @override
  String get homeSignoffs => 'اعتماد المشرف';

  @override
  String lessonOfTotal(int n, int total) {
    return 'الدرس $n من $total';
  }

  @override
  String get courseCompleted => 'مكتملة';

  @override
  String get signoffNone => 'لم يُطلب';

  @override
  String get signoffPending => 'قيد الانتظار';

  @override
  String get signoffApproved => 'معتمد';

  @override
  String get signoffRejected => 'مطلوب تعديلات';

  @override
  String get catalogueSearch => 'ابحث في الدورات';

  @override
  String get catalogueAll => 'الكل';

  @override
  String get catalogueEmptyTitle => 'لا توجد دورات مطابقة';

  @override
  String get catalogueEmptyBody => 'جرّب بحثاً أو فئة أخرى.';

  @override
  String courseLessons(int n) {
    return '$n دروس';
  }

  @override
  String courseCpd(int n) {
    return '$n ساعات';
  }

  @override
  String get coursePlusVat => '+5% ضريبة';

  @override
  String durationHm(int h, int m) {
    return '$h س $m د';
  }

  @override
  String get courseQuiz => 'اختبار من 8 أسئلة';

  @override
  String get courseYourProgress => 'تقدّمك';

  @override
  String courseLessonsDone(int done, int total) {
    return 'أكملت $done من $total دروس';
  }

  @override
  String get courseLessonsHeading => 'الدروس';

  @override
  String get lessonStateDone => 'مكتمل';

  @override
  String get lessonStateNow => 'الآن';

  @override
  String get lessonStateTodo => 'قادم';

  @override
  String get lessonStateLocked => 'مقفل';

  @override
  String get lessonTypeVideo => 'فيديو';

  @override
  String get lessonTypePdf => 'ملف PDF';

  @override
  String get lessonTypeReading => 'قراءة';

  @override
  String minutesShort(int n) {
    return '$n د';
  }

  @override
  String ctaContinue(int n) {
    return 'متابعة · الدرس $n';
  }

  @override
  String get ctaStart => 'ابدأ الدورة';

  @override
  String get ctaReview => 'مراجعة الدورة';

  @override
  String ctaBuy(String price) {
    return 'شراء · $price';
  }

  @override
  String lessonMeta(int n, int total, String type) {
    return 'الدرس $n من $total · $type';
  }

  @override
  String get lessonPdfPlaceholder => 'ملف PDF تجريبي · صفحة 1 من 6';

  @override
  String get lessonReadingPlaceholder =>
      'محتوى تجريبي لدرس القراءة. يظهر هنا المحتوى المُعدّ بعناوين وملاحظات واختبارات قصيرة، ويمكن للمتعلّم حفظ موضعه والمتابعة لاحقاً.';

  @override
  String get lessonKeyPoint => 'ملاحظة النقطة الرئيسية';

  @override
  String get lessonFurther => 'نص إضافي تجريبي.';

  @override
  String get lessonUpNext => 'الدروس التالية';

  @override
  String get lessonPrevious => 'السابق';

  @override
  String get lessonMarkComplete => 'وضع علامة مكتمل';

  @override
  String get lessonNext => 'الدرس التالي';

  @override
  String get lessonCompleted => 'مكتمل';

  @override
  String get lessonPlay => 'تشغيل الفيديو';

  @override
  String get courseCompleteTitle => 'اكتملت الدورة';

  @override
  String courseCompleteBody(int n) {
    return 'أُضيفت $n ساعات تطوير مهني';
  }
}
