import 'dart:convert';

import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/movie_provider.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:cinebox_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  static const String routeName = "/movie";
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _movieListScreenState();
}

class _movieListScreenState extends State<MovieListScreen> {
  late MovieProvider _movieProvider;
  late CartProvider _cartProvider;
  SearchResult<Movie>? result;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieProvider = context.read<MovieProvider>();
    _cartProvider = context.read<CartProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    try {
      var data = await _movieProvider.get();

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("called build $result");
    return MasterScreen(
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMovieSearch(),
              SizedBox(
                height: 627,
                child: GridView(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 30,
                  ),
                  scrollDirection: Axis.vertical,
                  children: _buildMovieCardList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) async {
                var tmpData = await _movieProvider.get(filter: {'fts': value});
                setState(() {
                  result = tmpData;
                });
              },
              decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  )),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () async {
              var tmpData = await _movieProvider
                  .get(filter: {'fts': _searchController.text});
              setState(() {
                result = tmpData;
              });
            },
          ),
        )
      ],
    );
  }

  List<Widget> _buildMovieCardList() {
    if (result == null || result!.result.isEmpty) {
      return [Center(child: Text('No movies found.'))];
    }

    return result!.result.map((movie) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 2)),
        child: GestureDetector(
          onTap: () {
            // Ovdje dodajte akciju koja će se izvršiti kada korisnik pritisne karticu filma
          },
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context,
                  //     "${ProductDetailsScreen.routeName}/${x.proizvodId}");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Colors.blue,
                  ),
                  height: 260,
                  width: 140,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child: Image(
                        image: movie.picture != null && movie.picture != ""
                            ? MemoryImage(base64Decode(movie.picture!))
                            : AssetImage("assets/images/empty.jpg")
                                as ImageProvider<Object>,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    "Shutter Island",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Actors:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Ante K, Matej J",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Director:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "Silvio P.",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Performed:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "03.03.2023. - 03.04.2023.",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        "* * * * *",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(7)),
                        width: 55,
                        child: InkWell(
                          onTap: () {
                            _cartProvider.addToCart(movie);
                          },
                          child: const Text(
                            textAlign: TextAlign.center,
                            "16:30",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(7)),
                        width: 55,
                        child: InkWell(
                          onTap: () {
                            _cartProvider.addToCart(movie);
                          },
                          child: const Text(
                            textAlign: TextAlign.center,
                            "18:00",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(7)),
                        width: 55,
                        child: InkWell(
                          onTap: () {
                            _cartProvider.addToCart(movie);
                          },
                          child: const Text(
                            textAlign: TextAlign.center,
                            "22:00",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 25,
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Hall 4",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }).toList();
  }
}
