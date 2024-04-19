import 'package:cinebox_mobile/models/MovieActor/movieActor.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class MovieActorProvider extends BaseProvider<MovieActor> {
  MovieActorProvider() : super("MovieActor");

  @override
  MovieActor fromJson(data) {
    return MovieActor.fromJson(data);
  }
}