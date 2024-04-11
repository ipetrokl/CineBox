import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  int? id;
  int? bookingId;
  String? ticketCode;
  String? qrCode;
  double? price;

  Ticket(this.id, this.bookingId, this.ticketCode, this.qrCode, this.price);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
