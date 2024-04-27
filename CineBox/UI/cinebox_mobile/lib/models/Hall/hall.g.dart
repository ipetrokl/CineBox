// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hall _$HallFromJson(Map<String, dynamic> json) => Hall()
  ..id = json['id'] as int?
  ..cinemaId = json['cinemaId'] as int?
  ..name = json['name'] as String?;

Map<String, dynamic> _$HallToJson(Hall instance) => <String, dynamic>{
      'id': instance.id,
      'cinemaId': instance.cinemaId,
      'name': instance.name,
    };
