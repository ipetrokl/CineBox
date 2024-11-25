import 'dart:convert';
import 'dart:ui';
import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/genre_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/picture_provider.dart';
import 'package:cinebox_desktop/screens/MovieScreens/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cinebox_desktop/models/Picture/picture.dart' as MyAppPicture;

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  SearchResult<Movie>? result;
  final TextEditingController _ftsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late MovieProvider _movieProvider;
  late GenreProvider _genreProvider;
  late PictureProvider _pictureProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _movieProvider = context.read<MovieProvider>();
    _genreProvider = context.read<GenreProvider>();
    _pictureProvider = context.read<PictureProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _movieProvider.get();

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(214, 212, 203, 1),
      child: Column(
        children: [_buildSearch(), _buildDataListView()],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Title or Genre"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Description"),
              controller: _descriptionController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              var data = await _movieProvider.get(filter: {
                'fts': _ftsController.text,
                'description': _descriptionController.text
              });

              setState(() {
                result = data;
              });
            },
            child: const Text("Search"),
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (_) => MovieDetailScreen(
                    onClose: () {
                      _fetchData();
                    },
                  ),
                );
              },
              child: const Text("Add"))
        ],
      ),
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Theme(
          data: Theme.of(context).copyWith(
              cardTheme: Theme.of(context).cardTheme.copyWith(
                    color: const Color.fromRGBO(220, 220, 206, 1),
                  )),
          child: PaginatedDataTable(
            header: const Center(
              child: Text('Movies'),
            ),
            columns: const [
              DataColumn(label: Text('Title')),
              DataColumn(label: Text('Description')),
              DataColumn(label: Text('Performed From')),
              DataColumn(label: Text('Performed To')),
              DataColumn(label: Text('Genre')),
              DataColumn(label: Text('Director')),
              DataColumn(label: Text('Picture')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(
                result?.result ?? [],
                _genreProvider,
                _pictureProvider,
                _showDeleteConfirmationDialog,
                _navigateToDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(Movie movie) {
    showDialog(
      context: context,
      builder: (_) => MovieDetailScreen(
        movie: movie,
        onClose: () {
          _fetchData();
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Are you sure you want to delete this record?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteRecord(id);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _movieProvider.delete(id);

      if (success) {
        var data = await _movieProvider.get();
        setState(() {
          result = data;
        });
      }
    } catch (e) {
      print("Error deleting data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete data. Please try again."),
        ),
      );
    }
  }
}

class DataTableSourceRows extends DataTableSource {
  final List<Movie> movies;
  final GenreProvider genreProvider;
  final PictureProvider pictureProvider;
  final Function(int) onDelete;
  final Function(Movie) onRowSelected;

  DataTableSourceRows(this.movies, this.genreProvider, this.pictureProvider,
      this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final movie = movies[index];
    final DateTime? performedFrom = movie.performedFrom;
    final DateTime? performedTo = movie.performedTo;
    final String formattedPerformedFrom = performedFrom != null
        ? DateFormat('yyyy-MM-dd').format(performedFrom)
        : "";
    final String formattedPerformedTo =
        performedTo != null ? DateFormat('yyyy-MM-dd').format(performedTo) : "";

    return DataRow(
      cells: [
        DataCell(Text(movie.title ?? '')),
        DataCell(Text(movie.description ?? '')),
        DataCell(Text(formattedPerformedFrom)),
        DataCell(Text(formattedPerformedTo)),
        DataCell(FutureBuilder<Genre?>(
          future: genreProvider.getById(movie.genreId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data?.name ?? '');
            } else {
              return const CircularProgressIndicator();
            }
          },
        )),
        DataCell(Text(movie.director ?? '')),
        DataCell(
          FutureBuilder<MyAppPicture.Picture?>(
            future: movie.pictureId != null
                ? pictureProvider.getById(movie.pictureId!)
                : null,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: 40,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      image: snapshot.data?.picture1 != null &&
                              snapshot.data?.picture1 != ""
                          ? MemoryImage(base64Decode(snapshot.data!.picture1!))
                          : AssetImage("assets/images/empty.jpg")
                              as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error loading picture');
              } else {
                return Container(
                  width: 40,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const Image(
                      image: AssetImage("assets/images/empty.jpg")
                          as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            },
          ),
        ),
        DataCell(IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => onDelete(movie.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(movie);
        }
      },
    );
  }

  @override
  int get rowCount => movies.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
