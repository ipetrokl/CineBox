import 'package:cinebox_desktop/models/movie.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/screens/movie_detail_screen.dart';
import 'package:cinebox_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late MovieProvider _movieProvider;
  SearchResult<Movie>? result;

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
          children: [
            Text("Test"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  print("Back proceed");
                  //Navigator.of(context).pop();
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const MovieDetailScreen()),
                  // );

                  var data = await _movieProvider.get();

                  setState(() {
                    result = data;
                  });
                  print("data: ${data.result[0].title}");
                },
                child: Text("Back")),
            DataTable(
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
                  ))
                ],
                rows: result?.result
                        .map((Movie e) => DataRow(cells: [
                              DataCell(Text(e.id?.toString() ?? "")),
                              DataCell(Text(e.title?.toString() ?? "")),
                              DataCell(Text(e.description?.toString() ?? "")),
                              DataCell(Text(e.releaseDate?.toString() ?? "")),
                              DataCell(Text(e.duration?.toString() ?? "")),
                              DataCell(Text(e.genre?.toString() ?? "")),
                              DataCell(Text(e.director?.toString() ?? "")),
                            ]))
                        .toList() ??
                    [])
          ],
        ),
      ),
    );
  }
}
