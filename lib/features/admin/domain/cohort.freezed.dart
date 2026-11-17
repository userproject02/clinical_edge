// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cohort.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CohortStats {

 bool get demoFigures; LocalizedText get demoLabel;@DateOnlyConverter() DateTime get asOf; List<Department> get departments; CohortKpis get kpis; List<CoursePct> get completionByCourse; List<DepartmentPct> get progressByDepartment; List<MonthCount> get expiriesByMonth; List<CohortLearner> get learners; UsageInsights get insights;
/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CohortStatsCopyWith<CohortStats> get copyWith => _$CohortStatsCopyWithImpl<CohortStats>(this as CohortStats, _$identity);

  /// Serializes this CohortStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CohortStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CohortStats&&(identical(other.demoFigures, _this.demoFigures) || other.demoFigures == _this.demoFigures)&&(identical(other.demoLabel, _this.demoLabel) || other.demoLabel == _this.demoLabel)&&(identical(other.asOf, _this.asOf) || other.asOf == _this.asOf)&&const DeepCollectionEquality().equals(other.departments, _this.departments)&&(identical(other.kpis, _this.kpis) || other.kpis == _this.kpis)&&const DeepCollectionEquality().equals(other.completionByCourse, _this.completionByCourse)&&const DeepCollectionEquality().equals(other.progressByDepartment, _this.progressByDepartment)&&const DeepCollectionEquality().equals(other.expiriesByMonth, _this.expiriesByMonth)&&const DeepCollectionEquality().equals(other.learners, _this.learners)&&(identical(other.insights, _this.insights) || other.insights == _this.insights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CohortStats;
  return Object.hash(runtimeType,_this.demoFigures,_this.demoLabel,_this.asOf,const DeepCollectionEquality().hash(_this.departments),_this.kpis,const DeepCollectionEquality().hash(_this.completionByCourse),const DeepCollectionEquality().hash(_this.progressByDepartment),const DeepCollectionEquality().hash(_this.expiriesByMonth),const DeepCollectionEquality().hash(_this.learners),_this.insights);
}

@override
String toString() {
  final _this = this as CohortStats;
  return 'CohortStats(demoFigures: ${_this.demoFigures}, demoLabel: ${_this.demoLabel}, asOf: ${_this.asOf}, departments: ${_this.departments}, kpis: ${_this.kpis}, completionByCourse: ${_this.completionByCourse}, progressByDepartment: ${_this.progressByDepartment}, expiriesByMonth: ${_this.expiriesByMonth}, learners: ${_this.learners}, insights: ${_this.insights})';
}


}

/// @nodoc
abstract mixin class $CohortStatsCopyWith<$Res>  {
  factory $CohortStatsCopyWith(CohortStats value, $Res Function(CohortStats) _then) = _$CohortStatsCopyWithImpl;
@useResult
$Res call({
 bool demoFigures, LocalizedText demoLabel,@DateOnlyConverter() DateTime asOf, List<Department> departments, CohortKpis kpis, List<CoursePct> completionByCourse, List<DepartmentPct> progressByDepartment, List<MonthCount> expiriesByMonth, List<CohortLearner> learners, UsageInsights insights
});


$LocalizedTextCopyWith<$Res> get demoLabel;$CohortKpisCopyWith<$Res> get kpis;$UsageInsightsCopyWith<$Res> get insights;

}
/// @nodoc
class _$CohortStatsCopyWithImpl<$Res>
    implements $CohortStatsCopyWith<$Res> {
  _$CohortStatsCopyWithImpl(this._self, this._then);

  final CohortStats _self;
  final $Res Function(CohortStats) _then;

/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? demoFigures = null,Object? demoLabel = null,Object? asOf = null,Object? departments = null,Object? kpis = null,Object? completionByCourse = null,Object? progressByDepartment = null,Object? expiriesByMonth = null,Object? learners = null,Object? insights = null,}) {
  return _then(CohortStats(
demoFigures: null == demoFigures ? _self.demoFigures : demoFigures // ignore: cast_nullable_to_non_nullable
as bool,demoLabel: null == demoLabel ? _self.demoLabel : demoLabel // ignore: cast_nullable_to_non_nullable
as LocalizedText,asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as DateTime,departments: null == departments ? _self.departments : departments // ignore: cast_nullable_to_non_nullable
as List<Department>,kpis: null == kpis ? _self.kpis : kpis // ignore: cast_nullable_to_non_nullable
as CohortKpis,completionByCourse: null == completionByCourse ? _self.completionByCourse : completionByCourse // ignore: cast_nullable_to_non_nullable
as List<CoursePct>,progressByDepartment: null == progressByDepartment ? _self.progressByDepartment : progressByDepartment // ignore: cast_nullable_to_non_nullable
as List<DepartmentPct>,expiriesByMonth: null == expiriesByMonth ? _self.expiriesByMonth : expiriesByMonth // ignore: cast_nullable_to_non_nullable
as List<MonthCount>,learners: null == learners ? _self.learners : learners // ignore: cast_nullable_to_non_nullable
as List<CohortLearner>,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as UsageInsights,
  ));
}
/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get demoLabel {
  
  return $LocalizedTextCopyWith<$Res>(_self.demoLabel, (value) {
    return _then(_self.copyWith(demoLabel: value));
  });
}/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CohortKpisCopyWith<$Res> get kpis {
  
  return $CohortKpisCopyWith<$Res>(_self.kpis, (value) {
    return _then(_self.copyWith(kpis: value));
  });
}/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsageInsightsCopyWith<$Res> get insights {
  
  return $UsageInsightsCopyWith<$Res>(_self.insights, (value) {
    return _then(_self.copyWith(insights: value));
  });
}
}


/// Adds pattern-matching-related methods to [CohortStats].
extension CohortStatsPatterns on CohortStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CohortStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CohortStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CohortStats value)  $default,){
final _that = this;
switch (_that) {
case _CohortStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CohortStats value)?  $default,){
final _that = this;
switch (_that) {
case _CohortStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool demoFigures,  LocalizedText demoLabel, @DateOnlyConverter()  DateTime asOf,  List<Department> departments,  CohortKpis kpis,  List<CoursePct> completionByCourse,  List<DepartmentPct> progressByDepartment,  List<MonthCount> expiriesByMonth,  List<CohortLearner> learners,  UsageInsights insights)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CohortStats() when $default != null:
return $default(_that.demoFigures,_that.demoLabel,_that.asOf,_that.departments,_that.kpis,_that.completionByCourse,_that.progressByDepartment,_that.expiriesByMonth,_that.learners,_that.insights);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool demoFigures,  LocalizedText demoLabel, @DateOnlyConverter()  DateTime asOf,  List<Department> departments,  CohortKpis kpis,  List<CoursePct> completionByCourse,  List<DepartmentPct> progressByDepartment,  List<MonthCount> expiriesByMonth,  List<CohortLearner> learners,  UsageInsights insights)  $default,) {final _that = this;
switch (_that) {
case _CohortStats():
return $default(_that.demoFigures,_that.demoLabel,_that.asOf,_that.departments,_that.kpis,_that.completionByCourse,_that.progressByDepartment,_that.expiriesByMonth,_that.learners,_that.insights);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool demoFigures,  LocalizedText demoLabel, @DateOnlyConverter()  DateTime asOf,  List<Department> departments,  CohortKpis kpis,  List<CoursePct> completionByCourse,  List<DepartmentPct> progressByDepartment,  List<MonthCount> expiriesByMonth,  List<CohortLearner> learners,  UsageInsights insights)?  $default,) {final _that = this;
switch (_that) {
case _CohortStats() when $default != null:
return $default(_that.demoFigures,_that.demoLabel,_that.asOf,_that.departments,_that.kpis,_that.completionByCourse,_that.progressByDepartment,_that.expiriesByMonth,_that.learners,_that.insights);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CohortStats implements CohortStats {
  const _CohortStats({required this.demoFigures, required this.demoLabel, @DateOnlyConverter() required this.asOf, required  List<Department> departments, required this.kpis, required  List<CoursePct> completionByCourse, required  List<DepartmentPct> progressByDepartment, required  List<MonthCount> expiriesByMonth, required  List<CohortLearner> learners, required this.insights}): _departments = departments,_completionByCourse = completionByCourse,_progressByDepartment = progressByDepartment,_expiriesByMonth = expiriesByMonth,_learners = learners;
  factory _CohortStats.fromJson(Map<String, dynamic> json) => _$CohortStatsFromJson(json);

@override final  bool demoFigures;
@override final  LocalizedText demoLabel;
@override@DateOnlyConverter() final  DateTime asOf;
 final  List<Department> _departments;
@override List<Department> get departments {
  if (_departments is EqualUnmodifiableListView) return _departments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departments);
}

@override final  CohortKpis kpis;
 final  List<CoursePct> _completionByCourse;
@override List<CoursePct> get completionByCourse {
  if (_completionByCourse is EqualUnmodifiableListView) return _completionByCourse;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completionByCourse);
}

 final  List<DepartmentPct> _progressByDepartment;
@override List<DepartmentPct> get progressByDepartment {
  if (_progressByDepartment is EqualUnmodifiableListView) return _progressByDepartment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_progressByDepartment);
}

 final  List<MonthCount> _expiriesByMonth;
