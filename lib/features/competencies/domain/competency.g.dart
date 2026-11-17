// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetencyChecklist _$CompetencyChecklistFromJson(Map<String, dynamic> json) =>
    _CompetencyChecklist(
      id: json['id'] as String,
      name: LocalizedText.fromJson(json['name'] as Map<String, dynamic>),
      audience: LocalizedText.fromJson(
        json['audience'] as Map<String, dynamic>,
      ),
      items: (json['items'] as List<dynamic>)
          .map((e) => LocalizedText.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompetencyChecklistToJson(
  _CompetencyChecklist instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name.toJson(),
  'audience': instance.audience.toJson(),
  'items': instance.items.map((e) => e.toJson()).toList(),
};

_SignOffRequest _$SignOffRequestFromJson(Map<String, dynamic> json) =>
    _SignOffRequest(
      id: json['id'] as String,
      learnerId: json['learnerId'] as String,
      checklistId: json['checklistId'] as String,
      status: $enumDecode(_$SignOffStatusEnumMap, json['status']),
      requestedAt: const NullableUtcDateTimeConverter().fromJson(
        json['requestedAt'] as String?,
      ),
      decidedBy: json['decidedBy'] as String?,
      decidedAt: const NullableUtcDateTimeConverter().fromJson(
        json['decidedAt'] as String?,
      ),
      comment: json['comment'] == null
          ? null
          : LocalizedText.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignOffRequestToJson(
  _SignOffRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'learnerId': instance.learnerId,
  'checklistId': instance.checklistId,
  'status': _$SignOffStatusEnumMap[instance.status]!,
  'requestedAt': const NullableUtcDateTimeConverter().toJson(
    instance.requestedAt,
  ),
  'decidedBy': instance.decidedBy,
  'decidedAt': const NullableUtcDateTimeConverter().toJson(instance.decidedAt),
  'comment': instance.comment?.toJson(),
};

const _$SignOffStatusEnumMap = {
  SignOffStatus.none: 'none',
  SignOffStatus.pending: 'pending',
  SignOffStatus.approved: 'approved',
  SignOffStatus.rejected: 'rejected',
};
