import 'package:json_annotation/json_annotation.dart';

part 'terminOccupiedReport.g.dart';

@JsonSerializable()
class TerminOccupiedReport {
  final String screeningTime;
  final String movieTitle;
  final int totalBookedSeats;

  TerminOccupiedReport({required this.screeningTime, required this.movieTitle, required this.totalBookedSeats});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory TerminOccupiedReport.fromJson(Map<String, dynamic> json) =>
      _$TerminOccupiedReportFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TerminOccupiedReportToJson(this);
}
