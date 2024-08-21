// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      json['id'] as int?,
      json['userId'] as int?,
      json['ticketCode'] as String?,
      json['qrCode'] as String?,
      (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'ticketCode': instance.ticketCode,
      'qrCode': instance.qrCode,
      'price': instance.price,
    };
