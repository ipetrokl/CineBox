
import 'package:cinebox_desktop/models/screening.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class ScreeningProvider extends BaseProvider<Screening> {
  ScreeningProvider() : super("Screening");

  @override
  Screening fromJson(data) {

    return Screening.fromJson(data);
  }
}