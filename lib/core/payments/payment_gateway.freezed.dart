// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_gateway.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Order {

 String get id; String get userId; String get courseId; int get subtotalFils; int get vatFils; int get totalFils;@UtcDateTimeConverter() DateTime get createdAt; String? get method; String? get invoiceNo; String? get paymentReference;/// Last 4 card digits for the receipt (card payments only; never the
/// full number).
 String? get cardLast4;@NullableUtcDateTimeConverter() DateTime? get paidAt;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Order;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.courseId, _this.courseId) || other.courseId == _this.courseId)&&(identical(other.subtotalFils, _this.subtotalFils) || other.subtotalFils == _this.subtotalFils)&&(identical(other.vatFils, _this.vatFils) || other.vatFils == _this.vatFils)&&(identical(other.totalFils, _this.totalFils) || other.totalFils == _this.totalFils)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.method, _this.method) || other.method == _this.method)&&(identical(other.invoiceNo, _this.invoiceNo) || other.invoiceNo == _this.invoiceNo)&&(identical(other.paymentReference, _this.paymentReference) || other.paymentReference == _this.paymentReference)&&(identical(other.cardLast4, _this.cardLast4) || other.cardLast4 == _this.cardLast4)&&(identical(other.paidAt, _this.paidAt) || other.paidAt == _this.paidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Order;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.courseId,_this.subtotalFils,_this.vatFils,_this.totalFils,_this.createdAt,_this.method,_this.invoiceNo,_this.paymentReference,_this.cardLast4,_this.paidAt);
}

@override
String toString() {
  final _this = this as Order;
  return 'Order(id: ${_this.id}, userId: ${_this.userId}, courseId: ${_this.courseId}, subtotalFils: ${_this.subtotalFils}, vatFils: ${_this.vatFils}, totalFils: ${_this.totalFils}, createdAt: ${_this.createdAt}, method: ${_this.method}, invoiceNo: ${_this.invoiceNo}, paymentReference: ${_this.paymentReference}, cardLast4: ${_this.cardLast4}, paidAt: ${_this.paidAt})';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String courseId, int subtotalFils, int vatFils, int totalFils,@UtcDateTimeConverter() DateTime createdAt, String? method, String? invoiceNo, String? paymentReference, String? cardLast4,@NullableUtcDateTimeConverter() DateTime? paidAt
});




}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? courseId = null,Object? subtotalFils = null,Object? vatFils = null,Object? totalFils = null,Object? createdAt = null,Object? method = freezed,Object? invoiceNo = freezed,Object? paymentReference = freezed,Object? cardLast4 = freezed,Object? paidAt = freezed,}) {
  return _then(Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,subtotalFils: null == subtotalFils ? _self.subtotalFils : subtotalFils // ignore: cast_nullable_to_non_nullable
as int,vatFils: null == vatFils ? _self.vatFils : vatFils // ignore: cast_nullable_to_non_nullable
as int,totalFils: null == totalFils ? _self.totalFils : totalFils // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,invoiceNo: freezed == invoiceNo ? _self.invoiceNo : invoiceNo // ignore: cast_nullable_to_non_nullable
as String?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String courseId,  int subtotalFils,  int vatFils,  int totalFils, @UtcDateTimeConverter()  DateTime createdAt,  String? method,  String? invoiceNo,  String? paymentReference,  String? cardLast4, @NullableUtcDateTimeConverter()  DateTime? paidAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.userId,_that.courseId,_that.subtotalFils,_that.vatFils,_that.totalFils,_that.createdAt,_that.method,_that.invoiceNo,_that.paymentReference,_that.cardLast4,_that.paidAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String courseId,  int subtotalFils,  int vatFils,  int totalFils, @UtcDateTimeConverter()  DateTime createdAt,  String? method,  String? invoiceNo,  String? paymentReference,  String? cardLast4, @NullableUtcDateTimeConverter()  DateTime? paidAt)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.id,_that.userId,_that.courseId,_that.subtotalFils,_that.vatFils,_that.totalFils,_that.createdAt,_that.method,_that.invoiceNo,_that.paymentReference,_that.cardLast4,_that.paidAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String courseId,  int subtotalFils,  int vatFils,  int totalFils, @UtcDateTimeConverter()  DateTime createdAt,  String? method,  String? invoiceNo,  String? paymentReference,  String? cardLast4, @NullableUtcDateTimeConverter()  DateTime? paidAt)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.userId,_that.courseId,_that.subtotalFils,_that.vatFils,_that.totalFils,_that.createdAt,_that.method,_that.invoiceNo,_that.paymentReference,_that.cardLast4,_that.paidAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Order implements Order {
  const _Order({required this.id, required this.userId, required this.courseId, required this.subtotalFils, required this.vatFils, required this.totalFils, @UtcDateTimeConverter() required this.createdAt, this.method, this.invoiceNo, this.paymentReference, this.cardLast4, @NullableUtcDateTimeConverter() this.paidAt});
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String courseId;
@override final  int subtotalFils;
@override final  int vatFils;
@override final  int totalFils;
@override@UtcDateTimeConverter() final  DateTime createdAt;
@override final  String? method;
@override final  String? invoiceNo;
@override final  String? paymentReference;
/// Last 4 card digits for the receipt (card payments only; never the
/// full number).
@override final  String? cardLast4;
@override@NullableUtcDateTimeConverter() final  DateTime? paidAt;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.subtotalFils, subtotalFils) || other.subtotalFils == subtotalFils)&&(identical(other.vatFils, vatFils) || other.vatFils == vatFils)&&(identical(other.totalFils, totalFils) || other.totalFils == totalFils)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.method, method) || other.method == method)&&(identical(other.invoiceNo, invoiceNo) || other.invoiceNo == invoiceNo)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.cardLast4, cardLast4) || other.cardLast4 == cardLast4)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,courseId,subtotalFils,vatFils,totalFils,createdAt,method,invoiceNo,paymentReference,cardLast4,paidAt);
}

@override
String toString() {
    return 'Order(id: $id, userId: $userId, courseId: $courseId, subtotalFils: $subtotalFils, vatFils: $vatFils, totalFils: $totalFils, createdAt: $createdAt, method: $method, invoiceNo: $invoiceNo, paymentReference: $paymentReference, cardLast4: $cardLast4, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String courseId, int subtotalFils, int vatFils, int totalFils,@UtcDateTimeConverter() DateTime createdAt, String? method, String? invoiceNo, String? paymentReference, String? cardLast4,@NullableUtcDateTimeConverter() DateTime? paidAt
});




}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? courseId = null,Object? subtotalFils = null,Object? vatFils = null,Object? totalFils = null,Object? createdAt = null,Object? method = freezed,Object? invoiceNo = freezed,Object? paymentReference = freezed,Object? cardLast4 = freezed,Object? paidAt = freezed,}) {
  return _then(_Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,subtotalFils: null == subtotalFils ? _self.subtotalFils : subtotalFils // ignore: cast_nullable_to_non_nullable
as int,vatFils: null == vatFils ? _self.vatFils : vatFils // ignore: cast_nullable_to_non_nullable
as int,totalFils: null == totalFils ? _self.totalFils : totalFils // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,invoiceNo: freezed == invoiceNo ? _self.invoiceNo : invoiceNo // ignore: cast_nullable_to_non_nullable
as String?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
