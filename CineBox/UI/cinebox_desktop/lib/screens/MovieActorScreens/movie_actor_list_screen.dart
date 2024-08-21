import 'package:cinebox_desktop/models/Actor/actor.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/MovieActor/movieActor.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/actor_provider.dart';
import 'package:cinebox_desktop/providers/movie_actor_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/screens/MovieActorScreens/movie_actor_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MovieActorListScreen extends StatefulWidget {
  const MovieActorListScreen({super.key});

  @override
  State<MovieActorListScreen> createState() => _MovieActorListScreenState();
}

class _MovieActorListScreenState extends State<MovieActorListScreen> {
  SearchResult<MovieActor>? result;
  TextEditingController _ftsController = TextEditingController();
  late MovieActorProvider _movieActorProvider;
  late MovieProvider _movieProvider;
  late ActorProvider _actorProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _movieActorProvider = context.read<MovieActorProvider>();
    _movieProvider = context.read<MovieProvider>();
    _actorProvider = context.read<ActorProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _movieActorProvider.get();

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
              decoration: InputDecoration(labelText: "Movie or Actor name"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _movieActorProvider.get(filter: {
                  'fts': _ftsController.text,
                });

                setState(() {
                  result = data;
                });
              },
              child: const Text("Search")),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (_) => MovieActorDetailScreen(
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
              child: Text('MovieActors'),
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Movie')),
              DataColumn(label: Text('Actor')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(result?.result ?? [], _movieProvider,
                _actorProvider, _deleteRecord, _navigateToDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(MovieActor movieActor) {
    showDialog(
      context: context,
      builder: (_) => MovieActorDetailScreen(
        movieActor: movieActor,
        onClose: () {
          _fetchData();
        },
      ),
    );
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _movieActorProvider.delete(id);

      if (success) {
        var data = await _movieActorProvider.get();
        setState(() {
          result = data;
        });
      }
    } catch (e) {
      print("Error deleting genre: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete genre. Please try again."),
        ),
      );
    }
  }
}

class DataTableSourceRows extends DataTableSource {
  final List<MovieActor> movieActors;
  final MovieProvider movieProvider;
  final ActorProvider actorProvider;
  final Function(int) onDelete;
  final Function(MovieActor) onRowSelected;

  DataTableSourceRows(
      this.movieActors, this.movieProvider, this.actorProvider, this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final movieActor = movieActors[index];
    return DataRow(
      cells: [
        DataCell(Text(movieActor.id?.toString() ?? "")),
        DataCell(
          FutureBuilder<Movie?>(
            future: movieProvider.getById(movieActor.movieId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.title ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(
          FutureBuilder<Actor?>(
            future: actorProvider.getById(movieActor.actorId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.name ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(movieActor.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(movieActor);
        }
      },
    );
  }

  @override
  int get rowCount => movieActors.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
