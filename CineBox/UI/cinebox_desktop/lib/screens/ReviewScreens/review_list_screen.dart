import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/Review/review.dart';
import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/review_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ReviewListScreen extends StatefulWidget {
  const ReviewListScreen({super.key});

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  SearchResult<Review>? result;
  TextEditingController _ftsController = TextEditingController();
  late ReviewProvider _reviewProvider;
  late MovieProvider _movieProvider;
  late UsersProvider _usersProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _reviewProvider = context.read<ReviewProvider>();
    _movieProvider = context.read<MovieProvider>();
    _usersProvider = context.read<UsersProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _reviewProvider.get();

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
              decoration: InputDecoration(labelText: "User or Comment"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _reviewProvider.get(filter: {
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
              child: Text('Reviews'),
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Movie')),
              DataColumn(label: Text('Rating')),
              DataColumn(label: Text('Comment')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(result?.result ?? [], _usersProvider,
                _movieProvider, _deleteRecord),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _reviewProvider.delete(id);

      if (success) {
        var data = await _reviewProvider.get();
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
  final List<Review> reviews;
  final UsersProvider usersProvider;
  final MovieProvider movieProvider;
  final Function(int) onDelete;

  DataTableSourceRows(
      this.reviews, this.usersProvider, this.movieProvider, this.onDelete);

  @override
  DataRow getRow(int index) {
    final review = reviews[index];
    return DataRow(
      cells: [
        DataCell(Text(review.id?.toString() ?? "")),
        DataCell(
          FutureBuilder<Users?>(
            future: usersProvider.getById(review.userId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.name ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(
          FutureBuilder<Movie?>(
            future: movieProvider.getById(review.movieId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.title ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(Text(review.rating?.toString() ?? "")),
        DataCell(Text(review.comment?.toString() ?? "")),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(review.id!),
        )),
      ],
    );
  }

  @override
  int get rowCount => reviews.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
