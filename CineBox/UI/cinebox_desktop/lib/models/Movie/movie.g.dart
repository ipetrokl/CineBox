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
      json['performedFrom'] == null
          ? null
          : DateTime.parse(json['performedFrom'] as String),
      json['performedTo'] == null
          ? null
          : DateTime.parse(json['performedTo'] as String),
      json['director'] as String?,
      json['picture'] as String?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'genreId': instance.genreId,
      'title': instance.title,
      'description': instance.description,
      'performedFrom': instance.performedFrom?.toIso8601String(),
      'performedTo': instance.performedTo?.toIso8601String(),
      'director': instance.director,
      'picture': instance.picture,
    };
