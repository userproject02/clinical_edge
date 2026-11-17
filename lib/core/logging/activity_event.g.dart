// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityEvent _$ActivityEventFromJson(Map<String, dynamic> json) =>
    _ActivityEvent(
      id: json['id'] as String,
      ts: const UtcDateTimeConverter().fromJson(json['ts'] as String),
      userId: json['userId'] as String,
      role: $enumDecode(_$RoleEnumMap, json['role']),
      action: json['action'] as String,
      target: json['target'] as String,
      platform: json['platform'] as String,
      kind: $enumDecode(_$EventKindEnumMap, json['kind']),
      prevHash: json['prevHash'] as String?,
      hash: json['hash'] as String?,
    );

Map<String, dynamic> _$ActivityEventToJson(_ActivityEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ts': const UtcDateTimeConverter().toJson(instance.ts),
      'userId': instance.userId,
      'role': _$RoleEnumMap[instance.role]!,
      'action': instance.action,
      'target': instance.target,
      'platform': instance.platform,
      'kind': _$EventKindEnumMap[instance.kind]!,
      'prevHash': instance.prevHash,
      'hash': instance.hash,
    };

const _$RoleEnumMap = {
  Role.learner: 'learner',
  Role.supervisor: 'supervisor',
  Role.admin: 'admin',
};

const _$EventKindEnumMap = {EventKind.audit: 'audit', EventKind.usage: 'usage'};
