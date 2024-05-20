// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      json['id'] as int?,
      json['cinemaId'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'cinemaId': instance.cinemaId,
      'name': instance.name,
      'description': instance.description,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
