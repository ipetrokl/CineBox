import 'package:cinebox_mobile/utils/Hall_utils/seat_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookingSeat.g.dart';

@JsonSerializable()
class BookingSeat {
  int? bookingSeatId;
  int? bookingId;
  int? seatId;

  BookingSeat(this.bookingSeatId, this.bookingId, this.seatId);

  factory BookingSeat.fromJson(Map<String, dynamic> json) => _$BookingSeatFromJson(json);

  Map<String, dynamic> toJson() => _$BookingSeatToJson(this);
}