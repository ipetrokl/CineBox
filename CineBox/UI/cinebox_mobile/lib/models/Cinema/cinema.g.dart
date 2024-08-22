// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cinema _$CinemaFromJson(Map<String, dynamic> json) => Cinema()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..location = json['location'] as String?;

Map<String, dynamic> _$CinemaToJson(Cinema instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
    };
