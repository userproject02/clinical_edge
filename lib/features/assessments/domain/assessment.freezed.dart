// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Question {

 String get id; String get bankId; String get topic; LocalizedText get prompt; List<LocalizedText> get options; int get correctIndex; LocalizedText get explanation; String get sourceGuideline;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Question;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bankId, _this.bankId) || other.bankId == _this.bankId)&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&const DeepCollectionEquality().equals(other.options, _this.options)&&(identical(other.correctIndex, _this.correctIndex) || other.correctIndex == _this.correctIndex)&&(identical(other.explanation, _this.explanation) || other.explanation == _this.explanation)&&(identical(other.sourceGuideline, _this.sourceGuideline) || other.sourceGuideline == _this.sourceGuideline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Question;
  return Object.hash(runtimeType,_this.id,_this.bankId,_this.topic,_this.prompt,const DeepCollectionEquality().hash(_this.options),_this.correctIndex,_this.explanation,_this.sourceGuideline);
}

@override
String toString() {
  final _this = this as Question;
  return 'Question(id: ${_this.id}, bankId: ${_this.bankId}, topic: ${_this.topic}, prompt: ${_this.prompt}, options: ${_this.options}, correctIndex: ${_this.correctIndex}, explanation: ${_this.explanation}, sourceGuideline: ${_this.sourceGuideline})';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String id, String bankId, String topic, LocalizedText prompt, List<LocalizedText> options, int correctIndex, LocalizedText explanation, String sourceGuideline
});


$LocalizedTextCopyWith<$Res> get prompt;$LocalizedTextCopyWith<$Res> get explanation;

}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bankId = null,Object? topic = null,Object? prompt = null,Object? options = null,Object? correctIndex = null,Object? explanation = null,Object? sourceGuideline = null,}) {
  return _then(Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bankId: null == bankId ? _self.bankId : bankId // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as LocalizedText,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as LocalizedText,sourceGuideline: null == sourceGuideline ? _self.sourceGuideline : sourceGuideline // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get prompt {
  
  return $LocalizedTextCopyWith<$Res>(_self.prompt, (value) {
    return _then(_self.copyWith(prompt: value));
  });
}/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get explanation {
  
  return $LocalizedTextCopyWith<$Res>(_self.explanation, (value) {
    return _then(_self.copyWith(explanation: value));
  });
}
}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bankId,  String topic,  LocalizedText prompt,  List<LocalizedText> options,  int correctIndex,  LocalizedText explanation,  String sourceGuideline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.bankId,_that.topic,_that.prompt,_that.options,_that.correctIndex,_that.explanation,_that.sourceGuideline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bankId,  String topic,  LocalizedText prompt,  List<LocalizedText> options,  int correctIndex,  LocalizedText explanation,  String sourceGuideline)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.id,_that.bankId,_that.topic,_that.prompt,_that.options,_that.correctIndex,_that.explanation,_that.sourceGuideline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bankId,  String topic,  LocalizedText prompt,  List<LocalizedText> options,  int correctIndex,  LocalizedText explanation,  String sourceGuideline)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.bankId,_that.topic,_that.prompt,_that.options,_that.correctIndex,_that.explanation,_that.sourceGuideline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Question implements Question {
  const _Question({required this.id, required this.bankId, required this.topic, required this.prompt, required  List<LocalizedText> options, required this.correctIndex, required this.explanation, required this.sourceGuideline}): _options = options;
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  String id;
@override final  String bankId;
@override final  String topic;
@override final  LocalizedText prompt;
 final  List<LocalizedText> _options;
@override List<LocalizedText> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  int correctIndex;
@override final  LocalizedText explanation;
@override final  String sourceGuideline;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.id, id) || other.id == id)&&(identical(other.bankId, bankId) || other.bankId == bankId)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other.options, _options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.sourceGuideline, sourceGuideline) || other.sourceGuideline == sourceGuideline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,bankId,topic,prompt,const DeepCollectionEquality().hash(_options),correctIndex,explanation,sourceGuideline);
}

@override
String toString() {
    return 'Question(id: $id, bankId: $bankId, topic: $topic, prompt: $prompt, options: $options, correctIndex: $correctIndex, explanation: $explanation, sourceGuideline: $sourceGuideline)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String bankId, String topic, LocalizedText prompt, List<LocalizedText> options, int correctIndex, LocalizedText explanation, String sourceGuideline
});


