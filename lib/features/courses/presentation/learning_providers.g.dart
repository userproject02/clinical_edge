// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Catalogue categories.

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

/// Catalogue categories.

final class CategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CourseCategory>>,
          List<CourseCategory>,
          FutureOr<List<CourseCategory>>
        >
    with
        $FutureModifier<List<CourseCategory>>,
        $FutureProvider<List<CourseCategory>> {
  /// Catalogue categories.
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<CourseCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CourseCategory>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'af45d7b2b72f6cebc4b568153793eb2af261a99b';

/// Catalogue.

@ProviderFor(catalogue)
final catalogueProvider = CatalogueProvider._();

/// Catalogue.

final class CatalogueProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Course>>,
          List<Course>,
          FutureOr<List<Course>>
        >
    with $FutureModifier<List<Course>>, $FutureProvider<List<Course>> {
  /// Catalogue.
  CatalogueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogueHash();

  @$internal
  @override
  $FutureProviderElement<List<Course>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Course>> create(Ref ref) {
    return catalogue(ref);
  }
}

String _$catalogueHash() => r'7211e1284b04dc7d24be6b5480592dbc88671c96';

/// Owned course ids of the signed-in user.

@ProviderFor(ownedCourseIds)
final ownedCourseIdsProvider = OwnedCourseIdsProvider._();

/// Owned course ids of the signed-in user.

final class OwnedCourseIdsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Set<String>>,
          Set<String>,
          FutureOr<Set<String>>
        >
    with $FutureModifier<Set<String>>, $FutureProvider<Set<String>> {
  /// Owned course ids of the signed-in user.
  OwnedCourseIdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownedCourseIdsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownedCourseIdsHash();

  @$internal
  @override
  $FutureProviderElement<Set<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Set<String>> create(Ref ref) {
    return ownedCourseIds(ref);
  }
}

String _$ownedCourseIdsHash() => r'b38ce3546ec2cab7094cd081e4f6ab5ed51e2cd7';

/// Completed lessons of the signed-in user.

@ProviderFor(lessonProgress)
final lessonProgressProvider = LessonProgressProvider._();

/// Completed lessons of the signed-in user.

final class LessonProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LessonProgress>>,
          List<LessonProgress>,
          FutureOr<List<LessonProgress>>
        >
    with
        $FutureModifier<List<LessonProgress>>,
        $FutureProvider<List<LessonProgress>> {
  /// Completed lessons of the signed-in user.
  LessonProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonProgressHash();

  @$internal
  @override
  $FutureProviderElement<List<LessonProgress>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LessonProgress>> create(Ref ref) {
    return lessonProgress(ref);
  }
}

String _$lessonProgressHash() => r'3e5aaf6ff203224b7f0c912fd09112492ee5fd91';

/// Every course with ownership and progress (catalogue order).

@ProviderFor(courseProgressList)
final courseProgressListProvider = CourseProgressListProvider._();

/// Every course with ownership and progress (catalogue order).

final class CourseProgressListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CourseProgress>>,
          List<CourseProgress>,
          FutureOr<List<CourseProgress>>
        >
    with
        $FutureModifier<List<CourseProgress>>,
        $FutureProvider<List<CourseProgress>> {
  /// Every course with ownership and progress (catalogue order).
  CourseProgressListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courseProgressListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courseProgressListHash();

  @$internal
  @override
  $FutureProviderElement<List<CourseProgress>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CourseProgress>> create(Ref ref) {
    return courseProgressList(ref);
  }
}

String _$courseProgressListHash() =>
    r'819e0292a647cec2885a1fc274c21d307646546a';

/// One course with progress.

@ProviderFor(courseProgress)
final courseProgressProvider = CourseProgressFamily._();

/// One course with progress.

final class CourseProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<CourseProgress?>,
          CourseProgress?,
          FutureOr<CourseProgress?>
        >
    with $FutureModifier<CourseProgress?>, $FutureProvider<CourseProgress?> {
  /// One course with progress.
  CourseProgressProvider._({
    required CourseProgressFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'courseProgressProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$courseProgressHash();

  @override
  String toString() {
    return r'courseProgressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CourseProgress?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CourseProgress?> create(Ref ref) {
    final argument = this.argument as String;
    return courseProgress(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseProgressProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$courseProgressHash() => r'828a5a7b6863d96cd9a63265a5dd415ded73b535';

/// One course with progress.

final class CourseProgressFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CourseProgress?>, String> {
  CourseProgressFamily._()
    : super(
        retry: null,
        name: r'courseProgressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One course with progress.

  CourseProgressProvider call(String courseId) =>
      CourseProgressProvider._(argument: courseId, from: this);

  @override
  String toString() => r'courseProgressProvider';
}

/// Home totals.

@ProviderFor(learnerOverview)
final learnerOverviewProvider = LearnerOverviewProvider._();

/// Home totals.

final class LearnerOverviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<LearnerOverview>,
          LearnerOverview,
          FutureOr<LearnerOverview>
        >
    with $FutureModifier<LearnerOverview>, $FutureProvider<LearnerOverview> {
  /// Home totals.
  LearnerOverviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learnerOverviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learnerOverviewHash();

  @$internal
  @override
  $FutureProviderElement<LearnerOverview> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LearnerOverview> create(Ref ref) {
    return learnerOverview(ref);
  }
}

String _$learnerOverviewHash() => r'fc9f80265d158a6f3a5e957e238c1e57e1d99800';

/// Certifications of the signed-in user (soonest expiry first).

@ProviderFor(myCertifications)
final myCertificationsProvider = MyCertificationsProvider._();

/// Certifications of the signed-in user (soonest expiry first).

final class MyCertificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Certification>>,
          List<Certification>,
          FutureOr<List<Certification>>
        >
    with
        $FutureModifier<List<Certification>>,
        $FutureProvider<List<Certification>> {
  /// Certifications of the signed-in user (soonest expiry first).
  MyCertificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myCertificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myCertificationsHash();

  @$internal
  @override
  $FutureProviderElement<List<Certification>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Certification>> create(Ref ref) {
    return myCertifications(ref);
  }
}

String _$myCertificationsHash() => r'd041f4cde42bfb0908c8f40a9fef5d2330889e6b';

/// CPD config.

@ProviderFor(cpdConfig)
final cpdConfigProvider = CpdConfigProvider._();

/// CPD config.

final class CpdConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<CpdConfig>,
          CpdConfig,
          FutureOr<CpdConfig>
        >
    with $FutureModifier<CpdConfig>, $FutureProvider<CpdConfig> {
  /// CPD config.
  CpdConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cpdConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cpdConfigHash();

  @$internal
  @override
  $FutureProviderElement<CpdConfig> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<CpdConfig> create(Ref ref) {
    return cpdConfig(ref);
  }
}

String _$cpdConfigHash() => r'fa66dfdfd3f276f2a231fac317344eed4dbf2727';

/// CPD ledger of the signed-in user (newest first).

@ProviderFor(cpdLedger)
final cpdLedgerProvider = CpdLedgerProvider._();

/// CPD ledger of the signed-in user (newest first).

final class CpdLedgerProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CpdEntry>>,
          List<CpdEntry>,
          FutureOr<List<CpdEntry>>
        >
    with $FutureModifier<List<CpdEntry>>, $FutureProvider<List<CpdEntry>> {
  /// CPD ledger of the signed-in user (newest first).
  CpdLedgerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cpdLedgerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cpdLedgerHash();

  @$internal
  @override
  $FutureProviderElement<List<CpdEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CpdEntry>> create(Ref ref) {
    return cpdLedger(ref);
  }
}

String _$cpdLedgerHash() => r'f038505387c0426aeeecf7ce10a01fa364d6613c';

/// Quiz attempts of the signed-in user (newest first).

@ProviderFor(quizHistory)
final quizHistoryProvider = QuizHistoryProvider._();

/// Quiz attempts of the signed-in user (newest first).

final class QuizHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<QuizAttempt>>,
          List<QuizAttempt>,
          FutureOr<List<QuizAttempt>>
        >
    with
        $FutureModifier<List<QuizAttempt>>,
        $FutureProvider<List<QuizAttempt>> {
  /// Quiz attempts of the signed-in user (newest first).
  QuizHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quizHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<QuizAttempt>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<QuizAttempt>> create(Ref ref) {
    return quizHistory(ref);
  }
}

String _$quizHistoryHash() => r'4e8df5199959af7fd62a6ac62d91f4398b96e981';

/// Competency checklists.

@ProviderFor(checklists)
final checklistsProvider = ChecklistsProvider._();

/// Competency checklists.

final class ChecklistsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CompetencyChecklist>>,
          List<CompetencyChecklist>,
          FutureOr<List<CompetencyChecklist>>
        >
    with
        $FutureModifier<List<CompetencyChecklist>>,
        $FutureProvider<List<CompetencyChecklist>> {
  /// Competency checklists.
  ChecklistsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checklistsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checklistsHash();

  @$internal
  @override
  $FutureProviderElement<List<CompetencyChecklist>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CompetencyChecklist>> create(Ref ref) {
    return checklists(ref);
  }
}

String _$checklistsHash() => r'd45f5abd556fcfd5502f746d7f60bc42bb9bdbe8';

/// Sign-off requests of the signed-in learner.

@ProviderFor(mySignOffs)
final mySignOffsProvider = MySignOffsProvider._();

/// Sign-off requests of the signed-in learner.

final class MySignOffsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SignOffRequest>>,
          List<SignOffRequest>,
          FutureOr<List<SignOffRequest>>
        >
    with
        $FutureModifier<List<SignOffRequest>>,
        $FutureProvider<List<SignOffRequest>> {
  /// Sign-off requests of the signed-in learner.
  MySignOffsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mySignOffsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mySignOffsHash();

  @$internal
  @override
  $FutureProviderElement<List<SignOffRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SignOffRequest>> create(Ref ref) {
    return mySignOffs(ref);
  }
}

String _$mySignOffsHash() => r'595f0270914586d19acff43df7dfd2e187050dbc';

/// Marks a lesson complete and refreshes every view of progress.

@ProviderFor(completeLesson)
final completeLessonProvider = CompleteLessonProvider._();

/// Marks a lesson complete and refreshes every view of progress.

final class CompleteLessonProvider
    extends
        $FunctionalProvider<
          Future<LessonCompletion> Function(Course course, int index),
          Future<LessonCompletion> Function(Course course, int index),
          Future<LessonCompletion> Function(Course course, int index)
        >
    with
        $Provider<Future<LessonCompletion> Function(Course course, int index)> {
  /// Marks a lesson complete and refreshes every view of progress.
  CompleteLessonProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completeLessonProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completeLessonHash();

  @$internal
  @override
  $ProviderElement<Future<LessonCompletion> Function(Course course, int index)>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Future<LessonCompletion> Function(Course course, int index) create(Ref ref) {
    return completeLesson(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Future<LessonCompletion> Function(Course course, int index) value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            Future<LessonCompletion> Function(Course course, int index)
          >(value),
    );
  }
}

String _$completeLessonHash() => r'e617ac261e84e4452e42f4e775bae9280854f4e5';

/// Logs `course.view` for a course id (usage).

@ProviderFor(logCourseView)
final logCourseViewProvider = LogCourseViewProvider._();

/// Logs `course.view` for a course id (usage).

final class LogCourseViewProvider
    extends
        $FunctionalProvider<
          void Function(String courseId),
          void Function(String courseId),
          void Function(String courseId)
        >
    with $Provider<void Function(String courseId)> {
  /// Logs `course.view` for a course id (usage).
  LogCourseViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logCourseViewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logCourseViewHash();

  @$internal
  @override
  $ProviderElement<void Function(String courseId)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  void Function(String courseId) create(Ref ref) {
    return logCourseView(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void Function(String courseId) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void Function(String courseId)>(
        value,
      ),
    );
  }
}

String _$logCourseViewHash() => r'd23c640c0872c900f9dbd2236d309d34b3512f3f';

/// Logs `lesson.view` (usage).

@ProviderFor(logLessonView)
final logLessonViewProvider = LogLessonViewProvider._();

/// Logs `lesson.view` (usage).

final class LogLessonViewProvider
    extends
        $FunctionalProvider<
          void Function(Course course, int index),
          void Function(Course course, int index),
          void Function(Course course, int index)
        >
    with $Provider<void Function(Course course, int index)> {
  /// Logs `lesson.view` (usage).
  LogLessonViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logLessonViewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logLessonViewHash();

  @$internal
  @override
  $ProviderElement<void Function(Course course, int index)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  void Function(Course course, int index) create(Ref ref) {
    return logLessonView(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void Function(Course course, int index) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<void Function(Course course, int index)>(value),
    );
  }
}

String _$logLessonViewHash() => r'b4a3c02d3ab977159490eaa99aa8cf9859ae1bd4';
