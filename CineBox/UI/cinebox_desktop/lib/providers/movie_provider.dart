
import 'package:cinebox_desktop/models/movie.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class MovieProvider extends BaseProvider<Movie> {
  MovieProvider() : super("Movie");

  @override
  Movie fromJson(data) {

    return Movie.fromJson(data);
  }
}
