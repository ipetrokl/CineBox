// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screening.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Screening _$ScreeningFromJson(Map<String, dynamic> json) => Screening()
  ..id = json['id'] as int?
  ..movieId = json['movieId'] as int?
  ..cinemaId = json['cinemaId'] as int?
  ..category = json['category'] as String?
  ..startTime = json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String)
  ..endTime =
      json['endTime'] == null ? null : DateTime.parse(json['endTime'] as String)
  ..price = (json['price'] as num?)?.toDouble();

Map<String, dynamic> _$ScreeningToJson(Screening instance) => <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'cinemaId': instance.cinemaId,
      'category': instance.category,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'price': instance.price,
    };
