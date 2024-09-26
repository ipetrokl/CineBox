import 'dart:convert';
import 'package:cinebox_mobile/models/Actor/actor.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Review/review.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/providers/actor_provider.dart';
import 'package:cinebox_mobile/providers/logged_in_user_provider.dart';
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
  late ActorProvider _actorProvider;
  late MovieActorProvider _movieActorProvider;
  late ScreeningProvider _screeningProvider;
  late ReviewProvider _reviewProvider;
  SearchResult<Movie>? result;
  SearchResult<Review>? result2;
  List<Movie> result3 = List.empty();
  final TextEditingController _searchController = TextEditingController();
  late DateTime selectedDate;
  late LoggedInUserProvider _loggedInUserProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = widget.initialDate;
    _movieProvider = context.read<MovieProvider>();
    _actorProvider = context.read<ActorProvider>();
    _movieActorProvider = context.read<MovieActorProvider>();
    _screeningProvider = context.read<ScreeningProvider>();
    _reviewProvider = context.read<ReviewProvider>();
    _loggedInUserProvider = context.read<LoggedInUserProvider>();
    if (widget.message != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(widget.message!),
              backgroundColor: const Color.fromRGBO(97, 72, 199, 1)),
        );
      });
    }
    loadData();
  }

  Future loadData() async {
    try {
      var data = await _movieProvider.get(filter: {
        'cinemaId': widget.cinemaId,
        'selectedDate': selectedDate.toIso8601String()
      });
      var data2 = await _reviewProvider.get();
      var data3 = await _movieProvider.getRecommendedMovies(
          _loggedInUserProvider.user!.id!, selectedDate);

      setState(() {
        result = data;
        result2 = data2;
        result3 = data3;
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
            icon: const Icon(Icons.arrow_back, size: 15),
            onPressed: isBefore
                ? null
                : () {
                    _onDateSelected(
                        selectedDate.subtract(const Duration(days: 1)));
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
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
            icon: const Icon(Icons.arrow_forward, size: 15),
            onPressed: () {
              _onDateSelected(selectedDate.add(const Duration(days: 1)));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> filteredMovies = List.empty();

    if (result != null && result!.result.isNotEmpty) {
      filteredMovies = result!.result.where((movie) {
        return !result3
            .any((recommendedMovie) => recommendedMovie.id == movie.id);
      }).toList();
    }

    return MasterScreen(
      title: "Movies",
      cinemaId: widget.cinemaId,
      initialDate: widget.initialDate,
      cinemaName: widget.cinemaName,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/movie3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              _buildMovieSearch(),
              _buildDateNavigation(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (result3.isNotEmpty) ...[
                        _buildRecommender(),
                        ..._buildMovieCardList(result3),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Divider(
                            thickness: 2,
                            color: Color.fromARGB(255, 71, 52, 148),
                          ),
                        ),
                      ],
                      ..._buildMovieCardList(filteredMovies),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommender() {
    if (result3.isNotEmpty) {
      return Container(
        child: const Column(
          children: [
            Center(
              child: Text(
                "Recommended:",
                style: TextStyle(
                  color: Color.fromARGB(255, 71, 52, 148),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildMovieSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                prefixIcon: const Icon(Icons.search),
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

  List<Widget> _buildMovieCardList(List<Movie> movies) {
    if (movies.isEmpty) {
      return [const Center(child: Text('No movies found.'))];
    }

    return movies.map((movie) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
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
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.10),
                    ),
                    height: 230,
                    width: 140,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        child: Image(
                          image: movie.picture!.picture1 != null && movie.picture!.picture1 != ""
                              ? MemoryImage(base64Decode(movie.picture!.picture1!))
                              : const AssetImage("assets/images/empty.jpg")
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
                      const SizedBox(height: 15),
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
                                return const Text("");
                              } else if (snapshot.hasError) {
                                return const Text("Error");
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
                                return const SizedBox.shrink();
                              } else if (snapshot.hasError) {
                                return const Text("Error");
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
                      const SizedBox(
                        width: 40,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 35),
                          Text(
                            _buildStarRating(
                                _calculateAverageRating(movie.id!)),
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
                            return const SizedBox.shrink();
                          } else if (snapshot.hasError) {
                            return const Text("Error fetching screenings");
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
                                              style:
                                                  const TextStyle(fontSize: 12),
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
