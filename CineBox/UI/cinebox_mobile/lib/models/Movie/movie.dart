import 'package:cinebox_mobile/models/Actor/actor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  int? id;
  int? genreId;
  String? title;
  String? description;
  DateTime? performedFrom;
  DateTime? performedTo;
  int? duration;
  String? director;
  String? picture;
  List<Actor>? actors;

  Movie();

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}