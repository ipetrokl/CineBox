import 'package:cinebox_desktop/models/genre.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';

class GenreProvider extends BaseProvider<Genre> {
  GenreProvider() : super("Genre");

  @override
  Genre fromJson(data) {
    return Genre.fromJson(data);
  }
}