@override $LocalizedTextCopyWith<$Res> get prompt;@override $LocalizedTextCopyWith<$Res> get explanation;

}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bankId = null,Object? topic = null,Object? prompt = null,Object? options = null,Object? correctIndex = null,Object? explanation = null,Object? sourceGuideline = null,}) {
  return _then(_Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bankId: null == bankId ? _self.bankId : bankId // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as LocalizedText,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as LocalizedText,sourceGuideline: null == sourceGuideline ? _self.sourceGuideline : sourceGuideline // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get prompt {
  
  return $LocalizedTextCopyWith<$Res>(_self.prompt, (value) {
    return _then(_self.copyWith(prompt: value));
  });
}/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get explanation {
  
  return $LocalizedTextCopyWith<$Res>(_self.explanation, (value) {
    return _then(_self.copyWith(explanation: value));
  });
}
}


/// @nodoc
mixin _$Quiz {

 String get id; String get courseId; LocalizedText get title;/// What the quiz covers, shown on the Assess tab ("Basic Life Support").
 LocalizedText get subject; List<String> get topicOrder; int get size; int get passMarkPct;
/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizCopyWith<Quiz> get copyWith => _$QuizCopyWithImpl<Quiz>(this as Quiz, _$identity);

  /// Serializes this Quiz to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Quiz;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quiz&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.courseId, _this.courseId) || other.courseId == _this.courseId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&const DeepCollectionEquality().equals(other.topicOrder, _this.topicOrder)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.passMarkPct, _this.passMarkPct) || other.passMarkPct == _this.passMarkPct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Quiz;
  return Object.hash(runtimeType,_this.id,_this.courseId,_this.title,_this.subject,const DeepCollectionEquality().hash(_this.topicOrder),_this.size,_this.passMarkPct);
}

@override
String toString() {
  final _this = this as Quiz;
  return 'Quiz(id: ${_this.id}, courseId: ${_this.courseId}, title: ${_this.title}, subject: ${_this.subject}, topicOrder: ${_this.topicOrder}, size: ${_this.size}, passMarkPct: ${_this.passMarkPct})';
}


}

