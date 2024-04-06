
import 'package:cinebox_desktop/models/cinema.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class CinemaProvider extends BaseProvider<Cinema> {
  CinemaProvider() : super("Cinema");

  @override
  Cinema fromJson(data) {

    return Cinema.fromJson(data);
  }
}