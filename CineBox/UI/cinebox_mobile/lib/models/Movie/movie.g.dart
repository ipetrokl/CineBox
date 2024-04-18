// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie()
  ..id = json['id'] as int?
  ..genreId = json['genreId'] as int?
  ..title = json['title'] as String?
  ..description = json['description'] as String?
  ..releaseDate = json['releaseDate'] == null
      ? null
      : DateTime.parse(json['releaseDate'] as String)
  ..duration = json['duration'] as int?
  ..director = json['director'] as String?
  ..picture = json['picture'] as String?;

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'genreId': instance.genreId,
      'title': instance.title,
      'description': instance.description,
      'releaseDate': instance.releaseDate?.toIso8601String(),
      'duration': instance.duration,
      'director': instance.director,
      'picture': instance.picture,
    };
