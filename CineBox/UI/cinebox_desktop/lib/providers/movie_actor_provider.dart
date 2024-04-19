import 'package:cinebox_desktop/models/MovieActor/movieActor.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class MovieActorProvider extends BaseProvider<MovieActor> {
  MovieActorProvider() : super("MovieActor");

  @override
  MovieActor fromJson(data) {

    return MovieActor.fromJson(data);
  }
}