/// @nodoc
abstract mixin class $QuizCopyWith<$Res>  {
  factory $QuizCopyWith(Quiz value, $Res Function(Quiz) _then) = _$QuizCopyWithImpl;
@useResult
$Res call({
 String id, String courseId, LocalizedText title, LocalizedText subject, List<String> topicOrder, int size, int passMarkPct
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get subject;

}
/// @nodoc
class _$QuizCopyWithImpl<$Res>
    implements $QuizCopyWith<$Res> {
  _$QuizCopyWithImpl(this._self, this._then);

  final Quiz _self;
  final $Res Function(Quiz) _then;

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? courseId = null,Object? title = null,Object? subject = null,Object? topicOrder = null,Object? size = null,Object? passMarkPct = null,}) {
  return _then(Quiz(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as LocalizedText,topicOrder: null == topicOrder ? _self.topicOrder : topicOrder // ignore: cast_nullable_to_non_nullable
as List<String>,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,passMarkPct: null == passMarkPct ? _self.passMarkPct : passMarkPct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get subject {
  
  return $LocalizedTextCopyWith<$Res>(_self.subject, (value) {
    return _then(_self.copyWith(subject: value));
  });
}
}


/// Adds pattern-matching-related methods to [Quiz].
extension QuizPatterns on Quiz {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Quiz value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Quiz() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Quiz value)  $default,){
final _that = this;
switch (_that) {
case _Quiz():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Quiz value)?  $default,){
final _that = this;
switch (_that) {
case _Quiz() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String courseId,  LocalizedText title,  LocalizedText subject,  List<String> topicOrder,  int size,  int passMarkPct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quiz() when $default != null:
return $default(_that.id,_that.courseId,_that.title,_that.subject,_that.topicOrder,_that.size,_that.passMarkPct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String courseId,  LocalizedText title,  LocalizedText subject,  List<String> topicOrder,  int size,  int passMarkPct)  $default,) {final _that = this;
switch (_that) {
case _Quiz():
return $default(_that.id,_that.courseId,_that.title,_that.subject,_that.topicOrder,_that.size,_that.passMarkPct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String courseId,  LocalizedText title,  LocalizedText subject,  List<String> topicOrder,  int size,  int passMarkPct)?  $default,) {final _that = this;
switch (_that) {
case _Quiz() when $default != null:
return $default(_that.id,_that.courseId,_that.title,_that.subject,_that.topicOrder,_that.size,_that.passMarkPct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Quiz implements Quiz {
  const _Quiz({required this.id, required this.courseId, required this.title, required this.subject, required  List<String> topicOrder, required this.size, required this.passMarkPct}): _topicOrder = topicOrder;
  factory _Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

@override final  String id;
@override final  String courseId;
@override final  LocalizedText title;
/// What the quiz covers, shown on the Assess tab ("Basic Life Support").
@override final  LocalizedText subject;
 final  List<String> _topicOrder;
@override List<String> get topicOrder {
  if (_topicOrder is EqualUnmodifiableListView) return _topicOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topicOrder);
}

@override final  int size;
@override final  int passMarkPct;

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizCopyWith<_Quiz> get copyWith => __$QuizCopyWithImpl<_Quiz>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quiz&&(identical(other.id, id) || other.id == id)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.subject, subject) || other.subject == subject)&&const DeepCollectionEquality().equals(other.topicOrder, _topicOrder)&&(identical(other.size, size) || other.size == size)&&(identical(other.passMarkPct, passMarkPct) || other.passMarkPct == passMarkPct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,courseId,title,subject,const DeepCollectionEquality().hash(_topicOrder),size,passMarkPct);
}

@override
String toString() {
    return 'Quiz(id: $id, courseId: $courseId, title: $title, subject: $subject, topicOrder: $topicOrder, size: $size, passMarkPct: $passMarkPct)';
}


}

/// @nodoc
abstract mixin class _$QuizCopyWith<$Res> implements $QuizCopyWith<$Res> {
  factory _$QuizCopyWith(_Quiz value, $Res Function(_Quiz) _then) = __$QuizCopyWithImpl;
@override @useResult
$Res call({
 String id, String courseId, LocalizedText title, LocalizedText subject, List<String> topicOrder, int size, int passMarkPct
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get subject;

}
/// @nodoc
class __$QuizCopyWithImpl<$Res>
    implements _$QuizCopyWith<$Res> {
  __$QuizCopyWithImpl(this._self, this._then);

  final _Quiz _self;
  final $Res Function(_Quiz) _then;

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? courseId = null,Object? title = null,Object? subject = null,Object? topicOrder = null,Object? size = null,Object? passMarkPct = null,}) {
  return _then(_Quiz(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as LocalizedText,topicOrder: null == topicOrder ? _self._topicOrder : topicOrder // ignore: cast_nullable_to_non_nullable
as List<String>,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,passMarkPct: null == passMarkPct ? _self.passMarkPct : passMarkPct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get subject {
  
  return $LocalizedTextCopyWith<$Res>(_self.subject, (value) {
    return _then(_self.copyWith(subject: value));
  });
}
}


/// @nodoc
mixin _$QuizAttempt {

 String get id; String get userId; String get quizId; List<int> get answers; int get scorePct; bool get passed;@UtcDateTimeConverter() DateTime get submittedAt;
/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizAttemptCopyWith<QuizAttempt> get copyWith => _$QuizAttemptCopyWithImpl<QuizAttempt>(this as QuizAttempt, _$identity);

  /// Serializes this QuizAttempt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuizAttempt;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizAttempt&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.quizId, _this.quizId) || other.quizId == _this.quizId)&&const DeepCollectionEquality().equals(other.answers, _this.answers)&&(identical(other.scorePct, _this.scorePct) || other.scorePct == _this.scorePct)&&(identical(other.passed, _this.passed) || other.passed == _this.passed)&&(identical(other.submittedAt, _this.submittedAt) || other.submittedAt == _this.submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuizAttempt;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.quizId,const DeepCollectionEquality().hash(_this.answers),_this.scorePct,_this.passed,_this.submittedAt);
}

@override
String toString() {
  final _this = this as QuizAttempt;
  return 'QuizAttempt(id: ${_this.id}, userId: ${_this.userId}, quizId: ${_this.quizId}, answers: ${_this.answers}, scorePct: ${_this.scorePct}, passed: ${_this.passed}, submittedAt: ${_this.submittedAt})';
}


}

/// @nodoc
abstract mixin class $QuizAttemptCopyWith<$Res>  {
  factory $QuizAttemptCopyWith(QuizAttempt value, $Res Function(QuizAttempt) _then) = _$QuizAttemptCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String quizId, List<int> answers, int scorePct, bool passed,@UtcDateTimeConverter() DateTime submittedAt
});




}
/// @nodoc
class _$QuizAttemptCopyWithImpl<$Res>
    implements $QuizAttemptCopyWith<$Res> {
  _$QuizAttemptCopyWithImpl(this._self, this._then);

  final QuizAttempt _self;
  final $Res Function(QuizAttempt) _then;

/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? quizId = null,Object? answers = null,Object? scorePct = null,Object? passed = null,Object? submittedAt = null,}) {
  return _then(QuizAttempt(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as List<int>,scorePct: null == scorePct ? _self.scorePct : scorePct // ignore: cast_nullable_to_non_nullable
as int,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizAttempt].
extension QuizAttemptPatterns on QuizAttempt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizAttempt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizAttempt value)  $default,){
final _that = this;
switch (_that) {
case _QuizAttempt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizAttempt value)?  $default,){
final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String quizId,  List<int> answers,  int scorePct,  bool passed, @UtcDateTimeConverter()  DateTime submittedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
return $default(_that.id,_that.userId,_that.quizId,_that.answers,_that.scorePct,_that.passed,_that.submittedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String quizId,  List<int> answers,  int scorePct,  bool passed, @UtcDateTimeConverter()  DateTime submittedAt)  $default,) {final _that = this;
switch (_that) {
case _QuizAttempt():
return $default(_that.id,_that.userId,_that.quizId,_that.answers,_that.scorePct,_that.passed,_that.submittedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String quizId,  List<int> answers,  int scorePct,  bool passed, @UtcDateTimeConverter()  DateTime submittedAt)?  $default,) {final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
return $default(_that.id,_that.userId,_that.quizId,_that.answers,_that.scorePct,_that.passed,_that.submittedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizAttempt implements QuizAttempt {
  const _QuizAttempt({required this.id, required this.userId, required this.quizId, required  List<int> answers, required this.scorePct, required this.passed, @UtcDateTimeConverter() required this.submittedAt}): _answers = answers;
  factory _QuizAttempt.fromJson(Map<String, dynamic> json) => _$QuizAttemptFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String quizId;
 final  List<int> _answers;
@override List<int> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

@override final  int scorePct;
@override final  bool passed;
@override@UtcDateTimeConverter() final  DateTime submittedAt;

/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizAttemptCopyWith<_QuizAttempt> get copyWith => __$QuizAttemptCopyWithImpl<_QuizAttempt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizAttemptToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizAttempt&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&const DeepCollectionEquality().equals(other.answers, _answers)&&(identical(other.scorePct, scorePct) || other.scorePct == scorePct)&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,quizId,const DeepCollectionEquality().hash(_answers),scorePct,passed,submittedAt);
}

@override
String toString() {
    return 'QuizAttempt(id: $id, userId: $userId, quizId: $quizId, answers: $answers, scorePct: $scorePct, passed: $passed, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$QuizAttemptCopyWith<$Res> implements $QuizAttemptCopyWith<$Res> {
  factory _$QuizAttemptCopyWith(_QuizAttempt value, $Res Function(_QuizAttempt) _then) = __$QuizAttemptCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String quizId, List<int> answers, int scorePct, bool passed,@UtcDateTimeConverter() DateTime submittedAt
});




}
/// @nodoc
class __$QuizAttemptCopyWithImpl<$Res>
    implements _$QuizAttemptCopyWith<$Res> {
  __$QuizAttemptCopyWithImpl(this._self, this._then);

  final _QuizAttempt _self;
  final $Res Function(_QuizAttempt) _then;

/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? quizId = null,Object? answers = null,Object? scorePct = null,Object? passed = null,Object? submittedAt = null,}) {
  return _then(_QuizAttempt(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<int>,scorePct: null == scorePct ? _self.scorePct : scorePct // ignore: cast_nullable_to_non_nullable
as int,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
