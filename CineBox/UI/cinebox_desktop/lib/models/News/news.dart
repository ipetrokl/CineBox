import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  int? id;
  int? cinemaId;
  String? name;
  String? description;
  DateTime? createdDate;

  News(this.id, this.cinemaId, this.name, this.description, this.createdDate);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory News.fromJson(Map<String, dynamic> json) =>
      _$NewsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}