// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Certification {

 String get id; String get userId; LocalizedText get name; LocalizedText get issuer;@DateOnlyConverter() DateTime get issuedOn;@DateOnlyConverter() DateTime get expiresOn; Verification get verification; String? get fileRef;/// Short code shown in alerts ("BLS").
 String? get code;
/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CertificationCopyWith<Certification> get copyWith => _$CertificationCopyWithImpl<Certification>(this as Certification, _$identity);

  /// Serializes this Certification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Certification;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Certification&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.issuer, _this.issuer) || other.issuer == _this.issuer)&&(identical(other.issuedOn, _this.issuedOn) || other.issuedOn == _this.issuedOn)&&(identical(other.expiresOn, _this.expiresOn) || other.expiresOn == _this.expiresOn)&&(identical(other.verification, _this.verification) || other.verification == _this.verification)&&(identical(other.fileRef, _this.fileRef) || other.fileRef == _this.fileRef)&&(identical(other.code, _this.code) || other.code == _this.code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Certification;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.name,_this.issuer,_this.issuedOn,_this.expiresOn,_this.verification,_this.fileRef,_this.code);
}

@override
String toString() {
  final _this = this as Certification;
  return 'Certification(id: ${_this.id}, userId: ${_this.userId}, name: ${_this.name}, issuer: ${_this.issuer}, issuedOn: ${_this.issuedOn}, expiresOn: ${_this.expiresOn}, verification: ${_this.verification}, fileRef: ${_this.fileRef}, code: ${_this.code})';
}


}

/// @nodoc
abstract mixin class $CertificationCopyWith<$Res>  {
  factory $CertificationCopyWith(Certification value, $Res Function(Certification) _then) = _$CertificationCopyWithImpl;
@useResult
$Res call({
 String id, String userId, LocalizedText name, LocalizedText issuer,@DateOnlyConverter() DateTime issuedOn,@DateOnlyConverter() DateTime expiresOn, Verification verification, String? fileRef, String? code
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get issuer;

}
/// @nodoc
class _$CertificationCopyWithImpl<$Res>
    implements $CertificationCopyWith<$Res> {
  _$CertificationCopyWithImpl(this._self, this._then);

  final Certification _self;
  final $Res Function(Certification) _then;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? issuer = null,Object? issuedOn = null,Object? expiresOn = null,Object? verification = null,Object? fileRef = freezed,Object? code = freezed,}) {
  return _then(Certification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,issuer: null == issuer ? _self.issuer : issuer // ignore: cast_nullable_to_non_nullable
as LocalizedText,issuedOn: null == issuedOn ? _self.issuedOn : issuedOn // ignore: cast_nullable_to_non_nullable
as DateTime,expiresOn: null == expiresOn ? _self.expiresOn : expiresOn // ignore: cast_nullable_to_non_nullable
as DateTime,verification: null == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as Verification,fileRef: freezed == fileRef ? _self.fileRef : fileRef // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get issuer {
  
  return $LocalizedTextCopyWith<$Res>(_self.issuer, (value) {
    return _then(_self.copyWith(issuer: value));
  });
}
}


/// Adds pattern-matching-related methods to [Certification].
extension CertificationPatterns on Certification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Certification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Certification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Certification value)  $default,){
final _that = this;
switch (_that) {
case _Certification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Certification value)?  $default,){
final _that = this;
switch (_that) {
case _Certification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  LocalizedText name,  LocalizedText issuer, @DateOnlyConverter()  DateTime issuedOn, @DateOnlyConverter()  DateTime expiresOn,  Verification verification,  String? fileRef,  String? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Certification() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.issuer,_that.issuedOn,_that.expiresOn,_that.verification,_that.fileRef,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  LocalizedText name,  LocalizedText issuer, @DateOnlyConverter()  DateTime issuedOn, @DateOnlyConverter()  DateTime expiresOn,  Verification verification,  String? fileRef,  String? code)  $default,) {final _that = this;
switch (_that) {
case _Certification():
return $default(_that.id,_that.userId,_that.name,_that.issuer,_that.issuedOn,_that.expiresOn,_that.verification,_that.fileRef,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  LocalizedText name,  LocalizedText issuer, @DateOnlyConverter()  DateTime issuedOn, @DateOnlyConverter()  DateTime expiresOn,  Verification verification,  String? fileRef,  String? code)?  $default,) {final _that = this;
switch (_that) {
case _Certification() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.issuer,_that.issuedOn,_that.expiresOn,_that.verification,_that.fileRef,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Certification extends Certification {
  const _Certification({required this.id, required this.userId, required this.name, required this.issuer, @DateOnlyConverter() required this.issuedOn, @DateOnlyConverter() required this.expiresOn, required this.verification, this.fileRef, this.code}): super._();
  factory _Certification.fromJson(Map<String, dynamic> json) => _$CertificationFromJson(json);

@override final  String id;
@override final  String userId;
@override final  LocalizedText name;
@override final  LocalizedText issuer;
@override@DateOnlyConverter() final  DateTime issuedOn;
@override@DateOnlyConverter() final  DateTime expiresOn;
@override final  Verification verification;
@override final  String? fileRef;
/// Short code shown in alerts ("BLS").
@override final  String? code;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CertificationCopyWith<_Certification> get copyWith => __$CertificationCopyWithImpl<_Certification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CertificationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Certification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.issuer, issuer) || other.issuer == issuer)&&(identical(other.issuedOn, issuedOn) || other.issuedOn == issuedOn)&&(identical(other.expiresOn, expiresOn) || other.expiresOn == expiresOn)&&(identical(other.verification, verification) || other.verification == verification)&&(identical(other.fileRef, fileRef) || other.fileRef == fileRef)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,name,issuer,issuedOn,expiresOn,verification,fileRef,code);
}

