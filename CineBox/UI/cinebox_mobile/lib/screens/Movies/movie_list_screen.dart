import 'dart:convert';
import 'package:cinebox_mobile/models/Actor/actor.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Review/review.dart';
import 'package:cinebox_mobile/providers/actor_provider.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/movie_actor_provider.dart';
import 'package:cinebox_mobile/providers/movie_provider.dart';
import 'package:cinebox_mobile/providers/review_provider.dart';
import 'package:cinebox_mobile/providers/screening_provider.dart';
import 'package:cinebox_mobile/screens/Review/review_add_screen.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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
  late ActorProvider _actorProvider;
  late MovieActorProvider _movieActorProvider;
  late ScreeningProvider _screeningProvider;
  late ReviewProvider _reviewProvider;
  SearchResult<Movie>? result;
  SearchResult<Review>? result2;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieProvider = context.read<MovieProvider>();
    _cartProvider = context.read<CartProvider>();
    _actorProvider = context.read<ActorProvider>();
    _movieActorProvider = context.read<MovieActorProvider>();
    _screeningProvider = context.read<ScreeningProvider>();
    _reviewProvider = context.read<ReviewProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    try {
      var data = await _movieProvider.get();
      var data2 = await _reviewProvider.get();

      setState(() {
        result = data;
        result2 = data2;
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
                height: 575,
                child: GridView(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.6,
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
                    movie.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Actors:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                    child: FutureBuilder<List<Actor>>(
                      future: _fetchActorsForMovie(movie.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("");
                        } else if (snapshot.hasError) {
                          return Text("Error");
                        } else {
                          return Text(
                            _buildActorNames(snapshot.data!),
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Director:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    movie.director!,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Performed:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                    child: FutureBuilder<String>(
                      future: _fetchScreeningForMovie(movie),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox.shrink();
                        } else if (snapshot.hasError) {
                          return Text("Error");
                        } else {
                          return Text(
                            snapshot.data!,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        _buildStarRating(_calculateAverageRating(movie.id!)),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (_) => ReviewAddScreen(
                              movieId: movie.id!,
                              onClose: () {
                                loadData();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Review",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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
                    padding: EdgeInsets.only(top: 5),
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

  String _buildStarRating(double rating) {
    int numberOfFilledStars = rating.ceil();
    int numberOfEmptyStars = 5 - numberOfFilledStars;

    String filledStars = '★' * numberOfFilledStars;
    String emptyStars = '☆' * numberOfEmptyStars;

    return filledStars + emptyStars;
  }

  double _calculateAverageRating(int movieId) {
    if (result2!.result.isEmpty) {
      return 0.0;
    }
    double totalRating = 0.0;
    int arrayLength = 0;
    for (var review in result2!.result) {
      if (movieId == review.movieId) {
        totalRating += review.rating!;
        arrayLength++;
      }
    }
    if (arrayLength != 0) {
      return totalRating / arrayLength;
    } else {
      return 0.0;
    }
  }

  Future<List<Actor>> _fetchActorsForMovie(int movieId) async {
    var movieActors =
        await _movieActorProvider.get(filter: {'movieId': movieId});
    var actorIds =
        movieActors.result.map((movieActor) => movieActor.actorId).toList();

    var actorsForMovie = <Actor>[];
    for (var actorId in actorIds) {
      var actor = await _actorProvider.getById(actorId!);
      if (actor != null) {
        actorsForMovie.add(actor);
      }
    }

    return actorsForMovie;
  }

  String _buildActorNames(List<Actor> actors) {
    if (actors.isEmpty) {
      return '';
    }
    return actors.map((actor) => actor.name).join(", ");
  }

  Future<String> _fetchScreeningForMovie(Movie movie) async {

      var startDate = DateFormat('dd-MM-yyyy').format(movie.performedFrom!);
      var endDate = DateFormat('dd-MM-yyyy').format(movie.performedTo!);
      String result = "$startDate - $endDate";

    return result;
  }
}
