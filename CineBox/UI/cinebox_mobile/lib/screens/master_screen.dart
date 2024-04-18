import 'package:cinebox_mobile/screens/Cart/cart_screen.dart';
import 'package:cinebox_mobile/screens/Movies/movie_list_screen.dart';
import 'package:cinebox_mobile/utils/drawer.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreen({this.child, this.title, super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  int currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    if (currentIndex == 0) {
      Navigator.pushNamed(context, MovieListScreen.routeName);
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
        backgroundColor: const Color.fromARGB(255, 21, 36, 118),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: CineboxDrawer(),
      body: SafeArea(
        child: widget.child!,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 21, 36, 118),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
        ],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.pink[300],
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
