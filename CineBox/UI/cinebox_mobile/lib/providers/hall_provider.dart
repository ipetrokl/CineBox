import 'package:cinebox_mobile/models/Hall/hall.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class HallProvider extends BaseProvider<Hall> {
  HallProvider() : super("Hall");

 @override
  Hall fromJson(data) {
    return Hall.fromJson(data);
  }
}