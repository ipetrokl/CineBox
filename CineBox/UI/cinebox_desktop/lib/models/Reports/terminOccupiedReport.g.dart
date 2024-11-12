// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminOccupiedReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminOccupiedReport _$TerminOccupiedReportFromJson(
        Map<String, dynamic> json) =>
    TerminOccupiedReport(
      screeningTime: json['screeningTime'] as String,
      movieTitle: json['movieTitle'] as String,
      totalBookedSeats: json['totalBookedSeats'] as int,
    );

Map<String, dynamic> _$TerminOccupiedReportToJson(
        TerminOccupiedReport instance) =>
    <String, dynamic>{
      'screeningTime': instance.screeningTime,
      'movieTitle': instance.movieTitle,
      'totalBookedSeats': instance.totalBookedSeats,
    };
