import 'dart:convert';

import 'package:clinical_edge/app/router.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'helpers/test_app_harness.dart';

const _password = 'Hunter2-Secret!';
const _pan = '4242424242424242';
const _cvc = '987';
const _comment = 'Observed the PATIENT-LIKE free text here';
const _fileName = 'NRP_certificate.pdf';

Future<void> _go(WidgetTester t, ProviderContainer c, String path) async {
  c.read(routerProvider).go(path);
  await settle(t);
}

Future<void> _tap(WidgetTester t, Finder f) async {
  await t.ensureVisible(f);
  await t.tap(f);
  await settle(t);
}

Future<void> _signIn(WidgetTester t, ProviderContainer c, Role role) async {
  await t.runAsync(
    () => c
        .read(sessionProvider.notifier)
        .signIn(
          email: 'demo@demo-hospital.example',
          password: _password,
          role: role,
        ),
  );
  c.read(firstHomeLoadProvider.notifier).done();
  await settle(t);
}

void main() {
  testWidgets('TC-NFR-PRIV-01 audit and usage stores never hold passwords, '
      'card data, comments or file contents', (tester) async {
    final c = await pumpClinicalEdge(tester, signedInAs: Role.learner);

    // Card purchase.
    await _go(tester, c, AppRoutes.checkout('c3'));
    await tester.enterText(find.byKey(const Key('checkout.number')), _pan);
    await tester.enterText(find.byKey(const Key('checkout.expiry')), '1228');
    await tester.enterText(find.byKey(const Key('checkout.cvc')), _cvc);
    await _tap(tester, find.byKey(const Key('checkout.pay')));
    expect(find.text('Payment successful'), findsOneWidget);

    // Certificate upload (mock file).
    await _go(tester, c, AppRoutes.certUpload);
    await _tap(tester, find.byKey(const Key('upload.dropZone')));
    await tester.enterText(find.byKey(const Key('upload.name')), 'NRP');
    await _tap(tester, find.byKey(const Key('upload.expires')));
    await _tap(tester, find.text('OK'));
    await _tap(tester, find.byKey(const Key('upload.submit')));
    await tester.pump(const Duration(seconds: 5));

    // Sign-off request, then a supervisor rejection with a comment.
    await _go(tester, c, AppRoutes.signoffs);
    await _tap(tester, find.byKey(const Key('signoff.cl1.request')));
    await tester.pump(const Duration(seconds: 5));
    await _signIn(tester, c, Role.supervisor);
    await _go(tester, c, AppRoutes.queue);
    await _tap(tester, find.byKey(const Key('queue.so-001')));
    await tester.enterText(find.byKey(const Key('review.comment')), _comment);
    await _tap(tester, find.byKey(const Key('review.reject')));
    await tester.pump(const Duration(seconds: 5));

    final logged = (await tester.runAsync(() async {
      final out = StringBuffer();
      for (final e in await c.read(auditStoreProvider).list()) {
        out.writeln(jsonEncode(e.toJson()));
      }
      for (final e in await c.read(usageStoreProvider).list()) {
        out.writeln(jsonEncode(e.toJson()));
      }
      return out.toString();
    }))!;
    expect(logged, contains('purchase'));
    expect(logged, contains('cert.upload'));
    expect(logged, contains('signoff.decision'));
    for (final secret in <String>[
      _password,
      _pan,
      '4242 4242 4242 4242',
      _comment,
      _fileName,
      'demo@demo-hospital.example',
    ]) {
      expect(logged.contains(secret), isFalse, reason: 'logged "$secret"');
    }
    expect(RegExp('"$_cvc"|[^0-9]$_cvc[^0-9]').hasMatch(logged), isFalse);
  });
}
