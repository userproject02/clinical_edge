import 'dart:async';

import 'package:clinical_edge/core/payments/payment_gateway.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

final _order = Order(
  id: 'ord-1',
  userId: 'u-layla',
  courseId: 'c3',
  subtotalFils: 30000,
  vatFils: 1500,
  totalFils: 31500,
  createdAt: DateTime.utc(2026, 11, 17, 5),
);

void main() {
  test('TC-PAY-1-04 MockGateway succeeds after 1.5 s by default', () {
    fakeAsync((async) {
      const gw = MockGateway();
      PaymentResult? result;
      unawaited(
        gw.createIntent(_order).then((intent) {
          expect(intent.amountFils, 31500);
          expect(intent.currency, 'AED');
          unawaited(
            gw
                .confirm(intent, const CardMethod('tok_visa'))
                .then((r) => result = r),
          );
        }),
      );
      async.elapse(const Duration(milliseconds: 1499));
      expect(result, isNull);
      async.elapse(const Duration(milliseconds: 1));
      expect(result, isA<PaymentSucceeded>());
      expect((result! as PaymentSucceeded).reference, isNotEmpty);
    });
  });

  test('TC-PAY-1-05 debug modes force Failed and Needs3ds', () async {
    const fail = MockGateway(mode: MockGatewayMode.fail, delay: Duration.zero);
    const tds = MockGateway(
      mode: MockGatewayMode.needs3ds,
      delay: Duration.zero,
    );
    final intent = await fail.createIntent(_order);
    final r1 = await fail.confirm(intent, const ApplePayMethod('tok_ap'));
    expect(r1, isA<PaymentFailed>());
    final r2 = await tds.confirm(intent, const CardMethod('tok'));
    expect(r2, isA<PaymentNeeds3ds>());
    expect((r2 as PaymentNeeds3ds).challengeUrl.scheme, 'https');
    expect(const CardMethod('t').name, 'card');
    expect(const ApplePayMethod('t').name, 'apple_pay');
  });

  test('TC-PAY-1-06 Order round-trips through JSON', () {
    final paid = _order.copyWith(
      invoiceNo: 'CE-2026-001041',
      method: 'card',
      paidAt: DateTime.utc(2026, 11, 17, 5, 3),
    );
    expect(Order.fromJson(paid.toJson()), paid);
  });
}
