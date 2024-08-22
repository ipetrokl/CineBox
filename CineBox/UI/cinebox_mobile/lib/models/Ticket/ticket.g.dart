// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket()
  ..id = (json['id'] as num?)?.toInt()
  ..ticketCode = json['ticketCode'] as String?
  ..qrCode = json['qrCode'] as String?
  ..price = (json['price'] as num?)?.toDouble()
  ..bookingSeatId = (json['bookingSeatId'] as num?)?.toInt()
  ..bookingSeat = json['bookingSeat'] == null
      ? null
      : BookingSeat.fromJson(json['bookingSeat'] as Map<String, dynamic>);

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'ticketCode': instance.ticketCode,
      'qrCode': instance.qrCode,
      'price': instance.price,
      'bookingSeatId': instance.bookingSeatId,
      'bookingSeat': instance.bookingSeat,
    };
