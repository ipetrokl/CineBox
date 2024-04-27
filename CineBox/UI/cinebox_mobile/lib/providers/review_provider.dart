import 'package:cinebox_mobile/models/Review/review.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class ReviewProvider extends BaseProvider<Review> {
  ReviewProvider() : super("Review");

  @override
  Review fromJson(data) {
    return Review.fromJson(data);
  }
}