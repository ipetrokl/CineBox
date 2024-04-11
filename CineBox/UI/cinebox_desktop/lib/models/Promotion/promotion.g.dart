// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      json['id'] as int?,
      json['code'] as String?,
      (json['discount'] as num?)?.toDouble(),
      json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'discount': instance.discount,
      'expirationDate': instance.expirationDate?.toIso8601String(),
    };
