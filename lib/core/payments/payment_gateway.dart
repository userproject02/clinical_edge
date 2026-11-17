import 'package:clinical_edge/core/json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_gateway.freezed.dart';
part 'payment_gateway.g.dart';

/// A course order. Money in integer fils.
@freezed
abstract class Order with _$Order {
  /// Creates an order.
  const factory({
    required String id,
    required String userId,
    required String courseId,
    required int subtotalFils,
    required int vatFils,
    required int totalFils,
    @UtcDateTimeConverter() required DateTime createdAt,
    String? method,
    String? invoiceNo,
    String? paymentReference,
    @NullableUtcDateTimeConverter() DateTime? paidAt,
  }) = _Order;

  /// Decodes JSON.
  factory fromJson(Map<String, Object?> json) => _$OrderFromJson(json);
}

/// A gateway-side intent to collect [amountFils] for an order.
@immutable
class PaymentIntent {
  /// Creates an intent.
  const new({
    required this.id,
    required this.orderId,
    required this.amountFils,
    this.currency = 'AED',
  });

  /// Intent id.
  final String id;

  /// Order being paid.
  final String orderId;

  /// Amount in fils.
  final int amountFils;

  /// ISO currency code.
  final String currency;
}

/// How the buyer pays. Raw card numbers never reach the app: the gateway
/// SDK (or hosted fields) tokenises them.
sealed class PaymentMethod {
  const new();

  /// Name stored on the order (`card`, `apple_pay`).
  String get name;
}

/// Tokenised card.
final class CardMethod extends PaymentMethod {
  /// Creates the method.
  const new(this.token);

  /// Gateway token (never a PAN).
  final String token;

  @override
  String get name => 'card';
}

/// Apple Pay payment token.
final class ApplePayMethod extends PaymentMethod {
  /// Creates the method.
  const new(this.token);

  /// Apple Pay token.
  final String token;

  @override
  String get name => 'apple_pay';
}

/// Outcome of [PaymentGateway.confirm].
sealed class PaymentResult {
  const new();
}

/// Paid.
final class PaymentSucceeded extends PaymentResult {
  /// Creates the result.
  const new(this.reference);

  /// Gateway reference.
  final String reference;
}

/// Declined or failed.
final class PaymentFailed extends PaymentResult {
  /// Creates the result.
  const new(this.reason);

  /// Short reason code (no card data).
  final String reason;
}

/// 3-D Secure challenge needed.
final class PaymentNeeds3ds extends PaymentResult {
  /// Creates the result.
  const new(this.challengeUrl);

  /// Where the buyer completes the challenge.
  final Uri challengeUrl;
}

/// Payment gateway. `MockGateway` in v1; a UAE gateway adapter (e.g.
/// Network International) later, with no checkout UI changes.
abstract interface class PaymentGateway {
  /// Creates an intent for [order] (server-side in production).
  Future<PaymentIntent> createIntent(Order order);

  /// Confirms [intent] with [method].
  Future<PaymentResult> confirm(PaymentIntent intent, PaymentMethod method);
}

/// Forced outcome of [MockGateway] (debug menu / tests).
enum MockGatewayMode {
  /// Always succeeds (default).
  succeed,

  /// Always fails.
  fail,

  /// Always asks for 3-D Secure.
  needs3ds,
}

/// Mock gateway: waits [delay] (1.5 s) then returns the [mode] outcome.
class MockGateway implements PaymentGateway {
  /// Creates the mock.
  const new({
    this.mode = MockGatewayMode.succeed,
    this.delay = const Duration(milliseconds: 1500),
  });

  /// Forced outcome.
  final MockGatewayMode mode;

  /// Simulated latency.
  final Duration delay;

  @override
  Future<PaymentIntent> createIntent(Order order) async => PaymentIntent(
    id: 'pi_${order.id}',
    orderId: order.id,
    amountFils: order.totalFils,
  );

  @override
  Future<PaymentResult> confirm(
    PaymentIntent intent,
    PaymentMethod method,
  ) async {
    await Future<void>.delayed(delay);
    return switch (mode) {
      MockGatewayMode.succeed => PaymentSucceeded('mock_${intent.id}'),
      MockGatewayMode.fail => const PaymentFailed('declined'),
      MockGatewayMode.needs3ds => PaymentNeeds3ds(
        Uri.parse('https://3ds.mock.example/challenge/${intent.id}'),
      ),
    };
  }
}

/// Debug switch for [MockGateway]'s outcome (not persisted).
@Riverpod(keepAlive: true)
class MockGatewayModeNotifier extends _$MockGatewayModeNotifier {
  @override
  MockGatewayMode build() => MockGatewayMode.succeed;

  /// Forces an outcome.
  // ignore: use_setters_to_change_properties
  void set(MockGatewayMode mode) => state = mode;
}

/// The payment gateway (mock in v1).
@Riverpod(keepAlive: true)
PaymentGateway paymentGateway(Ref ref) =>
    MockGateway(mode: ref.watch(mockGatewayModeProvider));
