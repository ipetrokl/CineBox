import 'package:cinebox_mobile/models/Hall/hall.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'screening.g.dart';

@JsonSerializable()
class Screening {
  int? id;
  int? movieId;
  int? hallId;
  String? category;
  DateTime? screeningTime;
  double? price;
  Hall? hall;
  Movie? movie;

  Screening(this.id, this.movieId, this.hallId, this.category, this.screeningTime, this.price, this.hall, this.movie);

  factory Screening.fromJson(Map<String, dynamic> json) =>
      _$ScreeningFromJson(json);

  Map<String, dynamic> toJson() => _$ScreeningToJson(this);
}
