// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookingSeat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingSeat _$BookingSeatFromJson(Map<String, dynamic> json) => BookingSeat(
      (json['bookingSeatId'] as num?)?.toInt(),
      (json['bookingId'] as num?)?.toInt(),
      (json['seatId'] as num?)?.toInt(),
      json['booking'] == null
          ? null
          : Booking.fromJson(json['booking'] as Map<String, dynamic>),
      json['seat'] == null
          ? null
          : Seat.fromJson(json['seat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingSeatToJson(BookingSeat instance) =>
    <String, dynamic>{
      'bookingSeatId': instance.bookingSeatId,
      'bookingId': instance.bookingId,
      'seatId': instance.seatId,
      'booking': instance.booking,
      'seat': instance.seat,
    };
