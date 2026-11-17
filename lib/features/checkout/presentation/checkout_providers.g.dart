// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Seller for receipts.

@ProviderFor(seller)
final sellerProvider = SellerProvider._();

/// Seller for receipts.

final class SellerProvider
    extends $FunctionalProvider<AsyncValue<Seller>, Seller, FutureOr<Seller>>
    with $FutureModifier<Seller>, $FutureProvider<Seller> {
  /// Seller for receipts.
  SellerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sellerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sellerHash();

  @$internal
  @override
  $FutureProviderElement<Seller> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Seller> create(Ref ref) {
    return seller(ref);
  }
}

String _$sellerHash() => r'28da4e92d97b6530510325a07069ec9830135140';

/// One order.

@ProviderFor(order)
final orderProvider = OrderFamily._();

/// One order.

final class OrderProvider
    extends $FunctionalProvider<AsyncValue<Order?>, Order?, FutureOr<Order?>>
    with $FutureModifier<Order?>, $FutureProvider<Order?> {
  /// One order.
  OrderProvider._({
    required OrderFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orderHash();

  @override
  String toString() {
    return r'orderProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Order?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Order?> create(Ref ref) {
    final argument = this.argument as String;
    return order(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orderHash() => r'78a2be4f145466a2884939321fbe14bb89387cb9';

/// One order.

final class OrderFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Order?>, String> {
  OrderFamily._()
    : super(
        retry: null,
        name: r'orderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One order.

  OrderProvider call(String orderId) =>
      OrderProvider._(argument: orderId, from: this);

  @override
  String toString() => r'orderProvider';
}

/// Logs `checkout.start` (usage) for a course.

@ProviderFor(logCheckoutStart)
final logCheckoutStartProvider = LogCheckoutStartProvider._();

/// Logs `checkout.start` (usage) for a course.

final class LogCheckoutStartProvider
    extends
        $FunctionalProvider<
          void Function(Course course),
          void Function(Course course),
          void Function(Course course)
        >
    with $Provider<void Function(Course course)> {
  /// Logs `checkout.start` (usage) for a course.
  LogCheckoutStartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logCheckoutStartProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logCheckoutStartHash();

  @$internal
  @override
  $ProviderElement<void Function(Course course)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  void Function(Course course) create(Ref ref) {
    return logCheckoutStart(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void Function(Course course) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void Function(Course course)>(value),
    );
  }
}

String _$logCheckoutStartHash() => r'c408bbd1821b7eb7e3871f044941bd291d4e848b';

/// Pays for a course (PAY-1); refreshes ownership on success.

@ProviderFor(purchaseCourse)
final purchaseCourseProvider = PurchaseCourseProvider._();

/// Pays for a course (PAY-1); refreshes ownership on success.

final class PurchaseCourseProvider
    extends
        $FunctionalProvider<
          Future<PurchaseOutcome> Function(
            Course course,
            PaymentMethod method, {
            String? cardLast4,
          }),
          Future<PurchaseOutcome> Function(
            Course course,
            PaymentMethod method, {
            String? cardLast4,
          }),
          Future<PurchaseOutcome> Function(
            Course course,
            PaymentMethod method, {
            String? cardLast4,
          })
        >
    with
        $Provider<
          Future<PurchaseOutcome> Function(
            Course course,
            PaymentMethod method, {
            String? cardLast4,
          })
        > {
  /// Pays for a course (PAY-1); refreshes ownership on success.
  PurchaseCourseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseCourseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseCourseHash();

  @$internal
  @override
  $ProviderElement<
    Future<PurchaseOutcome> Function(
      Course course,
      PaymentMethod method, {
      String? cardLast4,
    })
  >
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Future<PurchaseOutcome> Function(
    Course course,
    PaymentMethod method, {
    String? cardLast4,
  })
  create(Ref ref) {
    return purchaseCourse(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Future<PurchaseOutcome> Function(
      Course course,
      PaymentMethod method, {
      String? cardLast4,
    })
    value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            Future<PurchaseOutcome> Function(
              Course course,
              PaymentMethod method, {
              String? cardLast4,
            })
          >(value),
    );
  }
}

String _$purchaseCourseHash() => r'147388128a558ec2d9c8a385cfc462b6d8726079';

/// Completes a purchase after an approved 3-D Secure challenge.

@ProviderFor(complete3ds)
final complete3dsProvider = Complete3dsProvider._();

/// Completes a purchase after an approved 3-D Secure challenge.

final class Complete3dsProvider
    extends
        $FunctionalProvider<
          Future<Order> Function(
            Course course,
            PurchaseNeeds3ds pending,
            PaymentMethod method, {
            String? cardLast4,
          }),
          Future<Order> Function(
            Course course,
            PurchaseNeeds3ds pending,
            PaymentMethod method, {
            String? cardLast4,
          }),
          Future<Order> Function(
            Course course,
            PurchaseNeeds3ds pending,
            PaymentMethod method, {
            String? cardLast4,
          })
        >
    with
        $Provider<
          Future<Order> Function(
            Course course,
            PurchaseNeeds3ds pending,
            PaymentMethod method, {
            String? cardLast4,
          })
        > {
  /// Completes a purchase after an approved 3-D Secure challenge.
  Complete3dsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'complete3dsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$complete3dsHash();

  @$internal
  @override
  $ProviderElement<
    Future<Order> Function(
      Course course,
      PurchaseNeeds3ds pending,
      PaymentMethod method, {
      String? cardLast4,
    })
  >
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Future<Order> Function(
    Course course,
    PurchaseNeeds3ds pending,
    PaymentMethod method, {
    String? cardLast4,
  })
  create(Ref ref) {
    return complete3ds(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Future<Order> Function(
      Course course,
      PurchaseNeeds3ds pending,
      PaymentMethod method, {
      String? cardLast4,
    })
    value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            Future<Order> Function(
              Course course,
              PurchaseNeeds3ds pending,
              PaymentMethod method, {
              String? cardLast4,
            })
          >(value),
    );
  }
}

String _$complete3dsHash() => r'7dd7f83f0761f6d4be9bb4dfdae94de9b073fa92';
