import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class ScreeningProvider extends BaseProvider<Screening> {
  ScreeningProvider() : super("Screening");

  @override
  Screening fromJson(data) {
    return Screening.fromJson(data);
  }
}