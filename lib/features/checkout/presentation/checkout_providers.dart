import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/payments/payment_gateway.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/checkout/data/checkout_repository.dart';
import 'package:clinical_edge/features/checkout/domain/purchase_course.dart';
import 'package:clinical_edge/features/courses/data/course_repository.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'checkout_providers.g.dart';

/// Seller for receipts.
@riverpod
Future<Seller> seller(Ref ref) =>
    ref.watch(checkoutRepositoryProvider).seller();

/// One order.
@riverpod
Future<Order?> order(Ref ref, String orderId) =>
    ref.watch(checkoutRepositoryProvider).byId(orderId);

/// Logs `checkout.start` (usage) for a course.
@Riverpod(keepAlive: true)
void Function(Course course) logCheckoutStart(Ref ref) =>
    (course) => ref
        .read(activityLoggerProvider)
        .usage(UsageAction.checkoutStart, target: course.title.en);

/// Mock payment token: stands in for the gateway SDK's tokenisation. It
/// carries no card data.
String mockPaymentToken(String kind) => '${kind}_mock_${const Uuid().v4()}';

PurchaseCourse _useCase(Ref ref) => PurchaseCourse(
  gateway: ref.read(paymentGatewayProvider),
  checkout: ref.read(checkoutRepositoryProvider),
  courses: ref.read(courseRepositoryProvider),
  logger: ref.read(activityLoggerProvider),
);

String _uid(Ref ref) => ref.read(sessionProvider).value?.user.id ?? '';

void _refresh(Ref ref, PurchaseOutcome o) {
  if (o is Purchased) ref.invalidate(ownedCourseIdsProvider);
}

/// Pays for a course (PAY-1); refreshes ownership on success.
@Riverpod(keepAlive: true)
Future<PurchaseOutcome> Function(
  Course course,
  PaymentMethod method, {
  String? cardLast4,
})
purchaseCourse(Ref ref) => (course, method, {cardLast4}) async {
  final o = await _useCase(ref)(
    userId: _uid(ref),
    course: course,
    method: method,
    cardLast4: cardLast4,
  );
  _refresh(ref, o);
  return o;
};

/// Completes a purchase after an approved 3-D Secure challenge.
@Riverpod(keepAlive: true)
Future<Order> Function(
  Course course,
  PurchaseNeeds3ds pending,
  PaymentMethod method, {
  String? cardLast4,
})
complete3ds(Ref ref) => (course, pending, method, {cardLast4}) async {
  final paid = await _useCase(ref).complete3ds(
    userId: _uid(ref),
    course: course,
    pending: pending,
    method: method,
    cardLast4: cardLast4,
  );
  ref.invalidate(ownedCourseIdsProvider);
  return paid;
};
