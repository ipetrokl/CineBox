// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review()
  ..id = (json['id'] as num?)?.toInt()
  ..userId = (json['userId'] as num?)?.toInt()
  ..movieId = (json['movieId'] as num?)?.toInt()
  ..rating = (json['rating'] as num?)?.toDouble()
  ..comment = json['comment'] as String?;

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'movieId': instance.movieId,
      'rating': instance.rating,
      'comment': instance.comment,
    };
