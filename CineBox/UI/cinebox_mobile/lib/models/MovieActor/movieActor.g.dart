// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movieActor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieActor _$MovieActorFromJson(Map<String, dynamic> json) => MovieActor()
  ..id = (json['id'] as num?)?.toInt()
  ..movieId = (json['movieId'] as num?)?.toInt()
  ..actorId = (json['actorId'] as num?)?.toInt();

Map<String, dynamic> _$MovieActorToJson(MovieActor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'actorId': instance.actorId,
    };
