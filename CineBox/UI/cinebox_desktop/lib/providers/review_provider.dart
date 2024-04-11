import 'package:cinebox_desktop/models/Review/review.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class ReviewProvider extends BaseProvider<Review> {
  ReviewProvider() : super("Review");

  @override
  Review fromJson(data) {

    return Review.fromJson(data);
  }
}