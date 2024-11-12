import 'package:json_annotation/json_annotation.dart';

part 'hallOccupancyReport.g.dart';

@JsonSerializable()
class HallOccupancyReport {
  final String hallName;
  final int occupiedSeats;
  final int totalSeats;

  HallOccupancyReport({required this.hallName, required this.occupiedSeats, required this.totalSeats});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory HallOccupancyReport.fromJson(Map<String, dynamic> json) =>
      _$HallOccupancyReportFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$HallOccupancyReportToJson(this);
}
