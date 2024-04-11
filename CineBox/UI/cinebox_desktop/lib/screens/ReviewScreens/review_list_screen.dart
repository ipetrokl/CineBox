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
  TextEditingController _descriptionController = TextEditingController();
  late ReviewProvider _reviewProvider;
  late MovieProvider _movieProvider;
  late UsersProvider _usersProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _reviewProvider = context.read<ReviewProvider>();
    _movieProvider = context.read<MovieProvider>();
    _usersProvider = context.read<UsersProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Review List",
      child: Container(
        child: Column(
          children: [_buildSearch(), _buildDataListView()],
        ),
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
              decoration: InputDecoration(labelText: "Search"),
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
      child: DataTable(
          columns: const [
            DataColumn(
                label: Expanded(
              child: Text(
                'ID',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'User',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Movie',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Rating',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Comment',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
          ],
          rows: result?.result
                  .map((Review e) => DataRow(
                          cells: [
                            DataCell(Text(e.id?.toString() ?? "")),
                            DataCell(
                              FutureBuilder<Users?>(
                                future: _usersProvider.getById(e.userId!),
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
                                future: _movieProvider.getById(e.movieId!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data?.title ?? '');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                            DataCell(Text(e.rating?.toString() ?? "")),
                            DataCell(Text(e.comment?.toString() ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
