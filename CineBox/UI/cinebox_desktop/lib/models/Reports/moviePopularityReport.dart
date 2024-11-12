import 'package:json_annotation/json_annotation.dart';

part 'moviePopularityReport.g.dart';

@JsonSerializable()
class MoviePopularityReport {
  final String movieName;
  final int bookingCount;

  MoviePopularityReport({required this.movieName, required this.bookingCount});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MoviePopularityReport.fromJson(Map<String, dynamic> json) =>
      _$MoviePopularityReportFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MoviePopularityReportToJson(this);
}