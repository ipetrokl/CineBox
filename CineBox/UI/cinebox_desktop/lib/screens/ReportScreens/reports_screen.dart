import 'package:cinebox_desktop/models/Cinema/cinema.dart';
import 'package:cinebox_desktop/models/Reports/hallOccupancyReport.dart';
import 'package:cinebox_desktop/models/Reports/moviePopularityReport.dart';
import 'package:cinebox_desktop/models/Reports/terminOccupiedReport.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:cinebox_desktop/providers/hall_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/screening_provider.dart';
import 'package:cinebox_desktop/screens/ReportScreens/report_generator_movies.dart';
import 'package:cinebox_desktop/screens/ReportScreens/report_generator_seats.dart';
import 'package:cinebox_desktop/screens/ReportScreens/report_generator_termins.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DateTime _selectedDate = DateTime.now();
  SearchResult<Cinema>? result;
  Cinema? selectedCinema;
  int? cinemaId = 1;
  List<HallOccupancyReport> _seatsData = [];
  List<MoviePopularityReport> _moviesData = [];
  List<TerminOccupiedReport> _terminsData = [];
  late HallProvider _hallProvider;
  late CinemaProvider _cinemaProvider;
  late MovieProvider _movieProvider;
  late ScreeningProvider _screeningProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _hallProvider = context.read<HallProvider>();
    _cinemaProvider = context.read<CinemaProvider>();
    _movieProvider = context.read<MovieProvider>();
    _screeningProvider = context.read<ScreeningProvider>();
    _fetchCinemas();
  }

  Future<void> _fetchCinemas() async {
    try {
      var data = await _cinemaProvider.get();

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  void _fetchHalls() async {
    try {
      if (selectedCinema != null) {
        cinemaId = selectedCinema!.id;
      }
      var data = await _hallProvider.fetchHallOccupancyReport(
          _selectedDate, cinemaId!);

      setState(() {
        _seatsData = data;
      });

      if (_seatsData.isNotEmpty) {
        await generateSeatsReportPDF(
            _seatsData, _selectedDate, selectedCinema!.name!);
      }
    } catch (e) {
      print("Failed in fetching halls: $e");
    }
  }

  void _fetchMovies() async {
    try {
      var data = await _movieProvider.fetchMoviePopularityReport();

      setState(() {
        _moviesData = data;
      });

      if (_moviesData.isNotEmpty) {
        await generateMoviesReportPDF(_moviesData);
      }
    } catch (e) {
      print("Failed in fetching halls: $e");
    }
  }

  void _fetchTermins() async {
    try {
      var data = await _screeningProvider.fetchTerminOccupiedReport();

      setState(() {
        _terminsData = data;
      });

      if (_terminsData.isNotEmpty) {
        await generateTerminsReportPDF(_terminsData);
      }
    } catch (e) {
      print("Failed in fetching halls: $e");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(214, 212, 203, 1),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Reports',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, size: 20),
                    SizedBox(width: 5),
                    Text(
                      _selectedDate != null
                          ? 'Choose date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'
                          : 'Choose date',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                onTap: () => _selectDate(context),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      "Choose cinema: ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<Cinema>(
                    hint: Text("Select Cinema"),
                    value: selectedCinema,
                    onChanged: (Cinema? newCinema) {
                      setState(() {
                        selectedCinema = newCinema;
                      });
                    },
                    items: result?.result.map((cinema) {
                      return DropdownMenuItem<Cinema>(
                        value: cinema,
                        child: Text(cinema.name!),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Divider(thickness: 5),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(50, 125, 125, 125),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Text('Number of occupied seats per hall'),
                  trailing: IconButton(
                    icon: Icon(Icons.download),
                    iconSize: 35,
                    onPressed: () {
                      if (selectedCinema != null) {
                        _fetchHalls();
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please choose a cinema'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(50, 125, 125, 125),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Text('Top 3 most popular movies'),
                  trailing: IconButton(
                    icon: Icon(Icons.download),
                    iconSize: 35,
                    onPressed: () {
                      _fetchMovies();
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(50, 125, 125, 125),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Text('Most occupied termins'),
                  trailing: IconButton(
                    icon: Icon(Icons.download),
                    iconSize: 35,
                    onPressed: () {
                      _fetchTermins();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
