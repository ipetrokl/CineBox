// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      json['id'] as int?,
      json['genreId'] as int?,
      json['title'] as String?,
      json['description'] as String?,
      json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
      json['duration'] as int?,
      json['director'] as String?,
      json['picture'] as String?,
    );

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
