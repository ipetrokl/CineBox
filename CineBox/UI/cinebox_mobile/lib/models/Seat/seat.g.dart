// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seat _$SeatFromJson(Map<String, dynamic> json) => Seat()
  ..id = (json['id'] as num?)?.toInt()
  ..hallId = (json['hallId'] as num?)?.toInt()
  ..seatNumber = (json['seatNumber'] as num?)?.toInt()
  ..category = json['category'] as String?
  ..status = json['status'] as bool?
  ..hall = json['hall'] == null
      ? null
      : Hall.fromJson(json['hall'] as Map<String, dynamic>);

Map<String, dynamic> _$SeatToJson(Seat instance) => <String, dynamic>{
      'id': instance.id,
      'hallId': instance.hallId,
      'seatNumber': instance.seatNumber,
      'category': instance.category,
      'status': instance.status,
      'hall': instance.hall,
    };
