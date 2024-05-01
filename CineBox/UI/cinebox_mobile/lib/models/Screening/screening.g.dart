// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screening.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Screening _$ScreeningFromJson(Map<String, dynamic> json) => Screening()
  ..id = json['id'] as int?
  ..movieId = json['movieId'] as int?
  ..hallId = json['hallId'] as int?
  ..category = json['category'] as String?
  ..screeningTime = json['screeningTime'] == null
      ? null
      : DateTime.parse(json['screeningTime'] as String)
  ..price = (json['price'] as num?)?.toDouble();

Map<String, dynamic> _$ScreeningToJson(Screening instance) => <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'hallId': instance.hallId,
      'category': instance.category,
      'screeningTime': instance.screeningTime?.toIso8601String(),
      'price': instance.price,
    };
