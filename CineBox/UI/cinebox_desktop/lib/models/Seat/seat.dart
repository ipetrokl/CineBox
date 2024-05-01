import 'package:json_annotation/json_annotation.dart';

part 'seat.g.dart';

@JsonSerializable()
class Seat {
  int? id;
  int? hallId;
  int? seatNumber;
  String? category;
  bool? status;

  Seat(this.id, this.hallId, this.seatNumber, this.category, this.status);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SeatToJson(this);
}
