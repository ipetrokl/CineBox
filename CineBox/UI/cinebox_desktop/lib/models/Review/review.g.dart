// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      json['id'] as int?,
      json['userId'] as int?,
      json['movieId'] as int?,
      (json['rating'] as num?)?.toDouble(),
      json['comment'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'movieId': instance.movieId,
      'rating': instance.rating,
      'comment': instance.comment,
    };
