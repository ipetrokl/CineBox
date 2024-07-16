import 'package:json_annotation/json_annotation.dart';

part 'movieActor.g.dart';

@JsonSerializable()
class MovieActor {
  int? id;
  int? movieId;
  int? actorId;

  MovieActor();

  factory MovieActor.fromJson(Map<String, dynamic> json) => _$MovieActorFromJson(json);

  Map<String, dynamic> toJson() => _$MovieActorToJson(this);
}