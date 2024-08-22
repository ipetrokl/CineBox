// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion()
  ..id = (json['id'] as num?)?.toInt()
  ..code = json['code'] as String?
  ..discount = (json['discount'] as num?)?.toDouble()
  ..expirationDate = json['expirationDate'] == null
      ? null
      : DateTime.parse(json['expirationDate'] as String);

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'discount': instance.discount,
      'expirationDate': instance.expirationDate?.toIso8601String(),
    };
