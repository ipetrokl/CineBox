// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seat _$SeatFromJson(Map<String, dynamic> json) => Seat(
      json['id'] as int?,
      json['hallId'] as int?,
      json['seatNumber'] as int?,
      json['category'] as String?,
      json['status'] as bool?,
    );

Map<String, dynamic> _$SeatToJson(Seat instance) => <String, dynamic>{
      'id': instance.id,
      'hallId': instance.hallId,
      'seatNumber': instance.seatNumber,
      'category': instance.category,
      'status': instance.status,
    };