@override List<MonthCount> get expiriesByMonth {
  if (_expiriesByMonth is EqualUnmodifiableListView) return _expiriesByMonth;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expiriesByMonth);
}

 final  List<CohortLearner> _learners;
@override List<CohortLearner> get learners {
  if (_learners is EqualUnmodifiableListView) return _learners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_learners);
}

@override final  UsageInsights insights;

/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CohortStatsCopyWith<_CohortStats> get copyWith => __$CohortStatsCopyWithImpl<_CohortStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CohortStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CohortStats&&(identical(other.demoFigures, demoFigures) || other.demoFigures == demoFigures)&&(identical(other.demoLabel, demoLabel) || other.demoLabel == demoLabel)&&(identical(other.asOf, asOf) || other.asOf == asOf)&&const DeepCollectionEquality().equals(other.departments, _departments)&&(identical(other.kpis, kpis) || other.kpis == kpis)&&const DeepCollectionEquality().equals(other.completionByCourse, _completionByCourse)&&const DeepCollectionEquality().equals(other.progressByDepartment, _progressByDepartment)&&const DeepCollectionEquality().equals(other.expiriesByMonth, _expiriesByMonth)&&const DeepCollectionEquality().equals(other.learners, _learners)&&(identical(other.insights, insights) || other.insights == insights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,demoFigures,demoLabel,asOf,const DeepCollectionEquality().hash(_departments),kpis,const DeepCollectionEquality().hash(_completionByCourse),const DeepCollectionEquality().hash(_progressByDepartment),const DeepCollectionEquality().hash(_expiriesByMonth),const DeepCollectionEquality().hash(_learners),insights);
}

@override
String toString() {
    return 'CohortStats(demoFigures: $demoFigures, demoLabel: $demoLabel, asOf: $asOf, departments: $departments, kpis: $kpis, completionByCourse: $completionByCourse, progressByDepartment: $progressByDepartment, expiriesByMonth: $expiriesByMonth, learners: $learners, insights: $insights)';
}


}

/// @nodoc
abstract mixin class _$CohortStatsCopyWith<$Res> implements $CohortStatsCopyWith<$Res> {
  factory _$CohortStatsCopyWith(_CohortStats value, $Res Function(_CohortStats) _then) = __$CohortStatsCopyWithImpl;
@override @useResult
$Res call({
 bool demoFigures, LocalizedText demoLabel,@DateOnlyConverter() DateTime asOf, List<Department> departments, CohortKpis kpis, List<CoursePct> completionByCourse, List<DepartmentPct> progressByDepartment, List<MonthCount> expiriesByMonth, List<CohortLearner> learners, UsageInsights insights
});


@override $LocalizedTextCopyWith<$Res> get demoLabel;@override $CohortKpisCopyWith<$Res> get kpis;@override $UsageInsightsCopyWith<$Res> get insights;

}
/// @nodoc
class __$CohortStatsCopyWithImpl<$Res>
    implements _$CohortStatsCopyWith<$Res> {
  __$CohortStatsCopyWithImpl(this._self, this._then);

  final _CohortStats _self;
  final $Res Function(_CohortStats) _then;

/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? demoFigures = null,Object? demoLabel = null,Object? asOf = null,Object? departments = null,Object? kpis = null,Object? completionByCourse = null,Object? progressByDepartment = null,Object? expiriesByMonth = null,Object? learners = null,Object? insights = null,}) {
  return _then(_CohortStats(
demoFigures: null == demoFigures ? _self.demoFigures : demoFigures // ignore: cast_nullable_to_non_nullable
as bool,demoLabel: null == demoLabel ? _self.demoLabel : demoLabel // ignore: cast_nullable_to_non_nullable
as LocalizedText,asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as DateTime,departments: null == departments ? _self._departments : departments // ignore: cast_nullable_to_non_nullable
as List<Department>,kpis: null == kpis ? _self.kpis : kpis // ignore: cast_nullable_to_non_nullable
as CohortKpis,completionByCourse: null == completionByCourse ? _self._completionByCourse : completionByCourse // ignore: cast_nullable_to_non_nullable
as List<CoursePct>,progressByDepartment: null == progressByDepartment ? _self._progressByDepartment : progressByDepartment // ignore: cast_nullable_to_non_nullable
as List<DepartmentPct>,expiriesByMonth: null == expiriesByMonth ? _self._expiriesByMonth : expiriesByMonth // ignore: cast_nullable_to_non_nullable
as List<MonthCount>,learners: null == learners ? _self._learners : learners // ignore: cast_nullable_to_non_nullable
as List<CohortLearner>,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as UsageInsights,
  ));
}

/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get demoLabel {
  
  return $LocalizedTextCopyWith<$Res>(_self.demoLabel, (value) {
    return _then(_self.copyWith(demoLabel: value));
  });
}/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CohortKpisCopyWith<$Res> get kpis {
  
  return $CohortKpisCopyWith<$Res>(_self.kpis, (value) {
    return _then(_self.copyWith(kpis: value));
  });
}/// Create a copy of CohortStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsageInsightsCopyWith<$Res> get insights {
  
  return $UsageInsightsCopyWith<$Res>(_self.insights, (value) {
    return _then(_self.copyWith(insights: value));
  });
}
}


/// @nodoc
mixin _$Department {

 String get id; LocalizedText get label;
/// Create a copy of Department
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartmentCopyWith<Department> get copyWith => _$DepartmentCopyWithImpl<Department>(this as Department, _$identity);

  /// Serializes this Department to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Department;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Department&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Department;
  return Object.hash(runtimeType,_this.id,_this.label);
}

@override
String toString() {
  final _this = this as Department;
  return 'Department(id: ${_this.id}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $DepartmentCopyWith<$Res>  {
  factory $DepartmentCopyWith(Department value, $Res Function(Department) _then) = _$DepartmentCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText label
});


$LocalizedTextCopyWith<$Res> get label;

}
/// @nodoc
class _$DepartmentCopyWithImpl<$Res>
    implements $DepartmentCopyWith<$Res> {
  _$DepartmentCopyWithImpl(this._self, this._then);

  final Department _self;
  final $Res Function(Department) _then;

/// Create a copy of Department
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(Department(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,
  ));
}
/// Create a copy of Department
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get label {
  
  return $LocalizedTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}


