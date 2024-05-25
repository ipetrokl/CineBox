// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookingSeat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingSeat _$BookingSeatFromJson(Map<String, dynamic> json) => BookingSeat(
      json['bookingSeatId'] as int?,
      json['bookingId'] as int?,
      json['seatId'] as int?,
    );

Map<String, dynamic> _$BookingSeatToJson(BookingSeat instance) =>
    <String, dynamic>{
      'bookingSeatId': instance.bookingSeatId,
      'bookingId': instance.bookingId,
      'seatId': instance.seatId,
    };
