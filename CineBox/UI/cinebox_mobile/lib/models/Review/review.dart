import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  int? id;
  int? userId;
  int? movieId;
  double? rating;
  String? comment;

  Review();


  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);


  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}