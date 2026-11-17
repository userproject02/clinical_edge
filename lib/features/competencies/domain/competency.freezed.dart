// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompetencyChecklist {

 String get id; LocalizedText get name; LocalizedText get audience; List<LocalizedText> get items;
/// Create a copy of CompetencyChecklist
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetencyChecklistCopyWith<CompetencyChecklist> get copyWith => _$CompetencyChecklistCopyWithImpl<CompetencyChecklist>(this as CompetencyChecklist, _$identity);

  /// Serializes this CompetencyChecklist to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CompetencyChecklist;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetencyChecklist&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.audience, _this.audience) || other.audience == _this.audience)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CompetencyChecklist;
  return Object.hash(runtimeType,_this.id,_this.name,_this.audience,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as CompetencyChecklist;
  return 'CompetencyChecklist(id: ${_this.id}, name: ${_this.name}, audience: ${_this.audience}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $CompetencyChecklistCopyWith<$Res>  {
  factory $CompetencyChecklistCopyWith(CompetencyChecklist value, $Res Function(CompetencyChecklist) _then) = _$CompetencyChecklistCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText name, LocalizedText audience, List<LocalizedText> items
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get audience;

}
/// @nodoc
class _$CompetencyChecklistCopyWithImpl<$Res>
    implements $CompetencyChecklistCopyWith<$Res> {
  _$CompetencyChecklistCopyWithImpl(this._self, this._then);

  final CompetencyChecklist _self;
  final $Res Function(CompetencyChecklist) _then;

/// Create a copy of CompetencyChecklist
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? audience = null,Object? items = null,}) {
  return _then(CompetencyChecklist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,audience: null == audience ? _self.audience : audience // ignore: cast_nullable_to_non_nullable
as LocalizedText,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,
  ));
}
/// Create a copy of CompetencyChecklist
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompetencyChecklist
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get audience {
  
  return $LocalizedTextCopyWith<$Res>(_self.audience, (value) {
    return _then(_self.copyWith(audience: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompetencyChecklist].
extension CompetencyChecklistPatterns on CompetencyChecklist {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetencyChecklist value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetencyChecklist() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetencyChecklist value)  $default,){
final _that = this;
switch (_that) {
case _CompetencyChecklist():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetencyChecklist value)?  $default,){
final _that = this;
switch (_that) {
case _CompetencyChecklist() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  LocalizedText audience,  List<LocalizedText> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetencyChecklist() when $default != null:
return $default(_that.id,_that.name,_that.audience,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  LocalizedText audience,  List<LocalizedText> items)  $default,) {final _that = this;
switch (_that) {
case _CompetencyChecklist():
return $default(_that.id,_that.name,_that.audience,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText name,  LocalizedText audience,  List<LocalizedText> items)?  $default,) {final _that = this;
switch (_that) {
case _CompetencyChecklist() when $default != null:
return $default(_that.id,_that.name,_that.audience,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetencyChecklist implements CompetencyChecklist {
  const _CompetencyChecklist({required this.id, required this.name, required this.audience, required  List<LocalizedText> items}): _items = items;
  factory _CompetencyChecklist.fromJson(Map<String, dynamic> json) => _$CompetencyChecklistFromJson(json);

@override final  String id;
@override final  LocalizedText name;
@override final  LocalizedText audience;
 final  List<LocalizedText> _items;
@override List<LocalizedText> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CompetencyChecklist
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetencyChecklistCopyWith<_CompetencyChecklist> get copyWith => __$CompetencyChecklistCopyWithImpl<_CompetencyChecklist>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetencyChecklistToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetencyChecklist&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.audience, audience) || other.audience == audience)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,audience,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'CompetencyChecklist(id: $id, name: $name, audience: $audience, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CompetencyChecklistCopyWith<$Res> implements $CompetencyChecklistCopyWith<$Res> {
  factory _$CompetencyChecklistCopyWith(_CompetencyChecklist value, $Res Function(_CompetencyChecklist) _then) = __$CompetencyChecklistCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText name, LocalizedText audience, List<LocalizedText> items
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get audience;

}
/// @nodoc
class __$CompetencyChecklistCopyWithImpl<$Res>
    implements _$CompetencyChecklistCopyWith<$Res> {
  __$CompetencyChecklistCopyWithImpl(this._self, this._then);

  final _CompetencyChecklist _self;
  final $Res Function(_CompetencyChecklist) _then;

/// Create a copy of CompetencyChecklist
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? audience = null,Object? items = null,}) {
  return _then(_CompetencyChecklist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,audience: null == audience ? _self.audience : audience // ignore: cast_nullable_to_non_nullable
as LocalizedText,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,
  ));
}

/// Create a copy of CompetencyChecklist
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompetencyChecklist
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get audience {
  
  return $LocalizedTextCopyWith<$Res>(_self.audience, (value) {
    return _then(_self.copyWith(audience: value));
  });
}
}


/// @nodoc
mixin _$SignOffRequest {

 String get id; String get learnerId; String get checklistId; SignOffStatus get status;@NullableUtcDateTimeConverter() DateTime? get requestedAt; String? get decidedBy;@NullableUtcDateTimeConverter() DateTime? get decidedAt; LocalizedText? get comment;
/// Create a copy of SignOffRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignOffRequestCopyWith<SignOffRequest> get copyWith => _$SignOffRequestCopyWithImpl<SignOffRequest>(this as SignOffRequest, _$identity);

  /// Serializes this SignOffRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SignOffRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignOffRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.learnerId, _this.learnerId) || other.learnerId == _this.learnerId)&&(identical(other.checklistId, _this.checklistId) || other.checklistId == _this.checklistId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.requestedAt, _this.requestedAt) || other.requestedAt == _this.requestedAt)&&(identical(other.decidedBy, _this.decidedBy) || other.decidedBy == _this.decidedBy)&&(identical(other.decidedAt, _this.decidedAt) || other.decidedAt == _this.decidedAt)&&(identical(other.comment, _this.comment) || other.comment == _this.comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SignOffRequest;
  return Object.hash(runtimeType,_this.id,_this.learnerId,_this.checklistId,_this.status,_this.requestedAt,_this.decidedBy,_this.decidedAt,_this.comment);
}

@override
String toString() {
  final _this = this as SignOffRequest;
  return 'SignOffRequest(id: ${_this.id}, learnerId: ${_this.learnerId}, checklistId: ${_this.checklistId}, status: ${_this.status}, requestedAt: ${_this.requestedAt}, decidedBy: ${_this.decidedBy}, decidedAt: ${_this.decidedAt}, comment: ${_this.comment})';
}


}

/// @nodoc
abstract mixin class $SignOffRequestCopyWith<$Res>  {
  factory $SignOffRequestCopyWith(SignOffRequest value, $Res Function(SignOffRequest) _then) = _$SignOffRequestCopyWithImpl;
@useResult
$Res call({
 String id, String learnerId, String checklistId, SignOffStatus status,@NullableUtcDateTimeConverter() DateTime? requestedAt, String? decidedBy,@NullableUtcDateTimeConverter() DateTime? decidedAt, LocalizedText? comment
});


$LocalizedTextCopyWith<$Res>? get comment;

}
/// @nodoc
class _$SignOffRequestCopyWithImpl<$Res>
    implements $SignOffRequestCopyWith<$Res> {
  _$SignOffRequestCopyWithImpl(this._self, this._then);

  final SignOffRequest _self;
  final $Res Function(SignOffRequest) _then;

/// Create a copy of SignOffRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? learnerId = null,Object? checklistId = null,Object? status = null,Object? requestedAt = freezed,Object? decidedBy = freezed,Object? decidedAt = freezed,Object? comment = freezed,}) {
  return _then(SignOffRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,learnerId: null == learnerId ? _self.learnerId : learnerId // ignore: cast_nullable_to_non_nullable
as String,checklistId: null == checklistId ? _self.checklistId : checklistId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SignOffStatus,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,decidedBy: freezed == decidedBy ? _self.decidedBy : decidedBy // ignore: cast_nullable_to_non_nullable
as String?,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of SignOffRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignOffRequest].
extension SignOffRequestPatterns on SignOffRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignOffRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignOffRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignOffRequest value)  $default,){
final _that = this;
switch (_that) {
case _SignOffRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignOffRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SignOffRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String learnerId,  String checklistId,  SignOffStatus status, @NullableUtcDateTimeConverter()  DateTime? requestedAt,  String? decidedBy, @NullableUtcDateTimeConverter()  DateTime? decidedAt,  LocalizedText? comment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignOffRequest() when $default != null:
return $default(_that.id,_that.learnerId,_that.checklistId,_that.status,_that.requestedAt,_that.decidedBy,_that.decidedAt,_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String learnerId,  String checklistId,  SignOffStatus status, @NullableUtcDateTimeConverter()  DateTime? requestedAt,  String? decidedBy, @NullableUtcDateTimeConverter()  DateTime? decidedAt,  LocalizedText? comment)  $default,) {final _that = this;
switch (_that) {
case _SignOffRequest():
return $default(_that.id,_that.learnerId,_that.checklistId,_that.status,_that.requestedAt,_that.decidedBy,_that.decidedAt,_that.comment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String learnerId,  String checklistId,  SignOffStatus status, @NullableUtcDateTimeConverter()  DateTime? requestedAt,  String? decidedBy, @NullableUtcDateTimeConverter()  DateTime? decidedAt,  LocalizedText? comment)?  $default,) {final _that = this;
switch (_that) {
case _SignOffRequest() when $default != null:
return $default(_that.id,_that.learnerId,_that.checklistId,_that.status,_that.requestedAt,_that.decidedBy,_that.decidedAt,_that.comment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignOffRequest implements SignOffRequest {
  const _SignOffRequest({required this.id, required this.learnerId, required this.checklistId, required this.status, @NullableUtcDateTimeConverter() this.requestedAt, this.decidedBy, @NullableUtcDateTimeConverter() this.decidedAt, this.comment});
  factory _SignOffRequest.fromJson(Map<String, dynamic> json) => _$SignOffRequestFromJson(json);

@override final  String id;
@override final  String learnerId;
@override final  String checklistId;
@override final  SignOffStatus status;
@override@NullableUtcDateTimeConverter() final  DateTime? requestedAt;
@override final  String? decidedBy;
@override@NullableUtcDateTimeConverter() final  DateTime? decidedAt;
@override final  LocalizedText? comment;

/// Create a copy of SignOffRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignOffRequestCopyWith<_SignOffRequest> get copyWith => __$SignOffRequestCopyWithImpl<_SignOffRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignOffRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignOffRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.learnerId, learnerId) || other.learnerId == learnerId)&&(identical(other.checklistId, checklistId) || other.checklistId == checklistId)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.decidedBy, decidedBy) || other.decidedBy == decidedBy)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,learnerId,checklistId,status,requestedAt,decidedBy,decidedAt,comment);
}

@override
String toString() {
    return 'SignOffRequest(id: $id, learnerId: $learnerId, checklistId: $checklistId, status: $status, requestedAt: $requestedAt, decidedBy: $decidedBy, decidedAt: $decidedAt, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$SignOffRequestCopyWith<$Res> implements $SignOffRequestCopyWith<$Res> {
  factory _$SignOffRequestCopyWith(_SignOffRequest value, $Res Function(_SignOffRequest) _then) = __$SignOffRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String learnerId, String checklistId, SignOffStatus status,@NullableUtcDateTimeConverter() DateTime? requestedAt, String? decidedBy,@NullableUtcDateTimeConverter() DateTime? decidedAt, LocalizedText? comment
});


@override $LocalizedTextCopyWith<$Res>? get comment;

}
/// @nodoc
class __$SignOffRequestCopyWithImpl<$Res>
    implements _$SignOffRequestCopyWith<$Res> {
  __$SignOffRequestCopyWithImpl(this._self, this._then);

  final _SignOffRequest _self;
  final $Res Function(_SignOffRequest) _then;

/// Create a copy of SignOffRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? learnerId = null,Object? checklistId = null,Object? status = null,Object? requestedAt = freezed,Object? decidedBy = freezed,Object? decidedAt = freezed,Object? comment = freezed,}) {
  return _then(_SignOffRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,learnerId: null == learnerId ? _self.learnerId : learnerId // ignore: cast_nullable_to_non_nullable
as String,checklistId: null == checklistId ? _self.checklistId : checklistId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SignOffStatus,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,decidedBy: freezed == decidedBy ? _self.decidedBy : decidedBy // ignore: cast_nullable_to_non_nullable
as String?,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of SignOffRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}

// dart format on
