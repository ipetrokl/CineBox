import 'package:cinebox_mobile/models/Cart/cart.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/models/Seat/seat.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

class CartProvider with ChangeNotifier {
  Cart cart = Cart();
  double sum = 0;
  addToCart(Movie movie, Screening screening, int cinemaId, List<Seat> selectedSeats, int count) {
    var existingItem = findInCart(movie, screening);

    if (existingItem != null) {
      existingItem.count = count;
    } else {
      cart.items.add(CartItem(movie, count, screening, cinemaId, selectedSeats));
    }

    notifyListeners();
  }

  removeFromSum(Movie movie, Screening screening) {
      sum -= screening.price! * findInCart(movie, screening)!.count;
    notifyListeners();
  }

  CartItem? findInCart(Movie movie, Screening screening) {
    CartItem? existingItem = cart.items.firstWhereOrNull((item) =>
        item.movie.id == movie.id && item.screening.id == screening.id);
    return existingItem;
  }

  void clearCart() {
    cart.items.clear();
    sum = 0;
    notifyListeners();
  }
}
