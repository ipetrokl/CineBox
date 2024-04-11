import 'package:cinebox_desktop/models/Hall/hall.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class HallProvider extends BaseProvider<Hall> {
  HallProvider() : super("Hall");

  @override
  Hall fromJson(data) {

    return Hall.fromJson(data);
  }
}