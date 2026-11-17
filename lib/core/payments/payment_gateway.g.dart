// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_gateway.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Order _$OrderFromJson(Map<String, dynamic> json) => _Order(
  id: json['id'] as String,
  userId: json['userId'] as String,
  courseId: json['courseId'] as String,
  subtotalFils: (json['subtotalFils'] as num).toInt(),
  vatFils: (json['vatFils'] as num).toInt(),
  totalFils: (json['totalFils'] as num).toInt(),
  createdAt: const UtcDateTimeConverter().fromJson(json['createdAt'] as String),
  method: json['method'] as String?,
  invoiceNo: json['invoiceNo'] as String?,
  paymentReference: json['paymentReference'] as String?,
  cardLast4: json['cardLast4'] as String?,
  paidAt: const NullableUtcDateTimeConverter().fromJson(
    json['paidAt'] as String?,
  ),
);

Map<String, dynamic> _$OrderToJson(_Order instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'courseId': instance.courseId,
  'subtotalFils': instance.subtotalFils,
  'vatFils': instance.vatFils,
  'totalFils': instance.totalFils,
  'createdAt': const UtcDateTimeConverter().toJson(instance.createdAt),
  'method': instance.method,
  'invoiceNo': instance.invoiceNo,
  'paymentReference': instance.paymentReference,
  'cardLast4': instance.cardLast4,
  'paidAt': const NullableUtcDateTimeConverter().toJson(instance.paidAt),
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Debug switch for [MockGateway]'s outcome (not persisted).

@ProviderFor(MockGatewayModeNotifier)
final mockGatewayModeProvider = MockGatewayModeNotifierProvider._();

/// Debug switch for [MockGateway]'s outcome (not persisted).
final class MockGatewayModeNotifierProvider
    extends $NotifierProvider<MockGatewayModeNotifier, MockGatewayMode> {
  /// Debug switch for [MockGateway]'s outcome (not persisted).
  MockGatewayModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockGatewayModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockGatewayModeNotifierHash();

  @$internal
  @override
  MockGatewayModeNotifier create() => MockGatewayModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockGatewayMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockGatewayMode>(value),
    );
  }
}

String _$mockGatewayModeNotifierHash() =>
    r'4372ebe0ff1197923798f4e88333f0ec8706a790';

/// Debug switch for [MockGateway]'s outcome (not persisted).

abstract class _$MockGatewayModeNotifier extends $Notifier<MockGatewayMode> {
  MockGatewayMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MockGatewayMode, MockGatewayMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MockGatewayMode, MockGatewayMode>,
              MockGatewayMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The payment gateway (mock in v1).

@ProviderFor(paymentGateway)
final paymentGatewayProvider = PaymentGatewayProvider._();

/// The payment gateway (mock in v1).

final class PaymentGatewayProvider
    extends $FunctionalProvider<PaymentGateway, PaymentGateway, PaymentGateway>
    with $Provider<PaymentGateway> {
  /// The payment gateway (mock in v1).
  PaymentGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentGatewayHash();

  @$internal
  @override
  $ProviderElement<PaymentGateway> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PaymentGateway create(Ref ref) {
    return paymentGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentGateway>(value),
    );
  }
}

String _$paymentGatewayHash() => r'42378c95ba994e62ca53930b0e52f71753c1618d';
