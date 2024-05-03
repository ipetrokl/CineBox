import 'package:cinebox_mobile/models/Promotion/promotion.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class PromotionProvider extends BaseProvider<Promotion> {
  PromotionProvider() : super("Promotion");

  @override
  Promotion fromJson(data) {
    return Promotion.fromJson(data);
  }
}