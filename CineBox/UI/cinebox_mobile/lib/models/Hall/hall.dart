import 'package:cinebox_mobile/models/Cinema/cinema.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hall.g.dart';

@JsonSerializable()
class Hall {
  int? id;
  int? cinemaId;
  String? name;
  Cinema? cinema;

  Hall();

  factory Hall.fromJson(Map<String, dynamic> json) => _$HallFromJson(json);

  Map<String, dynamic> toJson() => _$HallToJson(this);
}