@override
String toString() {
    return 'Certification(id: $id, userId: $userId, name: $name, issuer: $issuer, issuedOn: $issuedOn, expiresOn: $expiresOn, verification: $verification, fileRef: $fileRef, code: $code)';
}


}

/// @nodoc
abstract mixin class _$CertificationCopyWith<$Res> implements $CertificationCopyWith<$Res> {
  factory _$CertificationCopyWith(_Certification value, $Res Function(_Certification) _then) = __$CertificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, LocalizedText name, LocalizedText issuer,@DateOnlyConverter() DateTime issuedOn,@DateOnlyConverter() DateTime expiresOn, Verification verification, String? fileRef, String? code
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get issuer;

}
/// @nodoc
class __$CertificationCopyWithImpl<$Res>
    implements _$CertificationCopyWith<$Res> {
  __$CertificationCopyWithImpl(this._self, this._then);

  final _Certification _self;
  final $Res Function(_Certification) _then;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? issuer = null,Object? issuedOn = null,Object? expiresOn = null,Object? verification = null,Object? fileRef = freezed,Object? code = freezed,}) {
  return _then(_Certification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,issuer: null == issuer ? _self.issuer : issuer // ignore: cast_nullable_to_non_nullable
as LocalizedText,issuedOn: null == issuedOn ? _self.issuedOn : issuedOn // ignore: cast_nullable_to_non_nullable
as DateTime,expiresOn: null == expiresOn ? _self.expiresOn : expiresOn // ignore: cast_nullable_to_non_nullable
as DateTime,verification: null == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as Verification,fileRef: freezed == fileRef ? _self.fileRef : fileRef // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get issuer {
  
  return $LocalizedTextCopyWith<$Res>(_self.issuer, (value) {
    return _then(_self.copyWith(issuer: value));
  });
}
}


/// @nodoc
mixin _$CpdEntry {

 String get id; String get userId;@DateOnlyConverter() DateTime get date; LocalizedText get activity; CpdSource get source; int get credits;
/// Create a copy of CpdEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CpdEntryCopyWith<CpdEntry> get copyWith => _$CpdEntryCopyWithImpl<CpdEntry>(this as CpdEntry, _$identity);

  /// Serializes this CpdEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CpdEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CpdEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.activity, _this.activity) || other.activity == _this.activity)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.credits, _this.credits) || other.credits == _this.credits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CpdEntry;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.date,_this.activity,_this.source,_this.credits);
}

@override
String toString() {
  final _this = this as CpdEntry;
  return 'CpdEntry(id: ${_this.id}, userId: ${_this.userId}, date: ${_this.date}, activity: ${_this.activity}, source: ${_this.source}, credits: ${_this.credits})';
}


}

