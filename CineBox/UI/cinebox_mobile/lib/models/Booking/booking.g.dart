// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      (json['id'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      (json['screeningId'] as num?)?.toInt(),
      (json['price'] as num?)?.toDouble(),
      (json['promotionId'] as num?)?.toInt(),
    )
      ..screening = json['screening'] == null
          ? null
          : Screening.fromJson(json['screening'] as Map<String, dynamic>)
      ..bookingSeats = (json['bookingSeats'] as List<dynamic>?)
          ?.map((e) => BookingSeat.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'screeningId': instance.screeningId,
      'price': instance.price,
      'promotionId': instance.promotionId,
      'screening': instance.screening,
      'bookingSeats': instance.bookingSeats,
    };
