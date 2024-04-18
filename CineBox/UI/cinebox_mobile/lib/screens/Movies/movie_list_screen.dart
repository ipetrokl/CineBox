import 'dart:convert';

import 'package:cinebox_mobile/models/Movie/movie.dart';
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
  SearchResult<Movie>? result;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieProvider = context.read<MovieProvider>();
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
              Text(movie.title ?? ""),
              Text(movie.director ?? ""),
              // IconButton(
              //   icon: Icon(Icons.shopping_cart),
              //   onPressed: () {
              //     // _cartProvider?.addToCart(x);
              //   },
              // )
            ],
          ),
        ),
      );
    }).toList();
  }
}
