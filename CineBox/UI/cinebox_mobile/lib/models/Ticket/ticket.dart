import 'package:cinebox_mobile/models/Booking/booking.dart';
import 'package:cinebox_mobile/models/BookingSeat/bookingSeat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  int? id;
  String? ticketCode;
  String? qrCode;
  double? price;
  int? bookingSeatId;
  BookingSeat? bookingSeat;

  Ticket();

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
