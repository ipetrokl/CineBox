import 'package:cinebox_desktop/models/movie.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/screens/movie_detail_screen.dart';
import 'package:cinebox_desktop/utils/util.dart';
import 'package:cinebox_desktop/widgets/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late MovieProvider _movieProvider;
  SearchResult<Movie>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _movieProvider = context.read<MovieProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Movie List",
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
              decoration: InputDecoration(labelText: "Title or Genre"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Description"),
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
              child: const Text("Search")),
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
                'Title',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Description',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Release Date',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Duration',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Genre',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Director',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Picture',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ))
          ],
          rows: result?.result
                  .map((Movie e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    print('selected: ${e.id}'),
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailScreen(movie: e,)),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.id?.toString() ?? "")),
                            DataCell(Text(e.title?.toString() ?? "")),
                            DataCell(Text(e.description?.toString() ?? "")),
                            DataCell(Text(e.releaseDate?.toString() ?? "")),
                            DataCell(Text(e.duration?.toString() ?? "")),
                            DataCell(Text(e.genre?.toString() ?? "")),
                            DataCell(Text(e.director?.toString() ?? "")),
                            DataCell(e.picture != ""
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    child: imageFromBase64String(e.picture!))
                                : Text("")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
