// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hallOccupancyReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HallOccupancyReport _$HallOccupancyReportFromJson(Map<String, dynamic> json) =>
    HallOccupancyReport(
      hallName: json['hallName'] as String,
      occupiedSeats: json['occupiedSeats'] as int,
      totalSeats: json['totalSeats'] as int,
    );

Map<String, dynamic> _$HallOccupancyReportToJson(
        HallOccupancyReport instance) =>
    <String, dynamic>{
      'hallName': instance.hallName,
      'occupiedSeats': instance.occupiedSeats,
      'totalSeats': instance.totalSeats,
    };
