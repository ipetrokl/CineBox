// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket()
  ..id = json['id'] as int?
  ..bookingId = json['bookingId'] as int?
  ..ticketCode = json['ticketCode'] as String?
  ..qrCode = json['qrCode'] as String?
  ..price = (json['price'] as num?)?.toDouble();

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'ticketCode': instance.ticketCode,
      'qrCode': instance.qrCode,
      'price': instance.price,
    };
