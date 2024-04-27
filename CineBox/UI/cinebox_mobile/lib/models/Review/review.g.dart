// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review()
  ..id = json['id'] as int?
  ..userId = json['userId'] as int?
  ..movieId = json['movieId'] as int?
  ..rating = (json['rating'] as num?)?.toDouble()
  ..comment = json['comment'] as String?;

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'movieId': instance.movieId,
      'rating': instance.rating,
      'comment': instance.comment,
    };
