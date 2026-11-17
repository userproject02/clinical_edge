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

  @override
  String assessQuestionsFromBank(int count, int bank) {
    return '$count أسئلة · من بنك يضم $bank سؤالًا';
  }

  @override
  String get assessPassMark => 'درجة النجاح';

  @override
  String get assessBestScore => 'أفضل نتيجة';

  @override
  String get assessAttempts => 'المحاولات';

  @override
  String get assessStart => 'ابدأ التقييم';

  @override
  String get assessHistory => 'سجل النتائج';

  @override
  String get assessNoHistory => 'لا توجد محاولات بعد. ستظهر نتائجك هنا.';

  @override
  String assessAttemptN(int n) {
    return 'المحاولة $n';
  }

  @override
  String assessUnlocksAfter(int count) {
    return 'يُفتح بعد إكمال الدروس الـ$count كلها';
  }

  @override
  String get assessLocked => 'مقفل';

  @override
  String quizQuestionOf(String n, String total) {
    return 'السؤال $n من $total';
  }

  @override
  String quizPassTag(String pct) {
    return 'النجاح $pct';
  }

  @override
  String get quizOptionLetters => 'أ|ب|ج|د';

  @override
  String quizOptionSemantics(String letter, String text) {
    return 'الخيار $letter: $text';
  }

  @override
  String get quizCorrect => 'إجابة صحيحة';

  @override
  String get quizNotQuite => 'ليست الإجابة الصحيحة';

  @override
  String quizExplanation(String text) {
    return 'التوضيح: $text';
  }

  @override
  String get quizNext => 'السؤال التالي';

  @override
  String get quizSeeResults => 'عرض النتيجة';

  @override
  String get quizLeaveTitle => 'مغادرة التقييم؟';

  @override
  String get quizLeaveBody => 'ستفقد إجاباتك.';

  @override
  String get quizLeaveStay => 'البقاء';

  @override
  String get quizLeaveConfirm => 'مغادرة';

  @override
  String quizProgressSemantics(int answered, int total) {
    return 'تمت الإجابة عن $answered من $total أسئلة';
  }

  @override
  String resultCorrectCount(String correct, String total) {
    return '$correct / $total إجابات صحيحة';
  }

  @override
  String get resultPassedTag => 'ناجح';

  @override
  String get resultBelowTag => 'دون درجة النجاح';

  @override
  String get resultPassedTitle => 'تم اجتياز التقييم';

  @override
  String get resultFailedTitle => 'لم تجتز التقييم هذه المرة';

  @override
  String get resultPassedBody => 'أحسنت. حُفظت هذه المحاولة في سجل نتائجك.';

  @override
  String resultFailedBody(String pct) {
    return 'تحتاج إلى $pct للنجاح. راجع الدورة وحاول مرة أخرى.';
  }

  @override
  String get resultAudit => 'سُجّلت في سجل التدقيق';

  @override
  String resultScoreSemantics(String pct) {
    return 'النتيجة $pct';
  }

  @override
  String get resultDone => 'تم';

  @override
  String get resultRetake => 'إعادة المحاولة';

  @override
  String reminderTitle(String code, int days) {
    return 'تنتهي صلاحية شهادة $code خلال $days يومًا';
  }

  @override
  String reminderBody(String date) {
    return 'جدّدها قبل $date لتبقى ملتزمًا بالمتطلبات.';
  }

  @override
  String get reminderChannel => 'تذكيرات انتهاء الصلاحية';

  @override
  String get certIssuerUploaded => 'رفعتها بنفسك';

  @override
  String certsCpdOf(String target) {
    return 'من $target';
  }

  @override
  String certsCpdToTarget(int left) {
    return '$left نقطة متبقية للوصول إلى هدفك';
  }

  @override
  String get certsCpdReached => 'وصلت إلى هدفك';

  @override
  String certsCpdSemantics(int total, int target) {
    return '$total من $target نقطة تطوير مهني';
  }

  @override
  String get certsRemindersTitle => 'تذكيرات انتهاء الصلاحية';

  @override
  String certsRemindersDays(String days) {
    return 'قبل $days يومًا';
  }

  @override
  String get certsSimulate => 'محاكاة تذكير انتهاء الصلاحية';

  @override
  String get certsListTitle => 'الشهادات';

  @override
  String get certsLedgerTitle => 'سجل التطوير المهني المستمر';

  @override
  String get certsUpload => 'رفع';

  @override
  String get certStatusValid => 'سارية';

  @override
  String get certStatusRenewSoon => 'جدّد قريبًا';

  @override
  String get certStatusVerifying => 'قيد التحقق';

  @override
  String get certStatusExpired => 'منتهية';

  @override
  String certExpires(String date) {
    return 'تنتهي في $date';
  }

  @override
  String certDaysLeft(String days) {
    return '$days يومًا';
  }

  @override
  String certDaysLeftSemantics(int days) {
    return 'متبقٍ $days يومًا';
  }

  @override
  String get cpdSourceExternal => 'خارجي';

  @override
  String get cpdSourceClinicaledge => 'ClinicalEdge';

  @override
  String get uploadDropZone => 'امسح بالكاميرا أو اختر ملفًا';

  @override
  String get uploadDropHint => 'PDF أو JPG أو PNG';

  @override
  String uploadFileSize(String kb) {
    return '$kb ك.ب';
  }

  @override
  String get uploadNameLabel => 'الشهادة';

  @override
  String get uploadNameHint => 'برنامج إنعاش حديثي الولادة (NRP)';

  @override
  String get uploadIssued => 'تاريخ الإصدار';

  @override
  String get uploadExpires => 'تاريخ الانتهاء';

  @override
  String get uploadPickDate => 'اختر التاريخ';

  @override
  String get uploadSubmit => 'رفع للتحقق';

  @override
  String get uploadErrorName => 'أدخل اسم الشهادة';

  @override
  String get uploadErrorExpiry => 'اختر تاريخ الانتهاء';

  @override
  String get uploadErrorExpiryOrder =>
      'يجب أن يكون تاريخ الانتهاء بعد تاريخ الإصدار';

  @override
  String get uploadDoneTitle => 'تم رفع الشهادة';

  @override
  String uploadDoneMessage(String code) {
    return '$code قيد التحقق';
  }

  @override
  String get signoffRequestAction => 'طلب الاعتماد';

  @override
  String signoffGoesTo(String name, String department) {
    return 'يُرسَل إلى $name · $department';
  }

  @override
  String signoffWaiting(String date) {
    return 'بانتظار المشرف · طُلب في $date';
  }

  @override
  String signoffApprovedBy(String name, String date) {
    return 'اعتمده $name · $date';
  }

  @override
  String signoffReturnedBy(String name, String date) {
    return 'أعاده $name · $date';
  }

  @override
  String get signoffRequestedTitle => 'تم طلب الاعتماد';

  @override
  String signoffRequestedMessage(String name) {
    return 'أُرسل إلى $name';
  }

  @override
  String get signoffSelfAssessed => 'تقييم ذاتي';

  @override
  String get queueStatPending => 'قيد الانتظار';

  @override
  String get queueStatThisMonth => 'هذا الشهر';

  @override
  String get queueStatTurnaround => 'مدة الإنجاز';

  @override
  String queueTurnaroundValue(String days) {
    return '$days يوم';
  }

  @override
  String queueSkillsRequested(int count, String date) {
    return '$count مهارات · طُلب في $date';
  }

  @override
  String get queueEmptyTitle => 'لا طلبات معلّقة';

  @override
  String get queueEmptyBody => 'تظهر طلبات الاعتماد الجديدة هنا.';

  @override
  String get reviewObserved => 'تمت الملاحظة';

  @override
  String get reviewCommentLabel => 'تعليق للمتعلّم';

  @override
  String get reviewCommentHint => 'التقنية الملاحَظة، الملاحظات، المتابعة…';

  @override
  String get reviewLockNote =>
      'يُسجَّل قرارك في سجل التدقيق غير القابل للتعديل.';

  @override
  String get reviewReject => 'رفض';

  @override
  String get reviewApprove => 'اعتماد';

  @override
  String get reviewCommentRequired => 'التعليق مطلوب عند الرفض.';

  @override
  String get reviewDefaultApproval => 'كفء. تمت الملاحظة والاعتماد.';

  @override
  String get reviewApprovedSnack => 'تم اعتماد الكفاءة';

  @override
  String get reviewRejectedSnack => 'أُعيد مع ملاحظات';

  @override
  String get decidedEmptyTitle => 'لا قرارات بعد';

  @override
  String get decidedEmptyBody => 'تظهر هنا طلبات الاعتماد المعتمدة والمعادة.';

  @override
  String get checkoutOrderSummary => 'ملخص الطلب';

  @override
  String checkoutLessonsCredits(int lessons, int credits) {
    return '$lessons دروس · $credits نقاط تطوير مهني';
  }

  @override
  String get checkoutSubtotal => 'المجموع الفرعي';

  @override
  String checkoutVat(String pct) {
    return 'ضريبة القيمة المضافة ($pct)';
  }

  @override
  String get checkoutTotal => 'الإجمالي';

  @override
  String get checkoutMethod => 'طريقة الدفع';

  @override
  String get checkoutCard => 'بطاقة';

  @override
  String get checkoutApplePay => 'Apple Pay';

  @override
  String get checkoutCardNumber => 'رقم البطاقة';

  @override
  String get checkoutCardHint => '4242 4242 4242 4242 (تجريبي)';

  @override
  String get checkoutExpiry => 'تاريخ الانتهاء';

  @override
  String get checkoutExpiryHint => 'MM / YY';

  @override
  String get checkoutCvc => 'CVC';

  @override
  String get checkoutErrorNumber => 'تحقّق من رقم البطاقة';

  @override
  String get checkoutErrorExpiry => 'أدخل تاريخًا صالحًا غير منتهٍ';

  @override
  String get checkoutErrorCvc => '3 أو 4 أرقام';

  @override
  String get checkoutApplePaySheet => 'واجهة Apple Pay (تجريبية)';

  @override
  String get checkoutApplePayHint => 'أكّد باستخدام Face ID على الجهاز';

  @override
  String get checkoutLockNote =>
      'PaymentGateway ← MockGateway حاليًا. يمكن إضافة محوّل Network International خلف الواجهة نفسها. لا تُسجَّل بيانات البطاقة أبدًا.';

  @override
  String checkoutPay(String amount) {
    return 'ادفع $amount';
  }

  @override
  String checkoutPayApple(String amount) {
    return 'ادفع عبر Apple Pay · $amount';
  }

  @override
  String get checkoutProcessing => 'جارٍ المعالجة…';

  @override
  String get checkoutDeclinedTitle => 'تم رفض الدفع';

  @override
  String get checkoutDeclinedBody =>
      'لم يُخصم أي مبلغ. تحقّق من البيانات أو جرّب طريقة أخرى.';

  @override
  String get checkoutCancelledBody =>
      'أُلغي الدفع عند التحقق ثلاثي الأبعاد. لم يُخصم أي مبلغ.';

  @override
  String get checkoutRetry => 'حاول مرة أخرى';

  @override
  String get threeDsTitle => 'التحقق ثلاثي الأبعاد (تجريبي)';

  @override
  String threeDsBody(String amount) {
    return 'يطلب منك المصرف تأكيد دفعة بقيمة $amount إلى ClinicalEdge.';
  }

  @override
  String get threeDsApprove => 'موافقة';

  @override
  String get threeDsCancel => 'إلغاء';

  @override
  String get receiptSuccess => 'تم الدفع بنجاح';

  @override
  String receiptInvoice(String number, String date) {
    return 'فاتورة ضريبية $number · $date';
  }

  @override
  String get receiptSeller => 'البائع';

  @override
  String receiptSellerValue(String name, String trn) {
    return '$name · الرقم الضريبي $trn';
  }

  @override
  String get receiptBilledTo => 'فوترة إلى';

  @override
  String get receiptItem => 'البند';

  @override
  String get receiptMethod => 'طريقة الدفع';

  @override
  String receiptCardMethod(String last4) {
    return 'بطاقة •••• $last4 (تجريبي)';
  }

  @override
  String get receiptApplePay => 'Apple Pay (تجريبي)';

  @override
  String receiptVat(String pct) {
    return 'ضريبة القيمة المضافة $pct';
  }

  @override
  String get receiptTotalPaid => 'الإجمالي المدفوع';

  @override
  String get receiptShare => 'مشاركة PDF';

  @override
  String get receiptStart => 'ابدأ الدورة';
}
