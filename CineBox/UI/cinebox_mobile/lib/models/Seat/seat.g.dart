// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seat _$SeatFromJson(Map<String, dynamic> json) => Seat(
      type: $enumDecode(_$SeatTypeEnumMap, json['type']),
    )
      ..id = json['id'] as int?
      ..hallId = json['hallId'] as int?
      ..seatNumber = json['seatNumber'] as int?
      ..category = json['category'] as String?
      ..status = json['status'] as bool?;

Map<String, dynamic> _$SeatToJson(Seat instance) => <String, dynamic>{
      'id': instance.id,
      'hallId': instance.hallId,
      'seatNumber': instance.seatNumber,
      'category': instance.category,
      'status': instance.status,
      'type': _$SeatTypeEnumMap[instance.type],
    };

const _$SeatTypeEnumMap = {
  SeatType.single: 'single',
  SeatType.lovers: 'lovers',
  SeatType.disabled: 'disabled',
  SeatType.empty: 'empty',
};
