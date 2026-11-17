// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityEvent {

 String get id;@UtcDateTimeConverter() DateTime get ts; String get userId; Role get role; String get action; String get target; String get platform; EventKind get kind; String? get prevHash; String? get hash;
/// Create a copy of ActivityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityEventCopyWith<ActivityEvent> get copyWith => _$ActivityEventCopyWithImpl<ActivityEvent>(this as ActivityEvent, _$identity);

  /// Serializes this ActivityEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityEvent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.ts, _this.ts) || other.ts == _this.ts)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.platform, _this.platform) || other.platform == _this.platform)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.prevHash, _this.prevHash) || other.prevHash == _this.prevHash)&&(identical(other.hash, _this.hash) || other.hash == _this.hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityEvent;
  return Object.hash(runtimeType,_this.id,_this.ts,_this.userId,_this.role,_this.action,_this.target,_this.platform,_this.kind,_this.prevHash,_this.hash);
}

@override
String toString() {
  final _this = this as ActivityEvent;
  return 'ActivityEvent(id: ${_this.id}, ts: ${_this.ts}, userId: ${_this.userId}, role: ${_this.role}, action: ${_this.action}, target: ${_this.target}, platform: ${_this.platform}, kind: ${_this.kind}, prevHash: ${_this.prevHash}, hash: ${_this.hash})';
}


}

/// @nodoc
abstract mixin class $ActivityEventCopyWith<$Res>  {
  factory $ActivityEventCopyWith(ActivityEvent value, $Res Function(ActivityEvent) _then) = _$ActivityEventCopyWithImpl;
@useResult
$Res call({
 String id,@UtcDateTimeConverter() DateTime ts, String userId, Role role, String action, String target, String platform, EventKind kind, String? prevHash, String? hash
});




}
/// @nodoc
class _$ActivityEventCopyWithImpl<$Res>
    implements $ActivityEventCopyWith<$Res> {
  _$ActivityEventCopyWithImpl(this._self, this._then);

  final ActivityEvent _self;
  final $Res Function(ActivityEvent) _then;

/// Create a copy of ActivityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ts = null,Object? userId = null,Object? role = null,Object? action = null,Object? target = null,Object? platform = null,Object? kind = null,Object? prevHash = freezed,Object? hash = freezed,}) {
  return _then(ActivityEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ts: null == ts ? _self.ts : ts // ignore: cast_nullable_to_non_nullable
as DateTime,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as Role,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as EventKind,prevHash: freezed == prevHash ? _self.prevHash : prevHash // ignore: cast_nullable_to_non_nullable
as String?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityEvent].
extension ActivityEventPatterns on ActivityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityEvent value)  $default,){
final _that = this;
switch (_that) {
case _ActivityEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityEvent value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @UtcDateTimeConverter()  DateTime ts,  String userId,  Role role,  String action,  String target,  String platform,  EventKind kind,  String? prevHash,  String? hash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityEvent() when $default != null:
return $default(_that.id,_that.ts,_that.userId,_that.role,_that.action,_that.target,_that.platform,_that.kind,_that.prevHash,_that.hash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @UtcDateTimeConverter()  DateTime ts,  String userId,  Role role,  String action,  String target,  String platform,  EventKind kind,  String? prevHash,  String? hash)  $default,) {final _that = this;
switch (_that) {
case _ActivityEvent():
return $default(_that.id,_that.ts,_that.userId,_that.role,_that.action,_that.target,_that.platform,_that.kind,_that.prevHash,_that.hash);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @UtcDateTimeConverter()  DateTime ts,  String userId,  Role role,  String action,  String target,  String platform,  EventKind kind,  String? prevHash,  String? hash)?  $default,) {final _that = this;
switch (_that) {
case _ActivityEvent() when $default != null:
return $default(_that.id,_that.ts,_that.userId,_that.role,_that.action,_that.target,_that.platform,_that.kind,_that.prevHash,_that.hash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityEvent implements ActivityEvent {
  const _ActivityEvent({required this.id, @UtcDateTimeConverter() required this.ts, required this.userId, required this.role, required this.action, required this.target, required this.platform, required this.kind, this.prevHash, this.hash});
  factory _ActivityEvent.fromJson(Map<String, dynamic> json) => _$ActivityEventFromJson(json);

@override final  String id;
@override@UtcDateTimeConverter() final  DateTime ts;
@override final  String userId;
@override final  Role role;
@override final  String action;
@override final  String target;
@override final  String platform;
@override final  EventKind kind;
@override final  String? prevHash;
@override final  String? hash;

/// Create a copy of ActivityEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityEventCopyWith<_ActivityEvent> get copyWith => __$ActivityEventCopyWithImpl<_ActivityEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.ts, ts) || other.ts == ts)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.action, action) || other.action == action)&&(identical(other.target, target) || other.target == target)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.prevHash, prevHash) || other.prevHash == prevHash)&&(identical(other.hash, hash) || other.hash == hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,ts,userId,role,action,target,platform,kind,prevHash,hash);
}

@override
String toString() {
    return 'ActivityEvent(id: $id, ts: $ts, userId: $userId, role: $role, action: $action, target: $target, platform: $platform, kind: $kind, prevHash: $prevHash, hash: $hash)';
}


}

/// @nodoc
abstract mixin class _$ActivityEventCopyWith<$Res> implements $ActivityEventCopyWith<$Res> {
  factory _$ActivityEventCopyWith(_ActivityEvent value, $Res Function(_ActivityEvent) _then) = __$ActivityEventCopyWithImpl;
@override @useResult
$Res call({
 String id,@UtcDateTimeConverter() DateTime ts, String userId, Role role, String action, String target, String platform, EventKind kind, String? prevHash, String? hash
});




}
/// @nodoc
class __$ActivityEventCopyWithImpl<$Res>
    implements _$ActivityEventCopyWith<$Res> {
  __$ActivityEventCopyWithImpl(this._self, this._then);

  final _ActivityEvent _self;
  final $Res Function(_ActivityEvent) _then;

/// Create a copy of ActivityEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ts = null,Object? userId = null,Object? role = null,Object? action = null,Object? target = null,Object? platform = null,Object? kind = null,Object? prevHash = freezed,Object? hash = freezed,}) {
  return _then(_ActivityEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ts: null == ts ? _self.ts : ts // ignore: cast_nullable_to_non_nullable
as DateTime,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as Role,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as EventKind,prevHash: freezed == prevHash ? _self.prevHash : prevHash // ignore: cast_nullable_to_non_nullable
as String?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
