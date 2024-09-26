import 'package:cinebox_mobile/models/Picture/picture.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class PictureProvider extends BaseProvider<Picture> {
  PictureProvider() : super("Picture");

  @override
  Picture fromJson(data) {
    return Picture.fromJson(data);
  }
}