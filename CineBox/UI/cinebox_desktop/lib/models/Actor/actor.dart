import 'package:json_annotation/json_annotation.dart';

part 'actor.g.dart';

@JsonSerializable()
class Actor {
  int? id;
  String? name;

  Actor(this.id, this.name);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ActorToJson(this);
}
