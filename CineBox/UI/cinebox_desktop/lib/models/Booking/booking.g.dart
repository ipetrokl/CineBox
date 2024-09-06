// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      json['id'] as int?,
      json['userId'] as int?,
      json['screeningId'] as int?,
      (json['price'] as num?)?.toDouble(),
      json['promotionId'] as int?,
      json['screening'] == null
          ? null
          : Screening.fromJson(json['screening'] as Map<String, dynamic>),
      json['promotion'] == null
          ? null
          : Promotion.fromJson(json['promotion'] as Map<String, dynamic>),
      json['users'] == null
          ? null
          : Users.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'screeningId': instance.screeningId,
      'price': instance.price,
      'promotionId': instance.promotionId,
      'screening': instance.screening,
      'promotion': instance.promotion,
      'users': instance.users,
    };
