// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
  id: json['id'] as String,
  bankId: json['bankId'] as String,
  topic: json['topic'] as String,
  prompt: LocalizedText.fromJson(json['prompt'] as Map<String, dynamic>),
  options: (json['options'] as List<dynamic>)
      .map((e) => LocalizedText.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctIndex: (json['correctIndex'] as num).toInt(),
  explanation: LocalizedText.fromJson(
    json['explanation'] as Map<String, dynamic>,
  ),
  sourceGuideline: json['sourceGuideline'] as String,
);

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'id': instance.id,
  'bankId': instance.bankId,
  'topic': instance.topic,
  'prompt': instance.prompt.toJson(),
  'options': instance.options.map((e) => e.toJson()).toList(),
  'correctIndex': instance.correctIndex,
  'explanation': instance.explanation.toJson(),
  'sourceGuideline': instance.sourceGuideline,
};

_Quiz _$QuizFromJson(Map<String, dynamic> json) => _Quiz(
  id: json['id'] as String,
  courseId: json['courseId'] as String,
  title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
  topicOrder: (json['topicOrder'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  size: (json['size'] as num).toInt(),
  passMarkPct: (json['passMarkPct'] as num).toInt(),
);

Map<String, dynamic> _$QuizToJson(_Quiz instance) => <String, dynamic>{
  'id': instance.id,
  'courseId': instance.courseId,
  'title': instance.title.toJson(),
  'topicOrder': instance.topicOrder,
  'size': instance.size,
  'passMarkPct': instance.passMarkPct,
};

_QuizAttempt _$QuizAttemptFromJson(Map<String, dynamic> json) => _QuizAttempt(
  id: json['id'] as String,
  userId: json['userId'] as String,
  quizId: json['quizId'] as String,
  answers: (json['answers'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  scorePct: (json['scorePct'] as num).toInt(),
  passed: json['passed'] as bool,
  submittedAt: const UtcDateTimeConverter().fromJson(
    json['submittedAt'] as String,
  ),
);

Map<String, dynamic> _$QuizAttemptToJson(_QuizAttempt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'quizId': instance.quizId,
      'answers': instance.answers,
      'scorePct': instance.scorePct,
      'passed': instance.passed,
      'submittedAt': const UtcDateTimeConverter().toJson(instance.submittedAt),
    };
