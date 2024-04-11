// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usersRole.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersRole _$UsersRoleFromJson(Map<String, dynamic> json) => UsersRole(
      json['usersRolesId'] as int?,
      json['userId'] as int?,
      json['roleId'] as int?,
      json['dateOfModification'] == null
          ? null
          : DateTime.parse(json['dateOfModification'] as String),
    );

Map<String, dynamic> _$UsersRoleToJson(UsersRole instance) => <String, dynamic>{
      'usersRolesId': instance.usersRolesId,
      'userId': instance.userId,
      'roleId': instance.roleId,
      'dateOfModification': instance.dateOfModification?.toIso8601String(),
    };
