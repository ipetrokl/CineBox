import 'package:cinebox_desktop/models/Picture/picture.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'movie.g.dart';

@JsonSerializable()
class Movie {
  int? id;
  int? genreId;
  String? title;
  String? description;
  DateTime? performedFrom;
  DateTime? performedTo;
  String? director;
  int? pictureId;

  Movie(this.id, this.genreId, this.title, this.description, this.performedFrom,
      this.performedTo, this.director, this.pictureId);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
