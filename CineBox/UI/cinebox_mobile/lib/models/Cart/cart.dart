import 'package:cinebox_mobile/models/Movie/movie.dart';

class Cart {
  List<CartItem> items = [];
}

class CartItem {
  late Movie movie;
  late int count;
  CartItem(this.movie, this.count);
}
