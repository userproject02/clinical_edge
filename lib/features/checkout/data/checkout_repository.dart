import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/money.dart';
import 'package:clinical_edge/core/payments/payment_gateway.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:clinical_edge/seed/demo_seeder.dart';
import 'package:clinical_edge/seed/seed_loader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'checkout_repository.g.dart';

/// Seller shown on tax invoices.
class Seller {
  /// Creates the seller.
  const new({required this.name, required this.trn});

  /// Legal name.
  final LocalizedText name;

  /// Tax registration number (placeholder in v1).
  final String trn;
}

/// Orders and receipts.
abstract interface class CheckoutRepository {
  /// Seller details for the receipt.
  Future<Seller> seller();

  /// Creates an unpaid order for [course] (subtotal, VAT, total in fils).
  Future<Order> createOrder(String userId, Course course);

  /// Marks [order] paid with [method] and the gateway [reference], and
  /// assigns the invoice number `CE-YYYY-000000`.
  Future<Order> completeOrder(
    Order order, {
    required PaymentMethod method,
    required String reference,
    String? cardLast4,
  });

  /// Paid orders of [userId], newest first.
  Future<List<Order>> receipts(String userId);

  /// Order by id.
  Future<Order?> byId(String orderId);
}

/// Formats an invoice number: `CE-2026-001041`.
String invoiceNumber(String prefix, int year, int seq) =>
    '$prefix-$year-${seq.toString().padLeft(6, '0')}';

/// Mock [CheckoutRepository] on [LocalDb].
class MockCheckoutRepository implements CheckoutRepository {
  /// Creates the repository.
  new({
    required this.seed,
    required this.db,
    required this.seeder,
    required this.clock,
    Uuid? uuid,
  }) : _uuid = uuid ?? const Uuid();

  /// Seed source.
  final SeedLoader seed;

  /// Persistence.
  final LocalDb db;

  /// Ensures demo data exists.
  final DemoSeeder seeder;

  /// Time source.
  final Clock clock;

  final Uuid _uuid;

  @override
  Future<Seller> seller() async {
    final demo = await seed.load(SeedFile.demo);
    return Seller(
      name: LocalizedText.fromJson(demo.object('seller')),
      trn: demo['sellerTrn']! as String,
    );
  }

  @override
  Future<Order> createOrder(String userId, Course course) async {
    await seeder.ready;
    final price = PriceBreakdown(course.price);
    final order = Order(
      id: 'ord-${_uuid.v4()}',
      userId: userId,
      courseId: course.id,
      subtotalFils: price.subtotal.fils,
      vatFils: price.vat.fils,
      totalFils: price.total.fils,
      createdAt: clock.now(),
    );
    await (await db.open(Collections.orders)).put(order.id, order.toJson());
    return order;
  }

  @override
  Future<Order> completeOrder(
    Order order, {
    required PaymentMethod method,
    required String reference,
    String? cardLast4,
  }) async {
    await seeder.ready;
    final meta = await db.open(Collections.meta);
    final seq = ((await meta.get('invoice'))?['next'] as int?) ?? 1;
    await meta.put('invoice', <String, Object?>{'next': seq + 1});
    final demo = await seed.load(SeedFile.demo);
    final now = clock.now();
    final paid = order.copyWith(
      method: method.name,
      paymentReference: reference,
      cardLast4: cardLast4,
      paidAt: now,
      invoiceNo: invoiceNumber(
        demo['invoicePrefix']! as String,
        dubaiDate(now).year,
        seq,
      ),
    );
    await (await db.open(Collections.orders)).put(paid.id, paid.toJson());
    return paid;
  }

  @override
  Future<List<Order>> receipts(String userId) async {
    await seeder.ready;
    final rows = await (await db.open(Collections.orders)).values();
    return rows
        .map(Order.fromJson)
        .where((o) => o.userId == userId && o.paidAt != null)
        .toList()
      ..sort((a, b) => b.paidAt!.compareTo(a.paidAt!));
  }

  @override
  Future<Order?> byId(String orderId) async {
    await seeder.ready;
    final row = await (await db.open(Collections.orders)).get(orderId);
    return row == null ? null : Order.fromJson(row);
  }
}

/// The checkout repository.
@Riverpod(keepAlive: true)
CheckoutRepository checkoutRepository(Ref ref) =>
    throw UnimplementedError('Override checkoutRepositoryProvider.');
