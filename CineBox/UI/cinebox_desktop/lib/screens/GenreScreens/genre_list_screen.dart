import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/genre_provider.dart';
import 'package:cinebox_desktop/screens/GenreScreens/genre_detail_screen.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class GenreListScreen extends StatefulWidget {
  const GenreListScreen({super.key});

  @override
  State<GenreListScreen> createState() => _GenreListScreenState();
}

class _GenreListScreenState extends State<GenreListScreen> {
  SearchResult<Genre>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late GenreProvider _genreProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _genreProvider = context.read<GenreProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Genre List",
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
              decoration: InputDecoration(labelText: "Name"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _genreProvider.get(filter: {
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => GenreDetailScreen(
                            genre: null,
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
                'Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
          ],
          rows: result?.result
                  .map((Genre e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    print('selected: ${e.id}'),
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GenreDetailScreen(
                                                genre: e,
                                              )),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.id?.toString() ?? "")),
                            DataCell(Text(e.name?.toString() ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
