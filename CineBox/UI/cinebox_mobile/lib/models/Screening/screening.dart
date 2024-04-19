import 'package:json_annotation/json_annotation.dart';

part 'screening.g.dart';

@JsonSerializable()
class Screening {
  int? id;
  int? movieId;
  int? cinemaId;
  String? category;
  DateTime? startTime;
  DateTime? endTime;
  double? price;

  Screening();

  factory Screening.fromJson(Map<String, dynamic> json) =>
      _$ScreeningFromJson(json);

  Map<String, dynamic> toJson() => _$ScreeningToJson(this);
}