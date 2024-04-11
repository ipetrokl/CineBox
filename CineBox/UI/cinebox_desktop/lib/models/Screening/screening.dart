
import 'package:json_annotation/json_annotation.dart';

part 'screening.g.dart';

@JsonSerializable()
class Screening {
  int? id;
  int? movieId;
  int? cinemaId;
  String? category;
  DateTime? startTime;
  DateTime? endTime;
  double? price;

  Screening(this.id, this.movieId, this.cinemaId, this.category, this.startTime,
      this.endTime);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Screening.fromJson(Map<String, dynamic> json) =>
      _$ScreeningFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ScreeningToJson(this);
}
