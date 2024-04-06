import 'package:json_annotation/json_annotation.dart';

part 'cinema.g.dart';

@JsonSerializable()
class Cinema {
  int? id;
  String? name;
  String? location;

  Cinema(this.id, this.name, this.location);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Cinema.fromJson(Map<String, dynamic> json) => _$CinemaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CinemaToJson(this);
}
