import 'package:cinebox_mobile/models/Cart/cart.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

class CartProvider with ChangeNotifier {
  Cart cart = Cart();
  addToCart(Movie movie) {
    if (findInCart(movie) != null) {
      findInCart(movie)?.count++;
    } else {
      cart.items.add(CartItem(movie, 1));
    }

    notifyListeners();
  }

  removeFromCart(Movie movie) {
    cart.items.removeWhere((item) => item.movie.id == movie.id);
    notifyListeners();
  }

  CartItem? findInCart(Movie movie) {
    CartItem? item =
        cart.items.firstWhereOrNull((item) => item.movie.id == movie.id);
    return item;
  }
}
