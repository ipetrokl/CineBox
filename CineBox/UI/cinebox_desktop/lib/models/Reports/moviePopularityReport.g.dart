// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moviePopularityReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviePopularityReport _$MoviePopularityReportFromJson(
        Map<String, dynamic> json) =>
    MoviePopularityReport(
      movieName: json['movieName'] as String,
      bookingCount: json['bookingCount'] as int,
    );

Map<String, dynamic> _$MoviePopularityReportToJson(
        MoviePopularityReport instance) =>
    <String, dynamic>{
      'movieName': instance.movieName,
      'bookingCount': instance.bookingCount,
    };
