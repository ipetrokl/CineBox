import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
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