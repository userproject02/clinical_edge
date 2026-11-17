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
}
