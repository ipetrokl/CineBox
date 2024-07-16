import 'package:cinebox_mobile/models/BookingSeat/bookingSeat.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  int? id;
  int? userId;
  int? screeningId;
  double? price;
  int? promotionId;
  Screening? screening;
  List<BookingSeat>? bookingSeats;

  Booking(this.id, this.userId, this.screeningId, this.price, this.promotionId);

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