/// Adds pattern-matching-related methods to [Department].
extension DepartmentPatterns on Department {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Department value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Department() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Department value)  $default,){
final _that = this;
switch (_that) {
case _Department():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Department value)?  $default,){
final _that = this;
switch (_that) {
case _Department() when $default != null:
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
case _Department() when $default != null:
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
case _Department():
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
case _Department() when $default != null:
return $default(_that.id,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Department implements Department {
  const _Department({required this.id, required this.label});
  factory _Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

@override final  String id;
@override final  LocalizedText label;

/// Create a copy of Department
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartmentCopyWith<_Department> get copyWith => __$DepartmentCopyWithImpl<_Department>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepartmentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Department&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label);
}

@override
String toString() {
    return 'Department(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$DepartmentCopyWith<$Res> implements $DepartmentCopyWith<$Res> {
  factory _$DepartmentCopyWith(_Department value, $Res Function(_Department) _then) = __$DepartmentCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText label
});


@override $LocalizedTextCopyWith<$Res> get label;

}
/// @nodoc
class __$DepartmentCopyWithImpl<$Res>
    implements _$DepartmentCopyWith<$Res> {
  __$DepartmentCopyWithImpl(this._self, this._then);

  final _Department _self;
  final $Res Function(_Department) _then;

/// Create a copy of Department
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_Department(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,
  ));
}

/// Create a copy of Department
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
mixin _$CohortKpis {

 int get activeLearners; int get nursing; int get physicians; int get avgCompletionPct; int get avgCompletionDeltaPts; LocalizedText get deltaComparedTo; int get certsExpiringWithin90Days;
/// Create a copy of CohortKpis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CohortKpisCopyWith<CohortKpis> get copyWith => _$CohortKpisCopyWithImpl<CohortKpis>(this as CohortKpis, _$identity);

  /// Serializes this CohortKpis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CohortKpis;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CohortKpis&&(identical(other.activeLearners, _this.activeLearners) || other.activeLearners == _this.activeLearners)&&(identical(other.nursing, _this.nursing) || other.nursing == _this.nursing)&&(identical(other.physicians, _this.physicians) || other.physicians == _this.physicians)&&(identical(other.avgCompletionPct, _this.avgCompletionPct) || other.avgCompletionPct == _this.avgCompletionPct)&&(identical(other.avgCompletionDeltaPts, _this.avgCompletionDeltaPts) || other.avgCompletionDeltaPts == _this.avgCompletionDeltaPts)&&(identical(other.deltaComparedTo, _this.deltaComparedTo) || other.deltaComparedTo == _this.deltaComparedTo)&&(identical(other.certsExpiringWithin90Days, _this.certsExpiringWithin90Days) || other.certsExpiringWithin90Days == _this.certsExpiringWithin90Days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CohortKpis;
  return Object.hash(runtimeType,_this.activeLearners,_this.nursing,_this.physicians,_this.avgCompletionPct,_this.avgCompletionDeltaPts,_this.deltaComparedTo,_this.certsExpiringWithin90Days);
}

@override
String toString() {
  final _this = this as CohortKpis;
  return 'CohortKpis(activeLearners: ${_this.activeLearners}, nursing: ${_this.nursing}, physicians: ${_this.physicians}, avgCompletionPct: ${_this.avgCompletionPct}, avgCompletionDeltaPts: ${_this.avgCompletionDeltaPts}, deltaComparedTo: ${_this.deltaComparedTo}, certsExpiringWithin90Days: ${_this.certsExpiringWithin90Days})';
}


}

