import 'package:cinebox_mobile/screens/Cart/cart_screen.dart';
import 'package:cinebox_mobile/screens/Movies/movie_list_screen.dart';
import 'package:cinebox_mobile/screens/Promotion/promotion_screen.dart';
import 'package:cinebox_mobile/screens/cinema_screen.dart';
import 'package:flutter/material.dart';

class CineboxDrawer extends StatelessWidget {
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;

  const CineboxDrawer(
      {super.key, required this.cinemaId, required this.initialDate, required this.cinemaName});
  // CartProvider? _cartProvider;
  @override
  Widget build(BuildContext context) {
    // _cartProvider = context.watch<CartProvider>();
    return Drawer(
      backgroundColor: const Color.fromRGBO(97, 72, 199, 1),
      width: MediaQuery.of(context).size.width * 0.5,
      child: ListView(
        children: [
          ListTile(
            textColor: Colors.white,
            title: const Text('Cinema'),
            onTap: () {
              Navigator.pushNamed(context, CinemaScreen.routeName);
            },
          ),
          ListTile(
            textColor: Colors.white,
            // title: Text('Cart ${_cartProvider?.cart.items.length}'),
            title: const Text("Promo codes"),
            onTap: () {
              Navigator.pushNamed(context, PromotionScreen.routeName,
                  arguments: {
                    'cinemaId': cinemaId,
                    'initialDate': initialDate,
                    'cinemaName': cinemaName
                  });
            },
          ),
        ],
      ),
    );
  }
}
