import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/money.dart';
import 'package:clinical_edge/core/payments/payment_gateway.dart';
import 'package:clinical_edge/features/checkout/data/checkout_repository.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';

/// Result of [PurchaseCourse].
sealed class PurchaseOutcome {
  const new();
}

/// Paid: the order (with invoice number) is saved and the course unlocked.
final class Purchased extends PurchaseOutcome {
  /// Creates the outcome.
  const new(this.order);

  /// The paid order.
  final Order order;
}

/// The gateway declined.
final class PurchaseDeclined extends PurchaseOutcome {
  /// Creates the outcome.
  const new(this.reason);

  /// Gateway reason code.
  final String reason;
}

/// The bank wants 3-D Secure; call [PurchaseCourse.complete3ds] after the
/// challenge.
final class PurchaseNeeds3ds extends PurchaseOutcome {
  /// Creates the outcome.
  const new({required this.order, required this.intent, required this.url});

  /// Unpaid order.
  final Order order;

  /// Gateway intent.
  final PaymentIntent intent;

  /// Challenge page.
  final Uri url;
}

/// PAY-1 / PAY-2: one use case records the order, unlocks the course and
/// writes the `purchase` audit event (amount and invoice number only; never
/// card data).
class PurchaseCourse {
  /// Creates the use case.
  const new({
    required this.gateway,
    required this.checkout,
    required this.courses,
    required this.logger,
  });

  /// Payment gateway (MockGateway in v1).
  final PaymentGateway gateway;

  /// Orders and receipts.
  final CheckoutRepository checkout;

  /// Ownership.
  final CourseRepository courses;

  /// Activity logger.
  final ActivityLogger logger;

  /// Pays for [course] with [method]. [cardLast4] is kept for the receipt.
  Future<PurchaseOutcome> call({
    required String userId,
    required Course course,
    required PaymentMethod method,
    String? cardLast4,
  }) async {
    final order = await checkout.createOrder(userId, course);
    final intent = await gateway.createIntent(order);
    final result = await gateway.confirm(intent, method);
    return switch (result) {
      PaymentSucceeded(:final reference) => Purchased(
        await _settle(userId, course, order, method, reference, cardLast4),
      ),
      PaymentFailed(:final reason) => PurchaseDeclined(reason),
      PaymentNeeds3ds(:final challengeUrl) => PurchaseNeeds3ds(
        order: order,
        intent: intent,
        url: challengeUrl,
      ),
    };
  }

  /// Finishes a purchase after the user approved the 3-D Secure challenge.
  Future<Order> complete3ds({
    required String userId,
    required Course course,
    required PurchaseNeeds3ds pending,
    required PaymentMethod method,
    String? cardLast4,
  }) => _settle(
    userId,
    course,
    pending.order,
    method,
    '3ds_${pending.intent.id}',
    cardLast4,
  );

  Future<Order> _settle(
    String userId,
    Course course,
    Order order,
    PaymentMethod method,
    String reference,
    String? cardLast4,
  ) async {
    final paid = await checkout.completeOrder(
      order,
      method: method,
      reference: reference,
      cardLast4: cardLast4,
    );
    await courses.grantOwnership(userId, course.id);
    await logger.audit(
      AuditAction.purchase,
      target:
          '${course.title.en} · AED ${Money(paid.totalFils).plain} · '
          '${paid.invoiceNo}',
    );
    return paid;
  }
}
