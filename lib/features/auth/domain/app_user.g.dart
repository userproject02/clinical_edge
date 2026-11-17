// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  name: LocalizedText.fromJson(json['name'] as Map<String, dynamic>),
  shortName: LocalizedText.fromJson(json['shortName'] as Map<String, dynamic>),
  title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
  department: json['department'] as String,
  email: json['email'] as String,
  role: $enumDecode(_$RoleEnumMap, json['role']),
  initials: json['initials'] as String,
  cohort: json['cohort'] as bool? ?? false,
  locale: json['locale'] as String? ?? 'en',
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name.toJson(),
  'shortName': instance.shortName.toJson(),
  'title': instance.title.toJson(),
  'department': instance.department,
  'email': instance.email,
  'role': _$RoleEnumMap[instance.role]!,
  'initials': instance.initials,
  'cohort': instance.cohort,
  'locale': instance.locale,
};

const _$RoleEnumMap = {
  Role.learner: 'learner',
  Role.supervisor: 'supervisor',
  Role.admin: 'admin',
};
