import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/genre_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/screens/MovieScreens/movie_detail_screen.dart';
import 'package:cinebox_desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _movieProvider = context.read<MovieProvider>();
    _genreProvider = context.read<GenreProvider>();
    _fetchMovies();
  }

  void _fetchMovies() async {
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
    return Container(
      color: const Color.fromRGBO(220, 220, 206, 1),
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
              print("Back proceed");
              //Navigator.of(context).pop();
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //       builder: (context) => const MovieDetailScreen()),
              // );

              var data = await _movieProvider.get(filter: {
                'fts': _ftsController.text,
                'description': _descriptionController.text
              });

              setState(() {
                result = data;
              });
              // print("data: ${data.result[0].title}");
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
                  builder: (_) => Dialog(
                    insetPadding: const EdgeInsets.all(200),
                    child: MovieDetailScreen(),
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
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Title')),
              DataColumn(label: Text('Description')),
              DataColumn(label: Text('Release Date')),
              DataColumn(label: Text('Duration')),
              DataColumn(label: Text('Genre')),
              DataColumn(label: Text('Director')),
              DataColumn(label: Text('Picture')),
              DataColumn(label: Text('Actions')),
            ],
            source: MovieDataTableSource(result?.result ?? [], _genreProvider,
                _deleteRecord, _navigateToMovieDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToMovieDetail(Movie movie) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(200),
        child: MovieDetailScreen(movie: movie),
      ),
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
      print("Error deleting genre: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete genre. Please try again."),
        ),
      );
    }
  }
}

class MovieDataTableSource extends DataTableSource {
  final List<Movie> movies;
  final GenreProvider genreProvider;
  final Function(int) onDelete;
  final Function(Movie) onRowSelected;

  MovieDataTableSource(
      this.movies, this.genreProvider, this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final movie = movies[index];
    return DataRow(
      cells: [
        DataCell(Text(movie.id?.toString() ?? '')),
        DataCell(Text(movie.title ?? '')),
        DataCell(Text(movie.description ?? '')),
        DataCell(Text(movie.releaseDate?.toString() ?? '')),
        DataCell(Text(movie.duration?.toString() ?? '')),
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
        DataCell(movie.picture != ""
            ? SizedBox(
                width: 60,
                height: 60,
                child: imageFromBase64String(movie.picture!))
            : const Text("")),
        DataCell(IconButton(
          icon: const Icon(Icons.delete),
          color: const Color.fromRGBO(220, 150, 206, 1),
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
