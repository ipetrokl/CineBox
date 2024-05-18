import 'package:cinebox_mobile/utils/Hall_utils/seat_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat.g.dart';

@JsonSerializable()
class Seat {
  int? id;
  int? hallId;
  int? seatNumber;
  String? category;
  bool? status;
  SeatType? type;

  Seat({required SeatType type});

  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);

  Map<String, dynamic> toJson() => _$SeatToJson(this);
}
