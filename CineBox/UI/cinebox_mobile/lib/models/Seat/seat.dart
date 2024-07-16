import 'package:json_annotation/json_annotation.dart';

part 'seat.g.dart';

@JsonSerializable()
class Seat {
  int? id;
  int? hallId;
  int? seatNumber;
  String? category;
  bool? status;

  Seat();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Seat &&
        other.id == id &&
        other.category == category &&
        other.status == status;
  }

  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);

  Map<String, dynamic> toJson() => _$SeatToJson(this);
}
