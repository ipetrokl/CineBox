import 'dart:convert';
import 'dart:math';
import 'package:cinebox_mobile/models/Actor/actor.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Review/review.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/providers/actor_provider.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/hall_provider.dart';
import 'package:cinebox_mobile/providers/movie_actor_provider.dart';
import 'package:cinebox_mobile/providers/movie_provider.dart';
import 'package:cinebox_mobile/providers/review_provider.dart';
import 'package:cinebox_mobile/providers/screening_provider.dart';
import 'package:cinebox_mobile/screens/Review/review_add_screen.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:cinebox_mobile/screens/screening_screen.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  static const String routeName = "/movie";
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;
  final String? message;

  const MovieListScreen(
      {super.key,
      required this.cinemaId,
      required this.initialDate,
      required this.cinemaName,
      this.message});

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
  late HallProvider _hallProvider;
  SearchResult<Movie>? result;
  SearchResult<Review>? result2;
  final TextEditingController _searchController = TextEditingController();
  late DateTime selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = widget.initialDate;
    _movieProvider = context.read<MovieProvider>();
    _cartProvider = context.read<CartProvider>();
    _actorProvider = context.read<ActorProvider>();
    _movieActorProvider = context.read<MovieActorProvider>();
    _screeningProvider = context.read<ScreeningProvider>();
    _reviewProvider = context.read<ReviewProvider>();
    _hallProvider = context.read<HallProvider>();
    if (widget.message != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.message!),
            backgroundColor: const Color.fromRGBO(97, 72, 199, 1)
          ),
        );
      });
    }
    print("called initState");
    loadData();
  }

  Future loadData() async {
    try {
      var data = await _movieProvider.get(filter: {
        'cinemaId': widget.cinemaId,
        'selectedDate': selectedDate.toIso8601String()
      });
      var data2 = await _reviewProvider.get();

      setState(() {
        result = data;
        result2 = data2;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      loadData();
    });
  }

  Widget _buildDateNavigation() {
    DateTime today = DateTime.now();
    bool isBefore = selectedDate.isBefore(today);
    List<DateTime> dates = List.generate(
        5, (index) => selectedDate.add(Duration(days: index - 2)));
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, size: 15),
            onPressed: isBefore
                ? null
                : () {
                    _onDateSelected(selectedDate.subtract(Duration(days: 1)));
                  },
          ),
          Flexible(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: dates.map((date) {
                bool isSelected = date.isAtSameMomentAs(selectedDate);
                bool isBeforeToday =
                    date.isBefore(DateTime(today.year, today.month, today.day));
                return GestureDetector(
                  onTap: isBeforeToday ? null : () => _onDateSelected(date),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color.fromRGBO(97, 72, 199, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      DateFormat('dd.MM.').format(date),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : isBeforeToday
                                ? Colors.grey
                                : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, size: 15),
            onPressed: () {
              _onDateSelected(selectedDate.add(Duration(days: 1)));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double navigationBarHeight = MediaQuery.of(context).padding.bottom;
    double availableScreenHeight =
        screenHeight - statusBarHeight - navigationBarHeight;
    return MasterScreen(
      title: "Movies",
      cinemaId: widget.cinemaId,
      initialDate: widget.initialDate,
      cinemaName: widget.cinemaName,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 1,
              image: AssetImage("assets/images/movie3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              _buildMovieSearch(),
              _buildDateNavigation(),
              Container(
                height: availableScreenHeight - 199,
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
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) async {
                var tmpData = await _movieProvider.get(filter: {
                  'fts': value,
                  'cinemaID': widget.cinemaId,
                  'selectedDate': DateFormat('yyyy-MM-dd').format(selectedDate)
                });
                setState(() {
                  result = tmpData;
                });
              },
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.indigo.withAlpha(80),
                  ),
                ),
              ),
            ),
          ),
        ),
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
            border: Border.all(
                color: const Color.fromRGBO(97, 72, 199, 1), width: 2)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white.withOpacity(0.6),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context,
                  //     "${ProductDetailsScreen.routeName}/${x.proizvodId}");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Colors.white.withOpacity(0.10),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        movie.title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Actors:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: FutureBuilder<List<Actor>>(
                          future: getActors(movie.id!),
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Director:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        movie.director!,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Performed:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: FutureBuilder<String>(
                          future: _formatPerformed(movie),
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
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 35),
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
                        const SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                    FutureBuilder<SearchResult<Screening>>(
                      future: _fetchScreeningsforMovie(movie, selectedDate),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox.shrink();
                        } else if (snapshot.hasError) {
                          return Text("Error fetching screenings");
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: SizedBox(
                              height: 35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.result.length,
                                itemBuilder: (context, index) {
                                  Screening screening =
                                      snapshot.data!.result[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => ScreeningScreen(
                                            onChanged: (int value) {},
                                            movie: movie,
                                            screening: screening,
                                            cinemaId: widget.cinemaId,
                                          ),
                                        );
                                        // _cartProvider.addToCart(
                                        //     movie, screening, widget.cinemaId);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(20),
                                          border: Border.all(
                                              width: 1,
                                              color: const Color.fromRGBO(
                                                  97, 72, 199, 1)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        width: 55,
                                        height: 35,
                                        child: Center(
                                          child: Text(
                                            DateFormat('HH:mm').format(
                                                screening.screeningTime!),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
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

  Future<List<Actor>> getActors(int movieId) async {
    var movieActors =
        await _movieActorProvider.get(filter: {'movieId': movieId});
    List<Actor> actors = [];
    for (var movieActor in movieActors.result) {
      var actor = await _actorProvider.getById(movieActor.actorId!);
      actors.add(actor!);
    }
    return actors;
  }

  String _buildActorNames(List<Actor> actors) {
    if (actors.isEmpty) {
      return '';
    }
    return actors.map((actor) => actor.name).join(", ");
  }

  Future<String> _formatPerformed(Movie movie) async {
    var startDate = DateFormat('dd.MM.yyyy').format(movie.performedFrom!);
    var endDate = DateFormat('dd.MM.yyyy').format(movie.performedTo!);
    String result = "$startDate - $endDate";

    return result;
  }

  Future<SearchResult<Screening>> _fetchScreeningsforMovie(
      Movie movie, DateTime selectedDate) async {
    var data = await _screeningProvider.get(filter: {
      'cinemaId': widget.cinemaId,
      'movieId': movie.id,
      'selectedDate': selectedDate
    });
    return data;
  }
}
