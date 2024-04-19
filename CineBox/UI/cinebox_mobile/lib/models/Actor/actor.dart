import 'package:json_annotation/json_annotation.dart';

part 'actor.g.dart';

@JsonSerializable()
class Actor {
  int? id;
  String? name;

  Actor();

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
  
  Map<String, dynamic> toJson() => _$ActorToJson(this);
}