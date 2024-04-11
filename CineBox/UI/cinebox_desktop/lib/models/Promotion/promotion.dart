import 'package:json_annotation/json_annotation.dart';

part 'promotion.g.dart';

@JsonSerializable()
class Promotion {
  int? id;
  String? code;
  double? discount;
  DateTime? expirationDate;

  Promotion(this.id, this.code, this.discount, this.expirationDate);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Promotion.fromJson(Map<String, dynamic> json) => _$PromotionFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}