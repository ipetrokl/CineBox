import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'movie.g.dart';

@JsonSerializable()
class Movie {
  int? id;
  String? title;
  String? description;
  String? releaseDate;
  int? duration;
  String? genre;
  String? director;

  Movie(this.id, this.title, this.description, this.releaseDate, this.duration,
      this.genre, this.director);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}


// public int Id { get; set; }

//         public string Title { get; set; } = null!;

//         public string Description { get; set; } = null!;

//         public DateTime ReleaseDate { get; set; }

//         public int Duration { get; set; }

//         public string Genre { get; set; } = null!;

//         public string Director { get; set; } = null!;

//         public byte[]? Picture { get; set; }

//         public byte[]? PictureThumb { get; set; }

//         public string? StateMachine { get; set; }