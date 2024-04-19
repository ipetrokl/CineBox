// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movieActor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieActor _$MovieActorFromJson(Map<String, dynamic> json) => MovieActor()
  ..id = json['id'] as int?
  ..movieId = json['movieId'] as int?
  ..actorId = json['actorId'] as int?;

Map<String, dynamic> _$MovieActorToJson(MovieActor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'actorId': instance.actorId,
    };
