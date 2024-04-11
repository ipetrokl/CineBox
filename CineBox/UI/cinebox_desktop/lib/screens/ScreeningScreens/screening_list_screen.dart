import 'package:cinebox_desktop/models/Cinema/cinema.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/Screening/screening.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/screening_provider.dart';
import 'package:cinebox_desktop/screens/ScreeningScreens/screening_detail_screen.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ScreeningListScreen extends StatefulWidget {
  const ScreeningListScreen({super.key});

  @override
  State<ScreeningListScreen> createState() => _ScreeningListScreenState();
}

class _ScreeningListScreenState extends State<ScreeningListScreen> {
  late ScreeningProvider _screeningProvider;
  SearchResult<Screening>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late MovieProvider _movieProvider;
  late CinemaProvider _cinemaProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _screeningProvider = context.read<ScreeningProvider>();

    _movieProvider = context.read<MovieProvider>();
    _cinemaProvider = context.read<CinemaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Screening List",
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
              decoration: InputDecoration(labelText: "Movie title"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Category"),
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

                var data = await _screeningProvider.get(filter: {
                  'fts': _ftsController.text,
                  'description': _descriptionController.text
                });

                setState(() {
                  result = data;
                });
                // print("data: ${data.result[0].title}");
              },
              child: const Text("Search")),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ScreeningDetailScreen(
                            screening: null,
                          )),
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
                'Movie',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Cinema',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Category',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Start Time',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'End Time',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Price',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ))
          ],
          rows: result?.result
                  .map((Screening e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    print('selected: ${e.id}'),
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ScreeningDetailScreen(
                                                screening: e,
                                              )),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.id?.toString() ?? "")),
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
                            DataCell(
                              FutureBuilder<Cinema?>(
                                future: _cinemaProvider.getById(e.cinemaId!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data?.name ?? '');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                            DataCell(Text(e.category?.toString() ?? "")),
                            DataCell(Text(e.startTime?.toString() ?? "")),
                            DataCell(Text(e.endTime?.toString() ?? "")),
                            DataCell(Text(e.price?.toString() ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
