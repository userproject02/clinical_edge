import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/notifications.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/notifications/local_notifier.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/certifications/data/certification_repository.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/certifications/domain/reminder_service.dart';
import 'package:clinical_edge/features/certifications/domain/upload_certificate.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app_harness.dart';

const _layla = 'u-layla';
const _text = LocalizedText(en: 'X', ar: 'X');

Finder _t(String s) => find.byWidgetPredicate(
  (w) =>
      w is Text &&
      (w.data ?? '').replaceAll(RegExp(r'[\u2066-\u2069]'), '').contains(s),
);

Future<void> _go(WidgetTester t, ProviderContainer c, String path) async {
  c.read(routerProvider).go(path);
  await settle(t);
}

Future<void> _tap(WidgetTester t, Finder f) async {
  await t.ensureVisible(f);
  await t.tap(f);
  await settle(t);
}

/// Lets timed overlays (banner 4 s, snackbar 3.2 s) finish.
Future<void> _drainOverlays(WidgetTester t) async {
  await t.pump(const Duration(seconds: 6));
  await t.pump(const Duration(seconds: 1));
}

RecordingLocalNotifier _notifier(ProviderContainer c) =>
    c.read(localNotificationsProvider) as RecordingLocalNotifier;

Certification _cert(DateTime expires, {Verification? v}) => Certification(
  id: 'c-$expires',
  userId: _layla,
  name: _text,
  issuer: _text,
  issuedOn: DateTime.utc(2025),
  expiresOn: expires,
  verification: v ?? Verification.verified,
  code: 'X',
);

