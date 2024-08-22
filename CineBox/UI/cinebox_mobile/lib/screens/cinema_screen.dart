import 'package:cinebox_mobile/models/Cinema/cinema.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/cinema_provider.dart';
import 'package:cinebox_mobile/screens/Movies/movie_list_screen.dart';
import 'package:cinebox_mobile/screens/log_in_screen.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CinemaScreen extends StatefulWidget {
  static const String routeName = "/cinema";
  CinemaScreen({super.key});

  @override
  State<CinemaScreen> createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  late CinemaProvider _cinemaProvider;
  late CartProvider _cartProvider;
  SearchResult<Cinema>? result;

  @override
  void initState() {
    super.initState();
    _cinemaProvider = context.read<CinemaProvider>();
    _cartProvider = context.read<CartProvider>();
    loadData();
  }

  Future loadData() async {
    try {
      var data = await _cinemaProvider.get();

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CineBox",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Tooltip(
            message: 'Sign out',
            child: IconButton(
              iconSize: 23,
              padding: EdgeInsets.only(right: 10),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _cartProvider.clearCart();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(97, 72, 199, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Choose cinema:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    const Divider(
                        thickness: 5, color: Color.fromRGBO(97, 72, 199, 1)),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 625,
                      child: GridView(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                        ),
                        scrollDirection: Axis.vertical,
                        children: _buildMovieCardList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMovieCardList() {
    if (result == null || result!.result.isEmpty) {
      return [Center(child: Text('No cinemas found.'))];
    }

    return result!.result.map((cinema) {
      return GestureDetector(
        onTap: () {
          DateTime currentDate = DateTime.now();
          Navigator.pushNamed(
            context,
            MovieListScreen.routeName,
            arguments: {'cinemaId': cinema.id, 'initialDate': currentDate, 'cinemaName': cinema.name},
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: const Color.fromRGBO(97, 72, 199, 1), width: 2),
          ),
          child: Center(
            child: Text(
              cinema.name!,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
