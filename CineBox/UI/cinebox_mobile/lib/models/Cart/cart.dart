import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';

class Cart {
  List<CartItem> items = [];
}

class CartItem {
  late Movie movie;
  late int count;
  late Screening screening;
  late int cinemaId;
  CartItem(this.movie, this.count, this.screening, this.cinemaId);
}
