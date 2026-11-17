// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseCategory {

 String get id; LocalizedText get label;
/// Create a copy of CourseCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseCategoryCopyWith<CourseCategory> get copyWith => _$CourseCategoryCopyWithImpl<CourseCategory>(this as CourseCategory, _$identity);

  /// Serializes this CourseCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CourseCategory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseCategory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CourseCategory;
  return Object.hash(runtimeType,_this.id,_this.label);
}

@override
String toString() {
  final _this = this as CourseCategory;
  return 'CourseCategory(id: ${_this.id}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $CourseCategoryCopyWith<$Res>  {
  factory $CourseCategoryCopyWith(CourseCategory value, $Res Function(CourseCategory) _then) = _$CourseCategoryCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText label
});


$LocalizedTextCopyWith<$Res> get label;

}
/// @nodoc
class _$CourseCategoryCopyWithImpl<$Res>
    implements $CourseCategoryCopyWith<$Res> {
  _$CourseCategoryCopyWithImpl(this._self, this._then);

  final CourseCategory _self;
  final $Res Function(CourseCategory) _then;

/// Create a copy of CourseCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(CourseCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,
  ));
}
/// Create a copy of CourseCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get label {
  
  return $LocalizedTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}


/// Adds pattern-matching-related methods to [CourseCategory].
extension CourseCategoryPatterns on CourseCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseCategory value)  $default,){
final _that = this;
switch (_that) {
case _CourseCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseCategory value)?  $default,){
final _that = this;
switch (_that) {
case _CourseCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseCategory() when $default != null:
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText label)  $default,) {final _that = this;
switch (_that) {
case _CourseCategory():
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText label)?  $default,) {final _that = this;
switch (_that) {
case _CourseCategory() when $default != null:
return $default(_that.id,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseCategory implements CourseCategory {
  const _CourseCategory({required this.id, required this.label});
  factory _CourseCategory.fromJson(Map<String, dynamic> json) => _$CourseCategoryFromJson(json);

@override final  String id;
@override final  LocalizedText label;

/// Create a copy of CourseCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseCategoryCopyWith<_CourseCategory> get copyWith => __$CourseCategoryCopyWithImpl<_CourseCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label);
}

@override
String toString() {
    return 'CourseCategory(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$CourseCategoryCopyWith<$Res> implements $CourseCategoryCopyWith<$Res> {
  factory _$CourseCategoryCopyWith(_CourseCategory value, $Res Function(_CourseCategory) _then) = __$CourseCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText label
});


@override $LocalizedTextCopyWith<$Res> get label;

}
/// @nodoc
class __$CourseCategoryCopyWithImpl<$Res>
    implements _$CourseCategoryCopyWith<$Res> {
  __$CourseCategoryCopyWithImpl(this._self, this._then);

  final _CourseCategory _self;
  final $Res Function(_CourseCategory) _then;

/// Create a copy of CourseCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_CourseCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,
  ));
}

/// Create a copy of CourseCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get label {
  
  return $LocalizedTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}


/// @nodoc
mixin _$Lesson {

 String get id; int get order; LocalizedText get title; LessonType get type; int get minutes; String get assetRef;
/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonCopyWith<Lesson> get copyWith => _$LessonCopyWithImpl<Lesson>(this as Lesson, _$identity);

  /// Serializes this Lesson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Lesson;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lesson&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.minutes, _this.minutes) || other.minutes == _this.minutes)&&(identical(other.assetRef, _this.assetRef) || other.assetRef == _this.assetRef));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Lesson;
  return Object.hash(runtimeType,_this.id,_this.order,_this.title,_this.type,_this.minutes,_this.assetRef);
}

@override
String toString() {
  final _this = this as Lesson;
  return 'Lesson(id: ${_this.id}, order: ${_this.order}, title: ${_this.title}, type: ${_this.type}, minutes: ${_this.minutes}, assetRef: ${_this.assetRef})';
}


}

/// @nodoc
abstract mixin class $LessonCopyWith<$Res>  {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) _then) = _$LessonCopyWithImpl;
@useResult
$Res call({
 String id, int order, LocalizedText title, LessonType type, int minutes, String assetRef
});


$LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class _$LessonCopyWithImpl<$Res>
    implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._self, this._then);

  final Lesson _self;
  final $Res Function(Lesson) _then;

/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? order = null,Object? title = null,Object? type = null,Object? minutes = null,Object? assetRef = null,}) {
  return _then(Lesson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LessonType,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,assetRef: null == assetRef ? _self.assetRef : assetRef // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// Adds pattern-matching-related methods to [Lesson].
extension LessonPatterns on Lesson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Lesson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Lesson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Lesson value)  $default,){
final _that = this;
switch (_that) {
case _Lesson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Lesson value)?  $default,){
final _that = this;
switch (_that) {
case _Lesson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int order,  LocalizedText title,  LessonType type,  int minutes,  String assetRef)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Lesson() when $default != null:
return $default(_that.id,_that.order,_that.title,_that.type,_that.minutes,_that.assetRef);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int order,  LocalizedText title,  LessonType type,  int minutes,  String assetRef)  $default,) {final _that = this;
switch (_that) {
case _Lesson():
return $default(_that.id,_that.order,_that.title,_that.type,_that.minutes,_that.assetRef);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int order,  LocalizedText title,  LessonType type,  int minutes,  String assetRef)?  $default,) {final _that = this;
switch (_that) {
case _Lesson() when $default != null:
return $default(_that.id,_that.order,_that.title,_that.type,_that.minutes,_that.assetRef);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Lesson implements Lesson {
  const _Lesson({required this.id, required this.order, required this.title, required this.type, required this.minutes, required this.assetRef});
  factory _Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

@override final  String id;
@override final  int order;
@override final  LocalizedText title;
@override final  LessonType type;
@override final  int minutes;
@override final  String assetRef;

/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonCopyWith<_Lesson> get copyWith => __$LessonCopyWithImpl<_Lesson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lesson&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.assetRef, assetRef) || other.assetRef == assetRef));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,order,title,type,minutes,assetRef);
}

@override
String toString() {
    return 'Lesson(id: $id, order: $order, title: $title, type: $type, minutes: $minutes, assetRef: $assetRef)';
}


}

/// @nodoc
abstract mixin class _$LessonCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$LessonCopyWith(_Lesson value, $Res Function(_Lesson) _then) = __$LessonCopyWithImpl;
@override @useResult
$Res call({
 String id, int order, LocalizedText title, LessonType type, int minutes, String assetRef
});


@override $LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class __$LessonCopyWithImpl<$Res>
    implements _$LessonCopyWith<$Res> {
  __$LessonCopyWithImpl(this._self, this._then);

  final _Lesson _self;
  final $Res Function(_Lesson) _then;

/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? order = null,Object? title = null,Object? type = null,Object? minutes = null,Object? assetRef = null,}) {
  return _then(_Lesson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LessonType,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,assetRef: null == assetRef ? _self.assetRef : assetRef // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// @nodoc
mixin _$Course {

 String get id; LocalizedText get title; String get category; CourseCover get cover; int get durationMin; int get cpdCredits; int get priceFils; List<Lesson> get lessons;
/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseCopyWith<Course> get copyWith => _$CourseCopyWithImpl<Course>(this as Course, _$identity);

  /// Serializes this Course to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Course;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Course&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.cover, _this.cover) || other.cover == _this.cover)&&(identical(other.durationMin, _this.durationMin) || other.durationMin == _this.durationMin)&&(identical(other.cpdCredits, _this.cpdCredits) || other.cpdCredits == _this.cpdCredits)&&(identical(other.priceFils, _this.priceFils) || other.priceFils == _this.priceFils)&&const DeepCollectionEquality().equals(other.lessons, _this.lessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Course;
  return Object.hash(runtimeType,_this.id,_this.title,_this.category,_this.cover,_this.durationMin,_this.cpdCredits,_this.priceFils,const DeepCollectionEquality().hash(_this.lessons));
}

@override
String toString() {
  final _this = this as Course;
  return 'Course(id: ${_this.id}, title: ${_this.title}, category: ${_this.category}, cover: ${_this.cover}, durationMin: ${_this.durationMin}, cpdCredits: ${_this.cpdCredits}, priceFils: ${_this.priceFils}, lessons: ${_this.lessons})';
}


}

/// @nodoc
abstract mixin class $CourseCopyWith<$Res>  {
  factory $CourseCopyWith(Course value, $Res Function(Course) _then) = _$CourseCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText title, String category, CourseCover cover, int durationMin, int cpdCredits, int priceFils, List<Lesson> lessons
});


$LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class _$CourseCopyWithImpl<$Res>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._self, this._then);

  final Course _self;
  final $Res Function(Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? category = null,Object? cover = null,Object? durationMin = null,Object? cpdCredits = null,Object? priceFils = null,Object? lessons = null,}) {
  return _then(Course(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as CourseCover,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,cpdCredits: null == cpdCredits ? _self.cpdCredits : cpdCredits // ignore: cast_nullable_to_non_nullable
as int,priceFils: null == priceFils ? _self.priceFils : priceFils // ignore: cast_nullable_to_non_nullable
as int,lessons: null == lessons ? _self.lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,
  ));
}
/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// Adds pattern-matching-related methods to [Course].
extension CoursePatterns on Course {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Course value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Course() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Course value)  $default,){
final _that = this;
switch (_that) {
case _Course():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Course value)?  $default,){
final _that = this;
switch (_that) {
case _Course() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText title,  String category,  CourseCover cover,  int durationMin,  int cpdCredits,  int priceFils,  List<Lesson> lessons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Course() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.cover,_that.durationMin,_that.cpdCredits,_that.priceFils,_that.lessons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText title,  String category,  CourseCover cover,  int durationMin,  int cpdCredits,  int priceFils,  List<Lesson> lessons)  $default,) {final _that = this;
switch (_that) {
case _Course():
return $default(_that.id,_that.title,_that.category,_that.cover,_that.durationMin,_that.cpdCredits,_that.priceFils,_that.lessons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText title,  String category,  CourseCover cover,  int durationMin,  int cpdCredits,  int priceFils,  List<Lesson> lessons)?  $default,) {final _that = this;
switch (_that) {
case _Course() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.cover,_that.durationMin,_that.cpdCredits,_that.priceFils,_that.lessons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Course extends Course {
  const _Course({required this.id, required this.title, required this.category, required this.cover, required this.durationMin, required this.cpdCredits, required this.priceFils, required  List<Lesson> lessons}): _lessons = lessons,super._();
  factory _Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

@override final  String id;
@override final  LocalizedText title;
@override final  String category;
@override final  CourseCover cover;
@override final  int durationMin;
@override final  int cpdCredits;
@override final  int priceFils;
 final  List<Lesson> _lessons;
@override List<Lesson> get lessons {
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessons);
}


/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseCopyWith<_Course> get copyWith => __$CourseCopyWithImpl<_Course>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Course&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.cpdCredits, cpdCredits) || other.cpdCredits == cpdCredits)&&(identical(other.priceFils, priceFils) || other.priceFils == priceFils)&&const DeepCollectionEquality().equals(other.lessons, _lessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,category,cover,durationMin,cpdCredits,priceFils,const DeepCollectionEquality().hash(_lessons));
}

@override
String toString() {
    return 'Course(id: $id, title: $title, category: $category, cover: $cover, durationMin: $durationMin, cpdCredits: $cpdCredits, priceFils: $priceFils, lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class _$CourseCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$CourseCopyWith(_Course value, $Res Function(_Course) _then) = __$CourseCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText title, String category, CourseCover cover, int durationMin, int cpdCredits, int priceFils, List<Lesson> lessons
});


