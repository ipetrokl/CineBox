// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie()
  ..id = (json['id'] as num?)?.toInt()
  ..genreId = (json['genreId'] as num?)?.toInt()
  ..title = json['title'] as String?
  ..description = json['description'] as String?
  ..performedFrom = json['performedFrom'] == null
      ? null
      : DateTime.parse(json['performedFrom'] as String)
  ..performedTo = json['performedTo'] == null
      ? null
      : DateTime.parse(json['performedTo'] as String)
  ..duration = (json['duration'] as num?)?.toInt()
  ..director = json['director'] as String?
  ..picture = json['picture'] as String?
  ..actors = (json['actors'] as List<dynamic>?)
      ?.map((e) => Actor.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'genreId': instance.genreId,
      'title': instance.title,
      'description': instance.description,
      'performedFrom': instance.performedFrom?.toIso8601String(),
      'performedTo': instance.performedTo?.toIso8601String(),
      'duration': instance.duration,
      'director': instance.director,
      'picture': instance.picture,
      'actors': instance.actors,
    };