/// @nodoc
abstract mixin class $CpdEntryCopyWith<$Res>  {
  factory $CpdEntryCopyWith(CpdEntry value, $Res Function(CpdEntry) _then) = _$CpdEntryCopyWithImpl;
@useResult
$Res call({
 String id, String userId,@DateOnlyConverter() DateTime date, LocalizedText activity, CpdSource source, int credits
});


$LocalizedTextCopyWith<$Res> get activity;

}
/// @nodoc
class _$CpdEntryCopyWithImpl<$Res>
    implements $CpdEntryCopyWith<$Res> {
  _$CpdEntryCopyWithImpl(this._self, this._then);

  final CpdEntry _self;
  final $Res Function(CpdEntry) _then;

/// Create a copy of CpdEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? activity = null,Object? source = null,Object? credits = null,}) {
  return _then(CpdEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,activity: null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as LocalizedText,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as CpdSource,credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CpdEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get activity {
  
  return $LocalizedTextCopyWith<$Res>(_self.activity, (value) {
    return _then(_self.copyWith(activity: value));
  });
}
}


/// Adds pattern-matching-related methods to [CpdEntry].
extension CpdEntryPatterns on CpdEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CpdEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CpdEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CpdEntry value)  $default,){
final _that = this;
switch (_that) {
case _CpdEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CpdEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CpdEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId, @DateOnlyConverter()  DateTime date,  LocalizedText activity,  CpdSource source,  int credits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CpdEntry() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.activity,_that.source,_that.credits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId, @DateOnlyConverter()  DateTime date,  LocalizedText activity,  CpdSource source,  int credits)  $default,) {final _that = this;
switch (_that) {
case _CpdEntry():
return $default(_that.id,_that.userId,_that.date,_that.activity,_that.source,_that.credits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId, @DateOnlyConverter()  DateTime date,  LocalizedText activity,  CpdSource source,  int credits)?  $default,) {final _that = this;
switch (_that) {
case _CpdEntry() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.activity,_that.source,_that.credits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CpdEntry implements CpdEntry {
  const _CpdEntry({required this.id, required this.userId, @DateOnlyConverter() required this.date, required this.activity, required this.source, required this.credits});
  factory _CpdEntry.fromJson(Map<String, dynamic> json) => _$CpdEntryFromJson(json);

@override final  String id;
@override final  String userId;
@override@DateOnlyConverter() final  DateTime date;
@override final  LocalizedText activity;
@override final  CpdSource source;
@override final  int credits;

/// Create a copy of CpdEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CpdEntryCopyWith<_CpdEntry> get copyWith => __$CpdEntryCopyWithImpl<_CpdEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CpdEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CpdEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.activity, activity) || other.activity == activity)&&(identical(other.source, source) || other.source == source)&&(identical(other.credits, credits) || other.credits == credits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,date,activity,source,credits);
}

@override
String toString() {
    return 'CpdEntry(id: $id, userId: $userId, date: $date, activity: $activity, source: $source, credits: $credits)';
}


}

/// @nodoc
abstract mixin class _$CpdEntryCopyWith<$Res> implements $CpdEntryCopyWith<$Res> {
  factory _$CpdEntryCopyWith(_CpdEntry value, $Res Function(_CpdEntry) _then) = __$CpdEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId,@DateOnlyConverter() DateTime date, LocalizedText activity, CpdSource source, int credits
});


@override $LocalizedTextCopyWith<$Res> get activity;

}
/// @nodoc
class __$CpdEntryCopyWithImpl<$Res>
    implements _$CpdEntryCopyWith<$Res> {
  __$CpdEntryCopyWithImpl(this._self, this._then);

  final _CpdEntry _self;
  final $Res Function(_CpdEntry) _then;

/// Create a copy of CpdEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? activity = null,Object? source = null,Object? credits = null,}) {
  return _then(_CpdEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,activity: null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as LocalizedText,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as CpdSource,credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CpdEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get activity {
  
  return $LocalizedTextCopyWith<$Res>(_self.activity, (value) {
    return _then(_self.copyWith(activity: value));
  });
}
}


/// @nodoc
mixin _$CpdConfig {

 String get cycle; int get target; bool get targetIsDemo; LocalizedText get targetNote;
/// Create a copy of CpdConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CpdConfigCopyWith<CpdConfig> get copyWith => _$CpdConfigCopyWithImpl<CpdConfig>(this as CpdConfig, _$identity);

  /// Serializes this CpdConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CpdConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CpdConfig&&(identical(other.cycle, _this.cycle) || other.cycle == _this.cycle)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.targetIsDemo, _this.targetIsDemo) || other.targetIsDemo == _this.targetIsDemo)&&(identical(other.targetNote, _this.targetNote) || other.targetNote == _this.targetNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CpdConfig;
  return Object.hash(runtimeType,_this.cycle,_this.target,_this.targetIsDemo,_this.targetNote);
}

@override
String toString() {
  final _this = this as CpdConfig;
  return 'CpdConfig(cycle: ${_this.cycle}, target: ${_this.target}, targetIsDemo: ${_this.targetIsDemo}, targetNote: ${_this.targetNote})';
}


}

