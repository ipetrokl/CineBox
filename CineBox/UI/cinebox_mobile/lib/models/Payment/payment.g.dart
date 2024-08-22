// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment()
  ..id = (json['id'] as num?)?.toInt()
  ..bookingId = (json['bookingId'] as num?)?.toInt()
  ..amount = (json['amount'] as num?)?.toDouble()
  ..paymentStatus = json['paymentStatus'] as String?;

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'amount': instance.amount,
      'paymentStatus': instance.paymentStatus,
    };
