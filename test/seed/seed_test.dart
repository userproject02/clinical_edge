import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/json_converters.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/features/admin/domain/cohort.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:clinical_edge/seed/seed_loader.dart';
import 'package:flutter_test/flutter_test.dart';

final RegExp _arabic = RegExp('[؀-ۿ]');

/// Every `{en, ar}` object in [node]; also flags objects with only one.
void _walk(Object? node, String path, List<String> problems, List<Json> pairs) {
  if (node is Map) {
    final m = node.cast<String, Object?>();
    final hasEn = m.containsKey('en');
    final hasAr = m.containsKey('ar');
    if (hasEn || hasAr) {
      if (!hasEn || !hasAr) problems.add('$path: missing en or ar');
      final en = m['en'];
      final ar = m['ar'];
      if (en is! String || en.trim().isEmpty) problems.add('$path.en empty');
      if (ar is! String || ar.trim().isEmpty) problems.add('$path.ar empty');
      pairs.add(m);
    }
    for (final e in m.entries) {
      _walk(e.value, '$path.${e.key}', problems, pairs);
    }
  } else if (node is List) {
    for (var i = 0; i < node.length; i++) {
      _walk(node[i], '$path[$i]', problems, pairs);
    }
  }
}

void main() {
  final seed = AssetSeedLoader();

  test('TC-SEED-01 every seed file loads into its models', () async {
    final users = (await seed.load(SeedFile.users)).objects('users');
    expect(users.map(AppUser.fromJson), hasLength(7));

    final courses = (await seed.load(SeedFile.courses))
        .objects('courses')
        .map(Course.fromJson)
        .toList();
    expect(courses.map((c) => c.id), <String>['c1', 'c2', 'c3']);
    expect(courses.map((c) => c.lessons.length), <int>[6, 5, 4]);
    expect(courses.map((c) => c.priceFils), <int>[35000, 25000, 30000]);
    expect(courses.map((c) => c.cpdCredits), <int>[4, 3, 2]);
    expect(courses.map((c) => c.durationMin), <int>[200, 160, 125]);

    final bank = await seed.load(SeedFile.questionBank);
    final qs = bank.objects('questions').map(Question.fromJson).toList();
    expect(qs, hasLength(20));
    for (final q in qs) {
      expect(q.options, hasLength(4), reason: q.id);
      expect(q.correctIndex, inInclusiveRange(0, 3), reason: q.id);
      expect(q.sourceGuideline, isNotEmpty, reason: q.id);
    }
    expect(qs.map((q) => q.topic).toSet(), <String>{
      'resuscitation',
      'infection_control',
      'medication_safety',
    });
    expect(qs.where((q) => q.topic == 'resuscitation'), hasLength(8));
    expect(bank.objects('history').map(QuizAttempt.fromJson), hasLength(2));

    final certs = (await seed.load(SeedFile.certifications))
        .objects('certifications')
        .map(Certification.fromJson);
    expect(certs, hasLength(2));

    final cpd = await seed.load(SeedFile.cpd);
    expect(CpdConfig.fromJson(cpd).target, 40);
    final ledger = cpd.objects('ledger').map(CpdEntry.fromJson).toList();
    expect(ledger.fold<int>(0, (s, e) => s + e.credits), 26);

    final checklists = (await seed.load(SeedFile.checklists))
        .objects('checklists')
        .map(CompetencyChecklist.fromJson)
        .toList();
    expect(checklists.map((c) => c.items.length), <int>[4, 4]);

    final requests = (await seed.load(SeedFile.signoffs))
        .objects('requests')
        .map(SignOffRequest.fromJson)
        .toList();
    expect(requests.map((r) => r.status.name), <String>[
      'none',
      'approved',
      'pending',
      'pending',
      'rejected',
    ]);

    final cohort = CohortStats.fromJson(await seed.load(SeedFile.cohort));
    expect(cohort.demoFigures, isTrue);
    expect(cohort.kpis.activeLearners, 142);
    expect(cohort.kpis.nursing + cohort.kpis.physicians, 142);
    expect(cohort.expiriesByMonth.fold<int>(0, (s, m) => s + m.count), 34);
    expect(cohort.insights.dropOff.retainedPctByLesson, hasLength(6));

    final audit = (await seed.load(SeedFile.auditSeed)).objects('events');
    expect(audit, hasLength(10));
  });

  test('TC-SEED-02 every user-facing string has English and Arabic', () async {
    final problems = <String>[];
    var count = 0;
    for (final f in SeedFile.values) {
      final pairs = <Json>[];
      _walk(await seed.load(f), f.fileName, problems, pairs);
      for (final p in pairs) {
        final ar = p['ar']! as String;
        // Brand name may stay Latin; anything else with words needs Arabic.
        // Pure numbers ("30:2") are the same in both languages.
        final hasLatinLetters = RegExp('[A-Za-z]').hasMatch(ar);
        if (ar != 'ClinicalEdge' && hasLatinLetters && !_arabic.hasMatch(ar)) {
          problems.add('${f.fileName}: "$ar" has no Arabic text');
        }
        expect(() => LocalizedText.fromJson(p), returnsNormally);
      }
      count += pairs.length;
    }
    expect(problems, isEmpty);
    expect(count, greaterThan(180));
  });

  test('TC-SEED-03 the eight required questions are in the bank', () async {
    final qs = (await seed.load(SeedFile.questionBank))
        .objects('questions')
        .map(Question.fromJson)
        .toList();
    String answer(String promptPart) {
      final q = qs.firstWhere((q) => q.prompt.en.contains(promptPart));
      return q.options[q.correctIndex].en;
    }

    expect(answer('compression rate'), '100–120 per minute');
    expect(answer('How deep'), '5–6 cm');
    expect(answer('single rescuer'), '30:2');
    expect(
      answer('after an AED delivers'),
      contains('starting with chest compressions'),
    );
    expect(answer('5 Moments'), 'Before a clean/aseptic procedure');
    expect(answer('hand rub'), '20–30 seconds');
    expect(answer('used needle'), contains('without recapping'));
    expect(
      answer("patient's identity"),
      contains('at least two patient identifiers'),
    );
  });

  test('TC-SEED-04 demo time in demo.json matches the code', () async {
    final demo = await seed.load(SeedFile.demo);
    expect(
      const UtcDateTimeConverter().fromJson(demo['demoNow']! as String),
      demoNow,
    );
  });

  test('TC-SEED-05 no patient data: users are staff only', () async {
    final users = (await seed.load(SeedFile.users)).objects('users');
    for (final u in users) {
      expect(u['email'], endsWith('@demo-hospital.example'));
    }
    for (final f in SeedFile.values) {
      final text = (await seed.load(f)).toString().toLowerCase();
      for (final banned in <String>[
        'mrn',
        'emirates id',
        'diagnosis:',
        'dob',
      ]) {
        expect(
          text.contains(banned),
          isFalse,
          reason: '${f.fileName}: $banned',
        );
      }
    }
  });
}