@override $LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class __$CourseCopyWithImpl<$Res>
    implements _$CourseCopyWith<$Res> {
  __$CourseCopyWithImpl(this._self, this._then);

  final _Course _self;
  final $Res Function(_Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? category = null,Object? cover = null,Object? durationMin = null,Object? cpdCredits = null,Object? priceFils = null,Object? lessons = null,}) {
  return _then(_Course(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as CourseCover,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,cpdCredits: null == cpdCredits ? _self.cpdCredits : cpdCredits // ignore: cast_nullable_to_non_nullable
as int,priceFils: null == priceFils ? _self.priceFils : priceFils // ignore: cast_nullable_to_non_nullable
as int,lessons: null == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,
  ));
}

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// @nodoc
mixin _$LessonProgress {

 String get userId; String get lessonId;@UtcDateTimeConverter() DateTime get completedAt;
/// Create a copy of LessonProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonProgressCopyWith<LessonProgress> get copyWith => _$LessonProgressCopyWithImpl<LessonProgress>(this as LessonProgress, _$identity);

  /// Serializes this LessonProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LessonProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonProgress&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.lessonId, _this.lessonId) || other.lessonId == _this.lessonId)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LessonProgress;
  return Object.hash(runtimeType,_this.userId,_this.lessonId,_this.completedAt);
}

@override
String toString() {
  final _this = this as LessonProgress;
  return 'LessonProgress(userId: ${_this.userId}, lessonId: ${_this.lessonId}, completedAt: ${_this.completedAt})';
}


}

/// @nodoc
abstract mixin class $LessonProgressCopyWith<$Res>  {
  factory $LessonProgressCopyWith(LessonProgress value, $Res Function(LessonProgress) _then) = _$LessonProgressCopyWithImpl;
@useResult
$Res call({
 String userId, String lessonId,@UtcDateTimeConverter() DateTime completedAt
});




}
/// @nodoc
class _$LessonProgressCopyWithImpl<$Res>
    implements $LessonProgressCopyWith<$Res> {
  _$LessonProgressCopyWithImpl(this._self, this._then);

  final LessonProgress _self;
  final $Res Function(LessonProgress) _then;

/// Create a copy of LessonProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? lessonId = null,Object? completedAt = null,}) {
  return _then(LessonProgress(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonProgress].
extension LessonProgressPatterns on LessonProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonProgress value)  $default,){
final _that = this;
switch (_that) {
case _LessonProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonProgress value)?  $default,){
final _that = this;
switch (_that) {
case _LessonProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String lessonId, @UtcDateTimeConverter()  DateTime completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonProgress() when $default != null:
return $default(_that.userId,_that.lessonId,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String lessonId, @UtcDateTimeConverter()  DateTime completedAt)  $default,) {final _that = this;
switch (_that) {
case _LessonProgress():
return $default(_that.userId,_that.lessonId,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String lessonId, @UtcDateTimeConverter()  DateTime completedAt)?  $default,) {final _that = this;
switch (_that) {
case _LessonProgress() when $default != null:
return $default(_that.userId,_that.lessonId,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LessonProgress implements LessonProgress {
  const _LessonProgress({required this.userId, required this.lessonId, @UtcDateTimeConverter() required this.completedAt});
  factory _LessonProgress.fromJson(Map<String, dynamic> json) => _$LessonProgressFromJson(json);

@override final  String userId;
@override final  String lessonId;
@override@UtcDateTimeConverter() final  DateTime completedAt;

/// Create a copy of LessonProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonProgressCopyWith<_LessonProgress> get copyWith => __$LessonProgressCopyWithImpl<_LessonProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonProgressToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonProgress&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,lessonId,completedAt);
}

@override
String toString() {
    return 'LessonProgress(userId: $userId, lessonId: $lessonId, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$LessonProgressCopyWith<$Res> implements $LessonProgressCopyWith<$Res> {
  factory _$LessonProgressCopyWith(_LessonProgress value, $Res Function(_LessonProgress) _then) = __$LessonProgressCopyWithImpl;
@override @useResult
$Res call({
 String userId, String lessonId,@UtcDateTimeConverter() DateTime completedAt
});




}
/// @nodoc
class __$LessonProgressCopyWithImpl<$Res>
    implements _$LessonProgressCopyWith<$Res> {
  __$LessonProgressCopyWithImpl(this._self, this._then);

  final _LessonProgress _self;
  final $Res Function(_LessonProgress) _then;

/// Create a copy of LessonProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? lessonId = null,Object? completedAt = null,}) {
  return _then(_LessonProgress(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
