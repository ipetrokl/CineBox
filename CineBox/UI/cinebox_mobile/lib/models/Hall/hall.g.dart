// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hall _$HallFromJson(Map<String, dynamic> json) => Hall()
  ..id = (json['id'] as num?)?.toInt()
  ..cinemaId = (json['cinemaId'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..cinema = json['cinema'] == null
      ? null
      : Cinema.fromJson(json['cinema'] as Map<String, dynamic>);

Map<String, dynamic> _$HallToJson(Hall instance) => <String, dynamic>{
      'id': instance.id,
      'cinemaId': instance.cinemaId,
      'name': instance.name,
      'cinema': instance.cinema,
    };
