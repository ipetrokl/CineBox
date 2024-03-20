// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      json['id'] as int?,
      json['title'] as String?,
      json['description'] as String?,
      json['releaseDate'] as String?,
      json['duration'] as int?,
      json['genre'] as String?,
      json['director'] as String?,
      json['picture'] as String?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'releaseDate': instance.releaseDate,
      'duration': instance.duration,
      'genre': instance.genre,
      'director': instance.director,
      'picture': instance.picture,
    };