/// @nodoc
abstract mixin class $CohortKpisCopyWith<$Res>  {
  factory $CohortKpisCopyWith(CohortKpis value, $Res Function(CohortKpis) _then) = _$CohortKpisCopyWithImpl;
@useResult
$Res call({
 int activeLearners, int nursing, int physicians, int avgCompletionPct, int avgCompletionDeltaPts, LocalizedText deltaComparedTo, int certsExpiringWithin90Days
});


$LocalizedTextCopyWith<$Res> get deltaComparedTo;

}
/// @nodoc
class _$CohortKpisCopyWithImpl<$Res>
    implements $CohortKpisCopyWith<$Res> {
  _$CohortKpisCopyWithImpl(this._self, this._then);

  final CohortKpis _self;
  final $Res Function(CohortKpis) _then;

/// Create a copy of CohortKpis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeLearners = null,Object? nursing = null,Object? physicians = null,Object? avgCompletionPct = null,Object? avgCompletionDeltaPts = null,Object? deltaComparedTo = null,Object? certsExpiringWithin90Days = null,}) {
  return _then(CohortKpis(
activeLearners: null == activeLearners ? _self.activeLearners : activeLearners // ignore: cast_nullable_to_non_nullable
as int,nursing: null == nursing ? _self.nursing : nursing // ignore: cast_nullable_to_non_nullable
as int,physicians: null == physicians ? _self.physicians : physicians // ignore: cast_nullable_to_non_nullable
as int,avgCompletionPct: null == avgCompletionPct ? _self.avgCompletionPct : avgCompletionPct // ignore: cast_nullable_to_non_nullable
as int,avgCompletionDeltaPts: null == avgCompletionDeltaPts ? _self.avgCompletionDeltaPts : avgCompletionDeltaPts // ignore: cast_nullable_to_non_nullable
as int,deltaComparedTo: null == deltaComparedTo ? _self.deltaComparedTo : deltaComparedTo // ignore: cast_nullable_to_non_nullable
as LocalizedText,certsExpiringWithin90Days: null == certsExpiringWithin90Days ? _self.certsExpiringWithin90Days : certsExpiringWithin90Days // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CohortKpis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get deltaComparedTo {
  
  return $LocalizedTextCopyWith<$Res>(_self.deltaComparedTo, (value) {
    return _then(_self.copyWith(deltaComparedTo: value));
  });
}
}


/// Adds pattern-matching-related methods to [CohortKpis].
extension CohortKpisPatterns on CohortKpis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CohortKpis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CohortKpis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CohortKpis value)  $default,){
final _that = this;
switch (_that) {
case _CohortKpis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CohortKpis value)?  $default,){
final _that = this;
switch (_that) {
case _CohortKpis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activeLearners,  int nursing,  int physicians,  int avgCompletionPct,  int avgCompletionDeltaPts,  LocalizedText deltaComparedTo,  int certsExpiringWithin90Days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CohortKpis() when $default != null:
return $default(_that.activeLearners,_that.nursing,_that.physicians,_that.avgCompletionPct,_that.avgCompletionDeltaPts,_that.deltaComparedTo,_that.certsExpiringWithin90Days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activeLearners,  int nursing,  int physicians,  int avgCompletionPct,  int avgCompletionDeltaPts,  LocalizedText deltaComparedTo,  int certsExpiringWithin90Days)  $default,) {final _that = this;
switch (_that) {
case _CohortKpis():
return $default(_that.activeLearners,_that.nursing,_that.physicians,_that.avgCompletionPct,_that.avgCompletionDeltaPts,_that.deltaComparedTo,_that.certsExpiringWithin90Days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activeLearners,  int nursing,  int physicians,  int avgCompletionPct,  int avgCompletionDeltaPts,  LocalizedText deltaComparedTo,  int certsExpiringWithin90Days)?  $default,) {final _that = this;
switch (_that) {
case _CohortKpis() when $default != null:
return $default(_that.activeLearners,_that.nursing,_that.physicians,_that.avgCompletionPct,_that.avgCompletionDeltaPts,_that.deltaComparedTo,_that.certsExpiringWithin90Days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CohortKpis implements CohortKpis {
  const _CohortKpis({required this.activeLearners, required this.nursing, required this.physicians, required this.avgCompletionPct, required this.avgCompletionDeltaPts, required this.deltaComparedTo, required this.certsExpiringWithin90Days});
  factory _CohortKpis.fromJson(Map<String, dynamic> json) => _$CohortKpisFromJson(json);

@override final  int activeLearners;
@override final  int nursing;
@override final  int physicians;
@override final  int avgCompletionPct;
@override final  int avgCompletionDeltaPts;
@override final  LocalizedText deltaComparedTo;
@override final  int certsExpiringWithin90Days;

/// Create a copy of CohortKpis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CohortKpisCopyWith<_CohortKpis> get copyWith => __$CohortKpisCopyWithImpl<_CohortKpis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CohortKpisToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CohortKpis&&(identical(other.activeLearners, activeLearners) || other.activeLearners == activeLearners)&&(identical(other.nursing, nursing) || other.nursing == nursing)&&(identical(other.physicians, physicians) || other.physicians == physicians)&&(identical(other.avgCompletionPct, avgCompletionPct) || other.avgCompletionPct == avgCompletionPct)&&(identical(other.avgCompletionDeltaPts, avgCompletionDeltaPts) || other.avgCompletionDeltaPts == avgCompletionDeltaPts)&&(identical(other.deltaComparedTo, deltaComparedTo) || other.deltaComparedTo == deltaComparedTo)&&(identical(other.certsExpiringWithin90Days, certsExpiringWithin90Days) || other.certsExpiringWithin90Days == certsExpiringWithin90Days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,activeLearners,nursing,physicians,avgCompletionPct,avgCompletionDeltaPts,deltaComparedTo,certsExpiringWithin90Days);
}

@override
String toString() {
    return 'CohortKpis(activeLearners: $activeLearners, nursing: $nursing, physicians: $physicians, avgCompletionPct: $avgCompletionPct, avgCompletionDeltaPts: $avgCompletionDeltaPts, deltaComparedTo: $deltaComparedTo, certsExpiringWithin90Days: $certsExpiringWithin90Days)';
}


}

/// @nodoc
abstract mixin class _$CohortKpisCopyWith<$Res> implements $CohortKpisCopyWith<$Res> {
  factory _$CohortKpisCopyWith(_CohortKpis value, $Res Function(_CohortKpis) _then) = __$CohortKpisCopyWithImpl;
@override @useResult
$Res call({
 int activeLearners, int nursing, int physicians, int avgCompletionPct, int avgCompletionDeltaPts, LocalizedText deltaComparedTo, int certsExpiringWithin90Days
});


@override $LocalizedTextCopyWith<$Res> get deltaComparedTo;

}
/// @nodoc
class __$CohortKpisCopyWithImpl<$Res>
    implements _$CohortKpisCopyWith<$Res> {
  __$CohortKpisCopyWithImpl(this._self, this._then);

  final _CohortKpis _self;
  final $Res Function(_CohortKpis) _then;

/// Create a copy of CohortKpis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeLearners = null,Object? nursing = null,Object? physicians = null,Object? avgCompletionPct = null,Object? avgCompletionDeltaPts = null,Object? deltaComparedTo = null,Object? certsExpiringWithin90Days = null,}) {
  return _then(_CohortKpis(
activeLearners: null == activeLearners ? _self.activeLearners : activeLearners // ignore: cast_nullable_to_non_nullable
as int,nursing: null == nursing ? _self.nursing : nursing // ignore: cast_nullable_to_non_nullable
as int,physicians: null == physicians ? _self.physicians : physicians // ignore: cast_nullable_to_non_nullable
as int,avgCompletionPct: null == avgCompletionPct ? _self.avgCompletionPct : avgCompletionPct // ignore: cast_nullable_to_non_nullable
as int,avgCompletionDeltaPts: null == avgCompletionDeltaPts ? _self.avgCompletionDeltaPts : avgCompletionDeltaPts // ignore: cast_nullable_to_non_nullable
as int,deltaComparedTo: null == deltaComparedTo ? _self.deltaComparedTo : deltaComparedTo // ignore: cast_nullable_to_non_nullable
as LocalizedText,certsExpiringWithin90Days: null == certsExpiringWithin90Days ? _self.certsExpiringWithin90Days : certsExpiringWithin90Days // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CohortKpis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get deltaComparedTo {
  
  return $LocalizedTextCopyWith<$Res>(_self.deltaComparedTo, (value) {
    return _then(_self.copyWith(deltaComparedTo: value));
  });
}
}


/// @nodoc
mixin _$CoursePct {

 String get courseId; int get pct; int? get attempts;
/// Create a copy of CoursePct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoursePctCopyWith<CoursePct> get copyWith => _$CoursePctCopyWithImpl<CoursePct>(this as CoursePct, _$identity);

  /// Serializes this CoursePct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CoursePct;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursePct&&(identical(other.courseId, _this.courseId) || other.courseId == _this.courseId)&&(identical(other.pct, _this.pct) || other.pct == _this.pct)&&(identical(other.attempts, _this.attempts) || other.attempts == _this.attempts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CoursePct;
  return Object.hash(runtimeType,_this.courseId,_this.pct,_this.attempts);
}

@override
String toString() {
  final _this = this as CoursePct;
  return 'CoursePct(courseId: ${_this.courseId}, pct: ${_this.pct}, attempts: ${_this.attempts})';
}


}

/// @nodoc
abstract mixin class $CoursePctCopyWith<$Res>  {
  factory $CoursePctCopyWith(CoursePct value, $Res Function(CoursePct) _then) = _$CoursePctCopyWithImpl;
@useResult
$Res call({
 String courseId, int pct, int? attempts
});




}
/// @nodoc
class _$CoursePctCopyWithImpl<$Res>
    implements $CoursePctCopyWith<$Res> {
  _$CoursePctCopyWithImpl(this._self, this._then);

  final CoursePct _self;
  final $Res Function(CoursePct) _then;

/// Create a copy of CoursePct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseId = null,Object? pct = null,Object? attempts = freezed,}) {
  return _then(CoursePct(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,pct: null == pct ? _self.pct : pct // ignore: cast_nullable_to_non_nullable
as int,attempts: freezed == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoursePct].
extension CoursePctPatterns on CoursePct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoursePct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoursePct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoursePct value)  $default,){
final _that = this;
switch (_that) {
case _CoursePct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoursePct value)?  $default,){
final _that = this;
switch (_that) {
case _CoursePct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseId,  int pct,  int? attempts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoursePct() when $default != null:
return $default(_that.courseId,_that.pct,_that.attempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseId,  int pct,  int? attempts)  $default,) {final _that = this;
switch (_that) {
case _CoursePct():
return $default(_that.courseId,_that.pct,_that.attempts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseId,  int pct,  int? attempts)?  $default,) {final _that = this;
switch (_that) {
case _CoursePct() when $default != null:
return $default(_that.courseId,_that.pct,_that.attempts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoursePct implements CoursePct {
  const _CoursePct({required this.courseId, required this.pct, this.attempts});
  factory _CoursePct.fromJson(Map<String, dynamic> json) => _$CoursePctFromJson(json);

@override final  String courseId;
@override final  int pct;
@override final  int? attempts;

/// Create a copy of CoursePct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoursePctCopyWith<_CoursePct> get copyWith => __$CoursePctCopyWithImpl<_CoursePct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoursePctToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoursePct&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.pct, pct) || other.pct == pct)&&(identical(other.attempts, attempts) || other.attempts == attempts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,courseId,pct,attempts);
}

@override
String toString() {
    return 'CoursePct(courseId: $courseId, pct: $pct, attempts: $attempts)';
}


}

/// @nodoc
abstract mixin class _$CoursePctCopyWith<$Res> implements $CoursePctCopyWith<$Res> {
  factory _$CoursePctCopyWith(_CoursePct value, $Res Function(_CoursePct) _then) = __$CoursePctCopyWithImpl;
@override @useResult
$Res call({
 String courseId, int pct, int? attempts
});




}
/// @nodoc
class __$CoursePctCopyWithImpl<$Res>
    implements _$CoursePctCopyWith<$Res> {
  __$CoursePctCopyWithImpl(this._self, this._then);

  final _CoursePct _self;
  final $Res Function(_CoursePct) _then;

/// Create a copy of CoursePct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseId = null,Object? pct = null,Object? attempts = freezed,}) {
  return _then(_CoursePct(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,pct: null == pct ? _self.pct : pct // ignore: cast_nullable_to_non_nullable
as int,attempts: freezed == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DepartmentPct {

 String get departmentId; int get pct;
/// Create a copy of DepartmentPct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartmentPctCopyWith<DepartmentPct> get copyWith => _$DepartmentPctCopyWithImpl<DepartmentPct>(this as DepartmentPct, _$identity);

  /// Serializes this DepartmentPct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DepartmentPct;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartmentPct&&(identical(other.departmentId, _this.departmentId) || other.departmentId == _this.departmentId)&&(identical(other.pct, _this.pct) || other.pct == _this.pct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DepartmentPct;
  return Object.hash(runtimeType,_this.departmentId,_this.pct);
}

@override
String toString() {
  final _this = this as DepartmentPct;
  return 'DepartmentPct(departmentId: ${_this.departmentId}, pct: ${_this.pct})';
}


}

/// @nodoc
abstract mixin class $DepartmentPctCopyWith<$Res>  {
  factory $DepartmentPctCopyWith(DepartmentPct value, $Res Function(DepartmentPct) _then) = _$DepartmentPctCopyWithImpl;
@useResult
$Res call({
 String departmentId, int pct
});




}
/// @nodoc
class _$DepartmentPctCopyWithImpl<$Res>
    implements $DepartmentPctCopyWith<$Res> {
  _$DepartmentPctCopyWithImpl(this._self, this._then);

  final DepartmentPct _self;
  final $Res Function(DepartmentPct) _then;

/// Create a copy of DepartmentPct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? departmentId = null,Object? pct = null,}) {
  return _then(DepartmentPct(
departmentId: null == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String,pct: null == pct ? _self.pct : pct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DepartmentPct].
extension DepartmentPctPatterns on DepartmentPct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DepartmentPct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DepartmentPct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DepartmentPct value)  $default,){
final _that = this;
switch (_that) {
case _DepartmentPct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DepartmentPct value)?  $default,){
final _that = this;
switch (_that) {
case _DepartmentPct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String departmentId,  int pct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DepartmentPct() when $default != null:
return $default(_that.departmentId,_that.pct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String departmentId,  int pct)  $default,) {final _that = this;
switch (_that) {
case _DepartmentPct():
return $default(_that.departmentId,_that.pct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String departmentId,  int pct)?  $default,) {final _that = this;
switch (_that) {
case _DepartmentPct() when $default != null:
return $default(_that.departmentId,_that.pct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DepartmentPct implements DepartmentPct {
  const _DepartmentPct({required this.departmentId, required this.pct});
  factory _DepartmentPct.fromJson(Map<String, dynamic> json) => _$DepartmentPctFromJson(json);

@override final  String departmentId;
@override final  int pct;

/// Create a copy of DepartmentPct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartmentPctCopyWith<_DepartmentPct> get copyWith => __$DepartmentPctCopyWithImpl<_DepartmentPct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepartmentPctToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepartmentPct&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.pct, pct) || other.pct == pct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,departmentId,pct);
}

@override
String toString() {
    return 'DepartmentPct(departmentId: $departmentId, pct: $pct)';
}


}

/// @nodoc
abstract mixin class _$DepartmentPctCopyWith<$Res> implements $DepartmentPctCopyWith<$Res> {
  factory _$DepartmentPctCopyWith(_DepartmentPct value, $Res Function(_DepartmentPct) _then) = __$DepartmentPctCopyWithImpl;
@override @useResult
$Res call({
 String departmentId, int pct
});




}
/// @nodoc
class __$DepartmentPctCopyWithImpl<$Res>
    implements _$DepartmentPctCopyWith<$Res> {
  __$DepartmentPctCopyWithImpl(this._self, this._then);

  final _DepartmentPct _self;
  final $Res Function(_DepartmentPct) _then;

/// Create a copy of DepartmentPct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? departmentId = null,Object? pct = null,}) {
  return _then(_DepartmentPct(
departmentId: null == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String,pct: null == pct ? _self.pct : pct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MonthCount {

 String get month; int get count;
/// Create a copy of MonthCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthCountCopyWith<MonthCount> get copyWith => _$MonthCountCopyWithImpl<MonthCount>(this as MonthCount, _$identity);

  /// Serializes this MonthCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MonthCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthCount&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MonthCount;
  return Object.hash(runtimeType,_this.month,_this.count);
}

@override
String toString() {
  final _this = this as MonthCount;
  return 'MonthCount(month: ${_this.month}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $MonthCountCopyWith<$Res>  {
  factory $MonthCountCopyWith(MonthCount value, $Res Function(MonthCount) _then) = _$MonthCountCopyWithImpl;
@useResult
$Res call({
 String month, int count
});




}
/// @nodoc
class _$MonthCountCopyWithImpl<$Res>
    implements $MonthCountCopyWith<$Res> {
  _$MonthCountCopyWithImpl(this._self, this._then);

  final MonthCount _self;
  final $Res Function(MonthCount) _then;

/// Create a copy of MonthCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? count = null,}) {
  return _then(MonthCount(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthCount].
extension MonthCountPatterns on MonthCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthCount value)  $default,){
final _that = this;
switch (_that) {
case _MonthCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthCount value)?  $default,){
final _that = this;
switch (_that) {
case _MonthCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthCount() when $default != null:
return $default(_that.month,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  int count)  $default,) {final _that = this;
switch (_that) {
case _MonthCount():
return $default(_that.month,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  int count)?  $default,) {final _that = this;
switch (_that) {
case _MonthCount() when $default != null:
return $default(_that.month,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthCount implements MonthCount {
  const _MonthCount({required this.month, required this.count});
  factory _MonthCount.fromJson(Map<String, dynamic> json) => _$MonthCountFromJson(json);

@override final  String month;
@override final  int count;

/// Create a copy of MonthCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthCountCopyWith<_MonthCount> get copyWith => __$MonthCountCopyWithImpl<_MonthCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthCountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthCount&&(identical(other.month, month) || other.month == month)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,month,count);
}

@override
String toString() {
    return 'MonthCount(month: $month, count: $count)';
}


}

/// @nodoc
abstract mixin class _$MonthCountCopyWith<$Res> implements $MonthCountCopyWith<$Res> {
  factory _$MonthCountCopyWith(_MonthCount value, $Res Function(_MonthCount) _then) = __$MonthCountCopyWithImpl;
@override @useResult
$Res call({
 String month, int count
});




}
/// @nodoc
class __$MonthCountCopyWithImpl<$Res>
    implements _$MonthCountCopyWith<$Res> {
  __$MonthCountCopyWithImpl(this._self, this._then);

  final _MonthCount _self;
  final $Res Function(_MonthCount) _then;

/// Create a copy of MonthCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? count = null,}) {
  return _then(_MonthCount(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CohortLearner {

 String get userId; int get completionPct; int get certsExpiringSoon;
/// Create a copy of CohortLearner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CohortLearnerCopyWith<CohortLearner> get copyWith => _$CohortLearnerCopyWithImpl<CohortLearner>(this as CohortLearner, _$identity);

  /// Serializes this CohortLearner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CohortLearner;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CohortLearner&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.completionPct, _this.completionPct) || other.completionPct == _this.completionPct)&&(identical(other.certsExpiringSoon, _this.certsExpiringSoon) || other.certsExpiringSoon == _this.certsExpiringSoon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CohortLearner;
  return Object.hash(runtimeType,_this.userId,_this.completionPct,_this.certsExpiringSoon);
}

@override
String toString() {
  final _this = this as CohortLearner;
  return 'CohortLearner(userId: ${_this.userId}, completionPct: ${_this.completionPct}, certsExpiringSoon: ${_this.certsExpiringSoon})';
}


}

/// @nodoc
abstract mixin class $CohortLearnerCopyWith<$Res>  {
  factory $CohortLearnerCopyWith(CohortLearner value, $Res Function(CohortLearner) _then) = _$CohortLearnerCopyWithImpl;
@useResult
$Res call({
 String userId, int completionPct, int certsExpiringSoon
});




}
/// @nodoc
class _$CohortLearnerCopyWithImpl<$Res>
    implements $CohortLearnerCopyWith<$Res> {
  _$CohortLearnerCopyWithImpl(this._self, this._then);

  final CohortLearner _self;
  final $Res Function(CohortLearner) _then;

/// Create a copy of CohortLearner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? completionPct = null,Object? certsExpiringSoon = null,}) {
  return _then(CohortLearner(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,completionPct: null == completionPct ? _self.completionPct : completionPct // ignore: cast_nullable_to_non_nullable
as int,certsExpiringSoon: null == certsExpiringSoon ? _self.certsExpiringSoon : certsExpiringSoon // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CohortLearner].
extension CohortLearnerPatterns on CohortLearner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CohortLearner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CohortLearner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CohortLearner value)  $default,){
final _that = this;
switch (_that) {
case _CohortLearner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CohortLearner value)?  $default,){
final _that = this;
switch (_that) {
case _CohortLearner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int completionPct,  int certsExpiringSoon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CohortLearner() when $default != null:
return $default(_that.userId,_that.completionPct,_that.certsExpiringSoon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int completionPct,  int certsExpiringSoon)  $default,) {final _that = this;
switch (_that) {
case _CohortLearner():
return $default(_that.userId,_that.completionPct,_that.certsExpiringSoon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int completionPct,  int certsExpiringSoon)?  $default,) {final _that = this;
switch (_that) {
case _CohortLearner() when $default != null:
return $default(_that.userId,_that.completionPct,_that.certsExpiringSoon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CohortLearner implements CohortLearner {
  const _CohortLearner({required this.userId, required this.completionPct, required this.certsExpiringSoon});
  factory _CohortLearner.fromJson(Map<String, dynamic> json) => _$CohortLearnerFromJson(json);

@override final  String userId;
@override final  int completionPct;
@override final  int certsExpiringSoon;

/// Create a copy of CohortLearner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CohortLearnerCopyWith<_CohortLearner> get copyWith => __$CohortLearnerCopyWithImpl<_CohortLearner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CohortLearnerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CohortLearner&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.completionPct, completionPct) || other.completionPct == completionPct)&&(identical(other.certsExpiringSoon, certsExpiringSoon) || other.certsExpiringSoon == certsExpiringSoon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,completionPct,certsExpiringSoon);
}

@override
String toString() {
    return 'CohortLearner(userId: $userId, completionPct: $completionPct, certsExpiringSoon: $certsExpiringSoon)';
}


}

/// @nodoc
abstract mixin class _$CohortLearnerCopyWith<$Res> implements $CohortLearnerCopyWith<$Res> {
  factory _$CohortLearnerCopyWith(_CohortLearner value, $Res Function(_CohortLearner) _then) = __$CohortLearnerCopyWithImpl;
@override @useResult
$Res call({
 String userId, int completionPct, int certsExpiringSoon
});




}
/// @nodoc
class __$CohortLearnerCopyWithImpl<$Res>
    implements _$CohortLearnerCopyWith<$Res> {
  __$CohortLearnerCopyWithImpl(this._self, this._then);

  final _CohortLearner _self;
  final $Res Function(_CohortLearner) _then;

/// Create a copy of CohortLearner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? completionPct = null,Object? certsExpiringSoon = null,}) {
  return _then(_CohortLearner(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,completionPct: null == completionPct ? _self.completionPct : completionPct // ignore: cast_nullable_to_non_nullable
as int,certsExpiringSoon: null == certsExpiringSoon ? _self.certsExpiringSoon : certsExpiringSoon // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UsageInsights {

 List<CourseViews> get lessonViewsByCourse; DropOff get dropOff; List<CoursePct> get firstAttemptPassRates; List<PlatformPct> get sessionsByPlatform;
/// Create a copy of UsageInsights
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsageInsightsCopyWith<UsageInsights> get copyWith => _$UsageInsightsCopyWithImpl<UsageInsights>(this as UsageInsights, _$identity);

  /// Serializes this UsageInsights to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UsageInsights;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsageInsights&&const DeepCollectionEquality().equals(other.lessonViewsByCourse, _this.lessonViewsByCourse)&&(identical(other.dropOff, _this.dropOff) || other.dropOff == _this.dropOff)&&const DeepCollectionEquality().equals(other.firstAttemptPassRates, _this.firstAttemptPassRates)&&const DeepCollectionEquality().equals(other.sessionsByPlatform, _this.sessionsByPlatform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UsageInsights;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.lessonViewsByCourse),_this.dropOff,const DeepCollectionEquality().hash(_this.firstAttemptPassRates),const DeepCollectionEquality().hash(_this.sessionsByPlatform));
}

@override
String toString() {
  final _this = this as UsageInsights;
  return 'UsageInsights(lessonViewsByCourse: ${_this.lessonViewsByCourse}, dropOff: ${_this.dropOff}, firstAttemptPassRates: ${_this.firstAttemptPassRates}, sessionsByPlatform: ${_this.sessionsByPlatform})';
}


}

/// @nodoc
abstract mixin class $UsageInsightsCopyWith<$Res>  {
  factory $UsageInsightsCopyWith(UsageInsights value, $Res Function(UsageInsights) _then) = _$UsageInsightsCopyWithImpl;
@useResult
$Res call({
 List<CourseViews> lessonViewsByCourse, DropOff dropOff, List<CoursePct> firstAttemptPassRates, List<PlatformPct> sessionsByPlatform
});


$DropOffCopyWith<$Res> get dropOff;

}
/// @nodoc
class _$UsageInsightsCopyWithImpl<$Res>
    implements $UsageInsightsCopyWith<$Res> {
  _$UsageInsightsCopyWithImpl(this._self, this._then);

  final UsageInsights _self;
  final $Res Function(UsageInsights) _then;

/// Create a copy of UsageInsights
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lessonViewsByCourse = null,Object? dropOff = null,Object? firstAttemptPassRates = null,Object? sessionsByPlatform = null,}) {
  return _then(UsageInsights(
lessonViewsByCourse: null == lessonViewsByCourse ? _self.lessonViewsByCourse : lessonViewsByCourse // ignore: cast_nullable_to_non_nullable
as List<CourseViews>,dropOff: null == dropOff ? _self.dropOff : dropOff // ignore: cast_nullable_to_non_nullable
as DropOff,firstAttemptPassRates: null == firstAttemptPassRates ? _self.firstAttemptPassRates : firstAttemptPassRates // ignore: cast_nullable_to_non_nullable
as List<CoursePct>,sessionsByPlatform: null == sessionsByPlatform ? _self.sessionsByPlatform : sessionsByPlatform // ignore: cast_nullable_to_non_nullable
as List<PlatformPct>,
  ));
}
/// Create a copy of UsageInsights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DropOffCopyWith<$Res> get dropOff {
  
  return $DropOffCopyWith<$Res>(_self.dropOff, (value) {
    return _then(_self.copyWith(dropOff: value));
  });
}
}


/// Adds pattern-matching-related methods to [UsageInsights].
extension UsageInsightsPatterns on UsageInsights {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsageInsights value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsageInsights() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsageInsights value)  $default,){
final _that = this;
switch (_that) {
case _UsageInsights():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsageInsights value)?  $default,){
final _that = this;
switch (_that) {
case _UsageInsights() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CourseViews> lessonViewsByCourse,  DropOff dropOff,  List<CoursePct> firstAttemptPassRates,  List<PlatformPct> sessionsByPlatform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsageInsights() when $default != null:
return $default(_that.lessonViewsByCourse,_that.dropOff,_that.firstAttemptPassRates,_that.sessionsByPlatform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CourseViews> lessonViewsByCourse,  DropOff dropOff,  List<CoursePct> firstAttemptPassRates,  List<PlatformPct> sessionsByPlatform)  $default,) {final _that = this;
switch (_that) {
case _UsageInsights():
return $default(_that.lessonViewsByCourse,_that.dropOff,_that.firstAttemptPassRates,_that.sessionsByPlatform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CourseViews> lessonViewsByCourse,  DropOff dropOff,  List<CoursePct> firstAttemptPassRates,  List<PlatformPct> sessionsByPlatform)?  $default,) {final _that = this;
switch (_that) {
case _UsageInsights() when $default != null:
return $default(_that.lessonViewsByCourse,_that.dropOff,_that.firstAttemptPassRates,_that.sessionsByPlatform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsageInsights implements UsageInsights {
  const _UsageInsights({required  List<CourseViews> lessonViewsByCourse, required this.dropOff, required  List<CoursePct> firstAttemptPassRates, required  List<PlatformPct> sessionsByPlatform}): _lessonViewsByCourse = lessonViewsByCourse,_firstAttemptPassRates = firstAttemptPassRates,_sessionsByPlatform = sessionsByPlatform;
  factory _UsageInsights.fromJson(Map<String, dynamic> json) => _$UsageInsightsFromJson(json);

 final  List<CourseViews> _lessonViewsByCourse;
@override List<CourseViews> get lessonViewsByCourse {
  if (_lessonViewsByCourse is EqualUnmodifiableListView) return _lessonViewsByCourse;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessonViewsByCourse);
}

@override final  DropOff dropOff;
 final  List<CoursePct> _firstAttemptPassRates;
@override List<CoursePct> get firstAttemptPassRates {
  if (_firstAttemptPassRates is EqualUnmodifiableListView) return _firstAttemptPassRates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_firstAttemptPassRates);
}

 final  List<PlatformPct> _sessionsByPlatform;
@override List<PlatformPct> get sessionsByPlatform {
  if (_sessionsByPlatform is EqualUnmodifiableListView) return _sessionsByPlatform;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessionsByPlatform);
}


/// Create a copy of UsageInsights
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsageInsightsCopyWith<_UsageInsights> get copyWith => __$UsageInsightsCopyWithImpl<_UsageInsights>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsageInsightsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsageInsights&&const DeepCollectionEquality().equals(other.lessonViewsByCourse, _lessonViewsByCourse)&&(identical(other.dropOff, dropOff) || other.dropOff == dropOff)&&const DeepCollectionEquality().equals(other.firstAttemptPassRates, _firstAttemptPassRates)&&const DeepCollectionEquality().equals(other.sessionsByPlatform, _sessionsByPlatform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_lessonViewsByCourse),dropOff,const DeepCollectionEquality().hash(_firstAttemptPassRates),const DeepCollectionEquality().hash(_sessionsByPlatform));
}

@override
String toString() {
    return 'UsageInsights(lessonViewsByCourse: $lessonViewsByCourse, dropOff: $dropOff, firstAttemptPassRates: $firstAttemptPassRates, sessionsByPlatform: $sessionsByPlatform)';
}


}

/// @nodoc
abstract mixin class _$UsageInsightsCopyWith<$Res> implements $UsageInsightsCopyWith<$Res> {
  factory _$UsageInsightsCopyWith(_UsageInsights value, $Res Function(_UsageInsights) _then) = __$UsageInsightsCopyWithImpl;
@override @useResult
$Res call({
 List<CourseViews> lessonViewsByCourse, DropOff dropOff, List<CoursePct> firstAttemptPassRates, List<PlatformPct> sessionsByPlatform
});


@override $DropOffCopyWith<$Res> get dropOff;

}
/// @nodoc
class __$UsageInsightsCopyWithImpl<$Res>
    implements _$UsageInsightsCopyWith<$Res> {
  __$UsageInsightsCopyWithImpl(this._self, this._then);

  final _UsageInsights _self;
  final $Res Function(_UsageInsights) _then;

/// Create a copy of UsageInsights
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lessonViewsByCourse = null,Object? dropOff = null,Object? firstAttemptPassRates = null,Object? sessionsByPlatform = null,}) {
  return _then(_UsageInsights(
lessonViewsByCourse: null == lessonViewsByCourse ? _self._lessonViewsByCourse : lessonViewsByCourse // ignore: cast_nullable_to_non_nullable
as List<CourseViews>,dropOff: null == dropOff ? _self.dropOff : dropOff // ignore: cast_nullable_to_non_nullable
as DropOff,firstAttemptPassRates: null == firstAttemptPassRates ? _self._firstAttemptPassRates : firstAttemptPassRates // ignore: cast_nullable_to_non_nullable
as List<CoursePct>,sessionsByPlatform: null == sessionsByPlatform ? _self._sessionsByPlatform : sessionsByPlatform // ignore: cast_nullable_to_non_nullable
as List<PlatformPct>,
  ));
}

/// Create a copy of UsageInsights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DropOffCopyWith<$Res> get dropOff {
  
  return $DropOffCopyWith<$Res>(_self.dropOff, (value) {
    return _then(_self.copyWith(dropOff: value));
  });
}
}


/// @nodoc
mixin _$CourseViews {

 String get courseId; int get views;
/// Create a copy of CourseViews
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseViewsCopyWith<CourseViews> get copyWith => _$CourseViewsCopyWithImpl<CourseViews>(this as CourseViews, _$identity);

  /// Serializes this CourseViews to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CourseViews;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseViews&&(identical(other.courseId, _this.courseId) || other.courseId == _this.courseId)&&(identical(other.views, _this.views) || other.views == _this.views));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CourseViews;
  return Object.hash(runtimeType,_this.courseId,_this.views);
}

@override
String toString() {
  final _this = this as CourseViews;
  return 'CourseViews(courseId: ${_this.courseId}, views: ${_this.views})';
}


}

/// @nodoc
abstract mixin class $CourseViewsCopyWith<$Res>  {
  factory $CourseViewsCopyWith(CourseViews value, $Res Function(CourseViews) _then) = _$CourseViewsCopyWithImpl;
@useResult
$Res call({
 String courseId, int views
});




}
/// @nodoc
class _$CourseViewsCopyWithImpl<$Res>
    implements $CourseViewsCopyWith<$Res> {
  _$CourseViewsCopyWithImpl(this._self, this._then);

  final CourseViews _self;
  final $Res Function(CourseViews) _then;

/// Create a copy of CourseViews
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseId = null,Object? views = null,}) {
  return _then(CourseViews(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseViews].
extension CourseViewsPatterns on CourseViews {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseViews value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseViews() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseViews value)  $default,){
final _that = this;
switch (_that) {
case _CourseViews():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseViews value)?  $default,){
final _that = this;
switch (_that) {
case _CourseViews() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseId,  int views)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseViews() when $default != null:
return $default(_that.courseId,_that.views);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseId,  int views)  $default,) {final _that = this;
switch (_that) {
case _CourseViews():
return $default(_that.courseId,_that.views);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseId,  int views)?  $default,) {final _that = this;
switch (_that) {
case _CourseViews() when $default != null:
return $default(_that.courseId,_that.views);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseViews implements CourseViews {
  const _CourseViews({required this.courseId, required this.views});
  factory _CourseViews.fromJson(Map<String, dynamic> json) => _$CourseViewsFromJson(json);

@override final  String courseId;
@override final  int views;

/// Create a copy of CourseViews
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseViewsCopyWith<_CourseViews> get copyWith => __$CourseViewsCopyWithImpl<_CourseViews>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseViewsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseViews&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.views, views) || other.views == views));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,courseId,views);
}

@override
String toString() {
    return 'CourseViews(courseId: $courseId, views: $views)';
}


}

/// @nodoc
abstract mixin class _$CourseViewsCopyWith<$Res> implements $CourseViewsCopyWith<$Res> {
  factory _$CourseViewsCopyWith(_CourseViews value, $Res Function(_CourseViews) _then) = __$CourseViewsCopyWithImpl;
@override @useResult
$Res call({
 String courseId, int views
});




}
/// @nodoc
class __$CourseViewsCopyWithImpl<$Res>
    implements _$CourseViewsCopyWith<$Res> {
  __$CourseViewsCopyWithImpl(this._self, this._then);

  final _CourseViews _self;
  final $Res Function(_CourseViews) _then;

/// Create a copy of CourseViews
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseId = null,Object? views = null,}) {
  return _then(_CourseViews(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DropOff {

 String get courseId; List<int> get retainedPctByLesson;
/// Create a copy of DropOff
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DropOffCopyWith<DropOff> get copyWith => _$DropOffCopyWithImpl<DropOff>(this as DropOff, _$identity);

  /// Serializes this DropOff to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DropOff;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DropOff&&(identical(other.courseId, _this.courseId) || other.courseId == _this.courseId)&&const DeepCollectionEquality().equals(other.retainedPctByLesson, _this.retainedPctByLesson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DropOff;
  return Object.hash(runtimeType,_this.courseId,const DeepCollectionEquality().hash(_this.retainedPctByLesson));
}

@override
String toString() {
  final _this = this as DropOff;
  return 'DropOff(courseId: ${_this.courseId}, retainedPctByLesson: ${_this.retainedPctByLesson})';
}


}

/// @nodoc
abstract mixin class $DropOffCopyWith<$Res>  {
  factory $DropOffCopyWith(DropOff value, $Res Function(DropOff) _then) = _$DropOffCopyWithImpl;
@useResult
$Res call({
 String courseId, List<int> retainedPctByLesson
});




}
/// @nodoc
class _$DropOffCopyWithImpl<$Res>
    implements $DropOffCopyWith<$Res> {
  _$DropOffCopyWithImpl(this._self, this._then);

  final DropOff _self;
  final $Res Function(DropOff) _then;

/// Create a copy of DropOff
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseId = null,Object? retainedPctByLesson = null,}) {
  return _then(DropOff(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,retainedPctByLesson: null == retainedPctByLesson ? _self.retainedPctByLesson : retainedPctByLesson // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [DropOff].
extension DropOffPatterns on DropOff {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DropOff value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DropOff() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DropOff value)  $default,){
final _that = this;
switch (_that) {
case _DropOff():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DropOff value)?  $default,){
final _that = this;
switch (_that) {
case _DropOff() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseId,  List<int> retainedPctByLesson)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DropOff() when $default != null:
return $default(_that.courseId,_that.retainedPctByLesson);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseId,  List<int> retainedPctByLesson)  $default,) {final _that = this;
switch (_that) {
case _DropOff():
return $default(_that.courseId,_that.retainedPctByLesson);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseId,  List<int> retainedPctByLesson)?  $default,) {final _that = this;
switch (_that) {
case _DropOff() when $default != null:
return $default(_that.courseId,_that.retainedPctByLesson);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DropOff implements DropOff {
  const _DropOff({required this.courseId, required  List<int> retainedPctByLesson}): _retainedPctByLesson = retainedPctByLesson;
  factory _DropOff.fromJson(Map<String, dynamic> json) => _$DropOffFromJson(json);

@override final  String courseId;
 final  List<int> _retainedPctByLesson;
@override List<int> get retainedPctByLesson {
  if (_retainedPctByLesson is EqualUnmodifiableListView) return _retainedPctByLesson;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_retainedPctByLesson);
}


/// Create a copy of DropOff
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DropOffCopyWith<_DropOff> get copyWith => __$DropOffCopyWithImpl<_DropOff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DropOffToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DropOff&&(identical(other.courseId, courseId) || other.courseId == courseId)&&const DeepCollectionEquality().equals(other.retainedPctByLesson, _retainedPctByLesson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,courseId,const DeepCollectionEquality().hash(_retainedPctByLesson));
}

@override
String toString() {
    return 'DropOff(courseId: $courseId, retainedPctByLesson: $retainedPctByLesson)';
}


}

/// @nodoc
abstract mixin class _$DropOffCopyWith<$Res> implements $DropOffCopyWith<$Res> {
  factory _$DropOffCopyWith(_DropOff value, $Res Function(_DropOff) _then) = __$DropOffCopyWithImpl;
@override @useResult
$Res call({
 String courseId, List<int> retainedPctByLesson
});




}
/// @nodoc
class __$DropOffCopyWithImpl<$Res>
    implements _$DropOffCopyWith<$Res> {
  __$DropOffCopyWithImpl(this._self, this._then);

  final _DropOff _self;
  final $Res Function(_DropOff) _then;

/// Create a copy of DropOff
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseId = null,Object? retainedPctByLesson = null,}) {
  return _then(_DropOff(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,retainedPctByLesson: null == retainedPctByLesson ? _self._retainedPctByLesson : retainedPctByLesson // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$PlatformPct {

 String get platform; int get pct;
/// Create a copy of PlatformPct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformPctCopyWith<PlatformPct> get copyWith => _$PlatformPctCopyWithImpl<PlatformPct>(this as PlatformPct, _$identity);

  /// Serializes this PlatformPct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlatformPct;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformPct&&(identical(other.platform, _this.platform) || other.platform == _this.platform)&&(identical(other.pct, _this.pct) || other.pct == _this.pct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlatformPct;
  return Object.hash(runtimeType,_this.platform,_this.pct);
}

@override
String toString() {
  final _this = this as PlatformPct;
  return 'PlatformPct(platform: ${_this.platform}, pct: ${_this.pct})';
}


}

/// @nodoc
abstract mixin class $PlatformPctCopyWith<$Res>  {
  factory $PlatformPctCopyWith(PlatformPct value, $Res Function(PlatformPct) _then) = _$PlatformPctCopyWithImpl;
@useResult
$Res call({
 String platform, int pct
});




}
/// @nodoc
class _$PlatformPctCopyWithImpl<$Res>
    implements $PlatformPctCopyWith<$Res> {
  _$PlatformPctCopyWithImpl(this._self, this._then);

  final PlatformPct _self;
  final $Res Function(PlatformPct) _then;

/// Create a copy of PlatformPct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platform = null,Object? pct = null,}) {
  return _then(PlatformPct(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,pct: null == pct ? _self.pct : pct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformPct].
extension PlatformPctPatterns on PlatformPct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformPct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformPct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformPct value)  $default,){
final _that = this;
switch (_that) {
case _PlatformPct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformPct value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformPct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String platform,  int pct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformPct() when $default != null:
return $default(_that.platform,_that.pct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String platform,  int pct)  $default,) {final _that = this;
switch (_that) {
case _PlatformPct():
return $default(_that.platform,_that.pct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String platform,  int pct)?  $default,) {final _that = this;
switch (_that) {
case _PlatformPct() when $default != null:
return $default(_that.platform,_that.pct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformPct implements PlatformPct {
  const _PlatformPct({required this.platform, required this.pct});
  factory _PlatformPct.fromJson(Map<String, dynamic> json) => _$PlatformPctFromJson(json);

@override final  String platform;
@override final  int pct;

/// Create a copy of PlatformPct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformPctCopyWith<_PlatformPct> get copyWith => __$PlatformPctCopyWithImpl<_PlatformPct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformPctToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformPct&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.pct, pct) || other.pct == pct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,platform,pct);
}

@override
String toString() {
    return 'PlatformPct(platform: $platform, pct: $pct)';
}


}

/// @nodoc
abstract mixin class _$PlatformPctCopyWith<$Res> implements $PlatformPctCopyWith<$Res> {
  factory _$PlatformPctCopyWith(_PlatformPct value, $Res Function(_PlatformPct) _then) = __$PlatformPctCopyWithImpl;
@override @useResult
$Res call({
 String platform, int pct
});




}
/// @nodoc
class __$PlatformPctCopyWithImpl<$Res>
    implements _$PlatformPctCopyWith<$Res> {
  __$PlatformPctCopyWithImpl(this._self, this._then);

  final _PlatformPct _self;
  final $Res Function(_PlatformPct) _then;

/// Create a copy of PlatformPct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platform = null,Object? pct = null,}) {
  return _then(_PlatformPct(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,pct: null == pct ? _self.pct : pct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
