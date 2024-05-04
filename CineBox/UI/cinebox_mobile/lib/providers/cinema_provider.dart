import 'package:cinebox_mobile/models/Cinema/cinema.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class CinemaProvider extends BaseProvider<Cinema> {
  CinemaProvider() : super("Cinema");

  @override
  Cinema fromJson(data) {
    return Cinema.fromJson(data);
  }
}