/// @nodoc
abstract mixin class $CpdConfigCopyWith<$Res>  {
  factory $CpdConfigCopyWith(CpdConfig value, $Res Function(CpdConfig) _then) = _$CpdConfigCopyWithImpl;
@useResult
$Res call({
 String cycle, int target, bool targetIsDemo, LocalizedText targetNote
});


$LocalizedTextCopyWith<$Res> get targetNote;

}
/// @nodoc
class _$CpdConfigCopyWithImpl<$Res>
    implements $CpdConfigCopyWith<$Res> {
  _$CpdConfigCopyWithImpl(this._self, this._then);

  final CpdConfig _self;
  final $Res Function(CpdConfig) _then;

/// Create a copy of CpdConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cycle = null,Object? target = null,Object? targetIsDemo = null,Object? targetNote = null,}) {
  return _then(CpdConfig(
cycle: null == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,targetIsDemo: null == targetIsDemo ? _self.targetIsDemo : targetIsDemo // ignore: cast_nullable_to_non_nullable
as bool,targetNote: null == targetNote ? _self.targetNote : targetNote // ignore: cast_nullable_to_non_nullable
as LocalizedText,
  ));
}
/// Create a copy of CpdConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get targetNote {
  
  return $LocalizedTextCopyWith<$Res>(_self.targetNote, (value) {
    return _then(_self.copyWith(targetNote: value));
  });
}
}


/// Adds pattern-matching-related methods to [CpdConfig].
extension CpdConfigPatterns on CpdConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CpdConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CpdConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CpdConfig value)  $default,){
final _that = this;
switch (_that) {
case _CpdConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CpdConfig value)?  $default,){
final _that = this;
switch (_that) {
case _CpdConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cycle,  int target,  bool targetIsDemo,  LocalizedText targetNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CpdConfig() when $default != null:
return $default(_that.cycle,_that.target,_that.targetIsDemo,_that.targetNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cycle,  int target,  bool targetIsDemo,  LocalizedText targetNote)  $default,) {final _that = this;
switch (_that) {
case _CpdConfig():
return $default(_that.cycle,_that.target,_that.targetIsDemo,_that.targetNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cycle,  int target,  bool targetIsDemo,  LocalizedText targetNote)?  $default,) {final _that = this;
switch (_that) {
case _CpdConfig() when $default != null:
return $default(_that.cycle,_that.target,_that.targetIsDemo,_that.targetNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CpdConfig implements CpdConfig {
  const _CpdConfig({required this.cycle, required this.target, required this.targetIsDemo, required this.targetNote});
  factory _CpdConfig.fromJson(Map<String, dynamic> json) => _$CpdConfigFromJson(json);

@override final  String cycle;
@override final  int target;
@override final  bool targetIsDemo;
@override final  LocalizedText targetNote;

/// Create a copy of CpdConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CpdConfigCopyWith<_CpdConfig> get copyWith => __$CpdConfigCopyWithImpl<_CpdConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CpdConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CpdConfig&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.target, target) || other.target == target)&&(identical(other.targetIsDemo, targetIsDemo) || other.targetIsDemo == targetIsDemo)&&(identical(other.targetNote, targetNote) || other.targetNote == targetNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,cycle,target,targetIsDemo,targetNote);
}

@override
String toString() {
    return 'CpdConfig(cycle: $cycle, target: $target, targetIsDemo: $targetIsDemo, targetNote: $targetNote)';
}


}

/// @nodoc
abstract mixin class _$CpdConfigCopyWith<$Res> implements $CpdConfigCopyWith<$Res> {
  factory _$CpdConfigCopyWith(_CpdConfig value, $Res Function(_CpdConfig) _then) = __$CpdConfigCopyWithImpl;
@override @useResult
$Res call({
 String cycle, int target, bool targetIsDemo, LocalizedText targetNote
});


@override $LocalizedTextCopyWith<$Res> get targetNote;

}
/// @nodoc
class __$CpdConfigCopyWithImpl<$Res>
    implements _$CpdConfigCopyWith<$Res> {
  __$CpdConfigCopyWithImpl(this._self, this._then);

  final _CpdConfig _self;
  final $Res Function(_CpdConfig) _then;

/// Create a copy of CpdConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cycle = null,Object? target = null,Object? targetIsDemo = null,Object? targetNote = null,}) {
  return _then(_CpdConfig(
cycle: null == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,targetIsDemo: null == targetIsDemo ? _self.targetIsDemo : targetIsDemo // ignore: cast_nullable_to_non_nullable
as bool,targetNote: null == targetNote ? _self.targetNote : targetNote // ignore: cast_nullable_to_non_nullable
as LocalizedText,
  ));
}

/// Create a copy of CpdConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get targetNote {
  
  return $LocalizedTextCopyWith<$Res>(_self.targetNote, (value) {
    return _then(_self.copyWith(targetNote: value));
  });
}
}

// dart format on
