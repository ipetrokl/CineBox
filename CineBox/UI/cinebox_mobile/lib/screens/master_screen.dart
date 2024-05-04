import 'package:badges/badges.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/screens/Cart/cart_screen.dart';
import 'package:cinebox_mobile/screens/Movies/movie_list_screen.dart';
import 'package:cinebox_mobile/screens/cinema_screen.dart';
import 'package:cinebox_mobile/screens/log_in_screen.dart';
import 'package:cinebox_mobile/utils/drawer.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';

class MasterScreen extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreen({this.child, this.title, super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  late CartProvider _cartProvider;
  int currentIndex = 0;

  int _calculateTotalSelectedScreeningsCount() {
    _cartProvider = context.watch<CartProvider>();
    int totalCount = 0;
    for (var item in _cartProvider.cart.items) {
      totalCount += item.count;
    }
    return totalCount;
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    if (currentIndex == 0) {
      Navigator.pushNamed(context, CinemaScreen.routeName);
    } else if (currentIndex == 1) {
      Navigator.pushNamed(context, CartScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CineBox"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        actions: <Widget>[
          Tooltip(
            message: 'Sign out',
            child: IconButton(
              iconSize: 23,
              padding: EdgeInsets.only(right: 10),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(97, 72, 199, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: CineboxDrawer(),
      body: SafeArea(
        child: widget.child!,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(97, 72, 199, 1),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 60,
              child: Stack(
                children: <Widget>[
                  Center(child: Icon(Icons.shopping_bag)),
                  if (_calculateTotalSelectedScreeningsCount() > 0)
                    Positioned(
                      right: 1,
                      top: 0,
                      child: Badge(
                        badgeContent: SizedBox(
                          width: 16,
                          child: Center(
                            child: Text(
                              _calculateTotalSelectedScreeningsCount()
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        badgeStyle: BadgeStyle(
                            badgeColor: Colors.purple.shade300,
                            padding: EdgeInsets.all(3)),
                        position: BadgePosition.topEnd(top: 0, end: 0),
                      ),
                    ),
                ],
              ),
            ),
            label: 'Cart',
          ),
        ],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
