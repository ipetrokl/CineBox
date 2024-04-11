// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      json['id'] as int?,
      json['name'] as String?,
      json['surname'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['username'] as String?,
      json['password'] as String?,
      json['passwordConfirmation'] as String?,
      json['status'] as bool?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'phone': instance.phone,
      'username': instance.username,
      'password': instance.password,
      'passwordConfirmation': instance.passwordConfirmation,
      'status': instance.status,
    };
