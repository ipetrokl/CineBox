import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  int? id;
  int? userId;
  int? screeningId;
  double? price;
  int? promotionId;

  Booking(this.id, this.userId, this.screeningId, this.price, this.promotionId);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
