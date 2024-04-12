import 'package:cinebox_desktop/models/Cinema/cinema.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:cinebox_desktop/screens/CinemaScreens/cinema_detail_screen.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CinemaListScreen extends StatefulWidget {
  const CinemaListScreen({super.key});

  @override
  State<CinemaListScreen> createState() => _CinemaListScreenState();
}

class _CinemaListScreenState extends State<CinemaListScreen> {
  SearchResult<Cinema>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late CinemaProvider _cinemaProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _cinemaProvider = context.read<CinemaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Cinema List",
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
              decoration: InputDecoration(labelText: "Name or Location"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Location"),
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

                var data = await _cinemaProvider.get(filter: {
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
                      builder: (context) => CinemaDetailScreen(
                            cinema: null,
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
            DataColumn(
                label: Expanded(
              child: Text(
                'Location',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: result?.result
                  .map((Cinema e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    print('selected: ${e.id}'),
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CinemaDetailScreen(
                                                cinema: e,
                                              )),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.id?.toString() ?? "")),
                            DataCell(Text(e.name?.toString() ?? "")),
                            DataCell(Text(e.location?.toString() ?? "")),
                            DataCell(IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteRecord(
                                  e.id!),
                            )),
                          ]))
                  .toList() ??
              []),
    ));
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _cinemaProvider.delete(id);

      if (success) {
        var data = await _cinemaProvider.get();
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
