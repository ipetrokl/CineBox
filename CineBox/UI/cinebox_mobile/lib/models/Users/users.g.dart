// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..surname = json['surname'] as String?
  ..email = json['email'] as String?
  ..phone = json['phone'] as String?
  ..username = json['username'] as String?
  ..password = json['password'] as String?
  ..passwordConfirmation = json['passwordConfirmation'] as String?
  ..status = json['status'] as bool?
  ..pictureId = (json['pictureId'] as num?)?.toInt()
  ..picture = json['picture'] == null
      ? null
      : Picture.fromJson(json['picture'] as Map<String, dynamic>);

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
      'pictureId': instance.pictureId,
      'picture': instance.picture,
    };
