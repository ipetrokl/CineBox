import 'package:cinebox_desktop/models/Booking/booking.dart';
import 'package:cinebox_desktop/models/Seat/seat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookingSeat.g.dart';

@JsonSerializable()
class BookingSeat {
  int? id;
  int? bookingId;
  int? seatId;
  Booking? booking;
  Seat? seat;

  BookingSeat(this.id, this.bookingId, this.seatId, this.booking,
      this.seat);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory BookingSeat.fromJson(Map<String, dynamic> json) =>
      _$BookingSeatFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BookingSeatToJson(this);
}
