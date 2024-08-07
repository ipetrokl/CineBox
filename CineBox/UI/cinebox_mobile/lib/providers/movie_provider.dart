import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class MovieProvider extends BaseProvider<Movie> {
  MovieProvider() : super("Movie");

  @override
  Movie fromJson(data) {
    return Movie.fromJson(data);
  }
}
