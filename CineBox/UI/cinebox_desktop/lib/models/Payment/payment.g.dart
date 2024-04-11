// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      json['id'] as int?,
      json['bookingId'] as int?,
      (json['amount'] as num?)?.toDouble(),
      json['paymentStatus'] as String?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'amount': instance.amount,
      'paymentStatus': instance.paymentStatus,
    };
