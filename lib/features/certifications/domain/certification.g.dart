// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Certification _$CertificationFromJson(Map<String, dynamic> json) =>
    _Certification(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: LocalizedText.fromJson(json['name'] as Map<String, dynamic>),
      issuer: LocalizedText.fromJson(json['issuer'] as Map<String, dynamic>),
      issuedOn: const DateOnlyConverter().fromJson(json['issuedOn'] as String),
      expiresOn: const DateOnlyConverter().fromJson(
        json['expiresOn'] as String,
      ),
      verification: $enumDecode(_$VerificationEnumMap, json['verification']),
      fileRef: json['fileRef'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$CertificationToJson(_Certification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name.toJson(),
      'issuer': instance.issuer.toJson(),
      'issuedOn': const DateOnlyConverter().toJson(instance.issuedOn),
      'expiresOn': const DateOnlyConverter().toJson(instance.expiresOn),
      'verification': _$VerificationEnumMap[instance.verification]!,
      'fileRef': instance.fileRef,
      'code': instance.code,
    };

const _$VerificationEnumMap = {
  Verification.verified: 'verified',
  Verification.pending: 'pending',
};

_CpdEntry _$CpdEntryFromJson(Map<String, dynamic> json) => _CpdEntry(
  id: json['id'] as String,
  userId: json['userId'] as String,
  date: const DateOnlyConverter().fromJson(json['date'] as String),
  activity: LocalizedText.fromJson(json['activity'] as Map<String, dynamic>),
  source: $enumDecode(_$CpdSourceEnumMap, json['source']),
  credits: (json['credits'] as num).toInt(),
);

Map<String, dynamic> _$CpdEntryToJson(_CpdEntry instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'date': const DateOnlyConverter().toJson(instance.date),
  'activity': instance.activity.toJson(),
  'source': _$CpdSourceEnumMap[instance.source]!,
  'credits': instance.credits,
};

const _$CpdSourceEnumMap = {
  CpdSource.external: 'external',
  CpdSource.clinicaledge: 'clinicaledge',
};

_CpdConfig _$CpdConfigFromJson(Map<String, dynamic> json) => _CpdConfig(
  cycle: json['cycle'] as String,
  target: (json['target'] as num).toInt(),
  targetIsDemo: json['targetIsDemo'] as bool,
  targetNote: LocalizedText.fromJson(
    json['targetNote'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CpdConfigToJson(_CpdConfig instance) =>
    <String, dynamic>{
      'cycle': instance.cycle,
      'target': instance.target,
      'targetIsDemo': instance.targetIsDemo,
      'targetNote': instance.targetNote.toJson(),
    };
