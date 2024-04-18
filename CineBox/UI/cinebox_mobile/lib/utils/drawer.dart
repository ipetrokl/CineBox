import 'package:cinebox_mobile/screens/Cart/cart_screen.dart';
import 'package:cinebox_mobile/screens/Movies/movie_list_screen.dart';
import 'package:flutter/material.dart';

class CineboxDrawer extends StatelessWidget {
  CineboxDrawer({Key? key}) : super(key: key);
  // CartProvider? _cartProvider;
  @override
  Widget build(BuildContext context) {
    // _cartProvider = context.watch<CartProvider>();
    print("called build drawer");
    return Drawer(
      backgroundColor: Colors.indigo,
      child: ListView(
        children: [
          ListTile(
            textColor: Colors.white,
            title: Text('Home'),
            onTap: () {
               Navigator.popAndPushNamed(context, MovieListScreen.routeName);
            },
          ),
          ListTile(
            textColor: Colors.white,
            // title: Text('Cart ${_cartProvider?.cart.items.length}'),
            title: Text("Cart"),
            onTap: () {
               Navigator.pushNamed(context, CartScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}