void main() {
  final clock = FixedClock(demoNow);
  final today = clock.today(); // 2026-11-17

  group('CERT-1 status', () {
    test('TC-CERT-1-03 boundaries 91/90/1/0 days (FixedClock)', () {
      CertStatus at(int days) =>
          _cert(today.add(Duration(days: days))).status(clock);
      expect(at(91), CertStatus.valid);
      expect(at(90), CertStatus.renewSoon);
      expect(at(1), CertStatus.renewSoon);
      expect(at(0), CertStatus.expired);
      expect(at(-1), CertStatus.expired);
      expect(
        _cert(
          today.add(const Duration(days: 400)),
          v: Verification.pending,
        ).status(clock),
        CertStatus.verifying,
      );
    });

    testWidgets('TC-CERT-1-04 certs list: status, expiry, days, meter', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.certs);
      final bls = find.byKey(const Key('cert.cert-bls'));
      await tester.ensureVisible(bls);
      expect(
        find.descendant(of: bls, matching: find.text('BLS Provider')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: bls, matching: find.text('Renew soon')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: bls, matching: _t('Expires 12 Jan 2027')),
        findsOneWidget,
      );
      expect(find.descendant(of: bls, matching: _t('56 days')), findsOneWidget);
      final meter = tester.widget<LinearMeter>(
        find.descendant(of: bls, matching: find.byType(LinearMeter)),
      );
      expect(meter.value, closeTo(56 / 730, 1e-9));
      final acls = find.byKey(const Key('cert.cert-acls'));
      expect(
        find.descendant(of: acls, matching: find.text('Valid')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: acls, matching: _t('317 days')),
        findsOneWidget,
      );
    });
  });

  group('CERT-2 CPD', () {
    testWidgets('TC-CERT-2-03 ring = ledger total; ledger newest first', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.certs);
      final ledger = c.read(cpdLedgerProvider).value!;
      final total = ledger.fold(0, (s, e) => s + e.credits);
      expect(total, 26);
      expect(
        find.descendant(
          of: find.byKey(const Key('certs.cpdTotal')),
          matching: _t('$total'),
        ),
        findsOneWidget,
      );
      expect(_t('of 40'), findsOneWidget);
      expect(find.text('CPD/CME credits · 2026'), findsOneWidget);
      expect(find.text('14 credits to reach your target'), findsOneWidget);
      expect(
        find.text(
          'Demo target; your licensing authority sets the real requirement.',
        ),
        findsOneWidget,
      );
      final rows = ledger.map((e) => find.byKey(Key('ledger.${e.id}')));
      await tester.ensureVisible(rows.last);
      final ys = [for (final r in rows) tester.getTopLeft(r).dy];
      expect(ys, orderedEquals([...ys]..sort()), reason: 'newest first');
      expect(ledger.first.id, 'cpd-004');
      expect(
        find.descendant(of: rows.first, matching: _t('+2')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: rows.first, matching: _t('4 Nov 2026 · External')),
        findsOneWidget,
      );
    });

    testWidgets('TC-CERT-2-04 a new ledger line moves the ring with it', (
      tester,
    ) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await tester.runAsync(
        () => c
            .read(cpdRepositoryProvider)
            .add(
              CpdEntry(
                id: 'cpd-test',
                userId: _layla,
                date: today,
                activity: const LocalizedText(en: 'Journal club', ar: 'نادي'),
                source: CpdSource.external,
                credits: 5,
              ),
            ),
      );
      c.invalidate(cpdLedgerProvider);
      await _go(tester, c, AppRoutes.certs);
      expect(
        find.descendant(
          of: find.byKey(const Key('certs.cpdTotal')),
          matching: _t('31'),
        ),
        findsOneWidget,
      );
      expect(find.text('9 credits to reach your target'), findsOneWidget);
      expect(find.text('Journal club'), findsOneWidget);
    });
  });

  group('CERT-3 upload', () {
    test('TC-CERT-3-03 validation rules and short name', () {
      final issued = DateTime.utc(2026, 11, 17);
      expect(
        UploadCertificate.validate(
          name: ' ',
          issuedOn: issued,
          expiresOn: null,
        ),
        {UploadError.nameRequired, UploadError.expiryRequired},
      );
      expect(
        UploadCertificate.validate(
          name: 'NRP',
          issuedOn: issued,
          expiresOn: issued,
        ),
        {UploadError.expiryBeforeIssue},
      );
      expect(
        UploadCertificate.validate(
          name: 'NRP',
          issuedOn: issued,
          expiresOn: issued.add(const Duration(days: 1)),
        ),
        isEmpty,
      );
      expect(shortCertName('Neonatal Resuscitation Program (NRP)'), 'NRP');
      expect(shortCertName('PALS Provider'), 'PALS Provider');
    });

    testWidgets('TC-CERT-3-04 upload sheet: validation, Verifying, '
        'cert.upload audit, snackbar', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.certs);
      await _tap(tester, find.byKey(const Key('certs.upload')));
      expect(find.text('Upload certificate'), findsOneWidget);
      expect(find.text('Scan with camera or choose a file'), findsOneWidget);
      expect(find.text('Neonatal Resuscitation Program (NRP)'), findsOneWidget);

      await _tap(tester, find.byKey(const Key('upload.submit')));
      expect(find.text('Enter the certificate name'), findsOneWidget);
      expect(find.text('Choose an expiry date'), findsOneWidget);

      await _tap(tester, find.byKey(const Key('upload.dropZone')));
      expect(find.text('NRP_certificate.pdf'), findsOneWidget);
      expect(_t('412 KB'), findsOneWidget);
      await tester.enterText(
        find.byKey(const Key('upload.name')),
        'Neonatal Resuscitation Program (NRP)',
      );
      await _tap(tester, find.byKey(const Key('upload.expires')));
      await _tap(tester, find.text('OK'));
      expect(find.text('Choose an expiry date'), findsNothing);
      expect(find.text('Enter the certificate name'), findsNothing);
      expect(_t('17 Nov 2028'), findsOneWidget);

      await _tap(tester, find.byKey(const Key('upload.submit')));
      expect(
        c.read(routerProvider).routerDelegate.currentConfiguration.uri.path,
        AppRoutes.certs,
      );
      expect(find.text('Certificate uploaded'), findsOneWidget);
      expect(find.text('NRP is pending verification'), findsOneWidget);

      final certs = await tester.runAsync(
        () => c.read(certificationRepositoryProvider).list(_layla),
      );
      final nrp = certs!.singleWhere(
        (x) => x.name.en == 'Neonatal Resuscitation Program (NRP)',
      );
      expect(nrp.status(clock), CertStatus.verifying);
      expect(nrp.fileRef, startsWith('demo-upload-'));
      expect(nrp.fileRef, isNot(contains('NRP_certificate')));
      final row = find.byKey(Key('cert.${nrp.id}'));
      await tester.ensureVisible(row);
      expect(
        find.descendant(of: row, matching: find.text('Verifying')),
        findsOneWidget,
      );

      final audit = await tester.runAsync(
        () => c.read(auditStoreProvider).list(),
      );
      expect(
        audit!.where((e) => e.action == 'cert.upload').map((e) => e.target),
        ['Neonatal Resuscitation Program (NRP) · pending verification'],
      );
      await _drainOverlays(tester);
    });
  });

  group('CERT-4 reminders', () {
    test('TC-CERT-4-03 reminder dates: 90/60/30/7 days before, future only, '
        '09:00 Dubai', () {
      final service = ReminderService(clock: clock);
      final bls = _cert(DateTime.utc(2027, 1, 12));
      final acls = _cert(DateTime.utc(2027, 9, 30));
      final pending = _cert(DateTime.utc(2027, 3), v: Verification.pending);
      final slots = service.upcoming([bls, acls, pending]);
      expect(slots.map((s) => s.at), <DateTime>[
        DateTime.utc(2026, 12, 13, 5),
        DateTime.utc(2027, 1, 5, 5),
        DateTime.utc(2027, 7, 2, 5),
        DateTime.utc(2027, 8, 1, 5),
        DateTime.utc(2027, 8, 31, 5),
        DateTime.utc(2027, 9, 23, 5),
      ]);
      expect(slots.map((s) => s.daysBefore), [30, 7, 90, 60, 30, 7]);
      expect(slots.map((s) => s.id).toSet(), hasLength(6));
      expect(service.due([acls, bls, pending]), bls);
      expect(service.due([acls]), isNull);
      expect(service.simulated([acls]), acls);
    });

    testWidgets('TC-CERT-4-04 switch is shared with Profile, persists, asks '
        'permission and (un)schedules', (tester) async {
      final db = InMemoryLocalDb();
      final c = await pumpClinicalEdge(
        tester,
        db: db,
        signedInAs: Role.learner,
      );
      await _go(tester, c, AppRoutes.certs);
      final n = _notifier(c);
      expect(n.scheduled, hasLength(6));

      await _tap(tester, find.byKey(const Key('certs.remindersSwitch')));
      expect(c.read(notificationsEnabledProvider), isFalse);
      expect(
        c.read(sharedPreferencesProvider).getBool(PrefKeys.notifications),
        isFalse,
      );
      expect(n.scheduled, isEmpty);
      await _go(tester, c, AppRoutes.profile);
      expect(
        tester
            .widget<Switch>(find.byKey(const Key('profile.notifications')))
            .value,
        isFalse,
      );

      await _tap(tester, find.byKey(const Key('profile.notifications')));
      expect(n.permissionRequests, 1);
      expect(c.read(notificationsEnabledProvider), isTrue);
      await _go(tester, c, AppRoutes.certs);
      expect(
        tester
            .widget<Switch>(find.byKey(const Key('certs.remindersSwitch')))
            .value,
        isTrue,
      );
      expect(n.scheduled, hasLength(6));
      expect(n.scheduled.first.title, 'BLS certificate expires in 30 days');
      expect(
        n.scheduled.first.body,
        'Renew before 12 Jan 2027 to stay compliant.',
      );
    });

    testWidgets('TC-CERT-4-05 simulate: banner, local notification, '
        'notify.reminder; bell lists the reminder', (tester) async {
      final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);
      await _go(tester, c, AppRoutes.certs);
      await _tap(tester, find.byKey(const Key('certs.simulate')));
      expect(find.text('BLS certificate expires in 56 days'), findsOneWidget);
      expect(_t('Renew before 12 Jan 2027 to stay compliant.'), findsOneWidget);
      expect(_notifier(c).shown, hasLength(1));
      await _drainOverlays(tester);

      // The bell opens the notifications sheet (no device notification).
      await _go(tester, c, AppRoutes.home);
      await _tap(tester, find.byTooltip('Notifications'));
      expect(
        find.descendant(
          of: find.byKey(const Key('inbox.sheet')),
          matching: find.text('BLS certificate expires in 56 days'),
        ),
        findsOneWidget,
      );
      expect(_notifier(c).shown, hasLength(1));
      await tester.tapAt(const Offset(20, 20));
      await settle(tester);

      // Switch off: banner only, no device notification.
      await c.read(notificationsEnabledProvider.notifier).set(enabled: false);
      await _go(tester, c, AppRoutes.certs);
      await _tap(tester, find.byKey(const Key('certs.simulate')));
      expect(find.text('BLS certificate expires in 56 days'), findsOneWidget);
      expect(_notifier(c).shown, hasLength(1));
      await _drainOverlays(tester);

      final usage = await tester.runAsync(
        () => c.read(usageStoreProvider).list(),
      );
      expect(
        usage!.where((e) => e.action == 'notify.reminder').map((e) => e.target),
        ['BLS · 56 days', 'BLS · 56 days'],
      );
    });
  });

  group('Screen goldens', () {
    for (final (theme, locale) in <(String, String)>[
      ('light', 'en'),
      ('dark', 'en'),
      ('light', 'ar'),
      ('dark', 'ar'),
    ]) {
      final dir = locale == 'ar' ? 'rtl' : 'ltr';
      for (final (name, path) in <(String, String)>[
        ('certs', AppRoutes.certs),
        ('upload_sheet', AppRoutes.certUpload),
      ]) {
        testWidgets('$name golden ($theme $dir)', (tester) async {
          final c = await pumpClinicalEdge(
            tester,
            prefs: <String, Object>{
              PrefKeys.themeMode: theme,
              PrefKeys.locale: locale,
            },
            signedInAs: Role.learner,
          );
          await _go(tester, c, path);
          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile('goldens/${name}_${theme}_$dir.png'),
          );
        }, tags: <String>['golden']);
      }
    }
  });
}
