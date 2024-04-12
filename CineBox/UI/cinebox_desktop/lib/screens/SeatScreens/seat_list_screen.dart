import 'package:cinebox_desktop/models/Hall/hall.dart';
import 'package:cinebox_desktop/models/Seat/seat.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/hall_provider.dart';
import 'package:cinebox_desktop/providers/seat_provider.dart';
import 'package:cinebox_desktop/screens/SeatScreens/seat_detail_screen.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SeatListScreen extends StatefulWidget {
  const SeatListScreen({super.key});

  @override
  State<SeatListScreen> createState() => _SeatListScreenState();
}

class _SeatListScreenState extends State<SeatListScreen> {
  SearchResult<Seat>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late SeatProvider _seatProvider;
  late HallProvider _hallProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _seatProvider = context.read<SeatProvider>();
    _hallProvider = context.read<HallProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Seat List",
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
                var data = await _seatProvider.get(filter: {
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
                      builder: (context) => SeatDetailScreen(
                            seat: null,
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
                'Hall',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Seat Number',
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
                'Status',
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
                  .map((Seat e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    print('selected: ${e.id}'),
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SeatDetailScreen(
                                                seat: e,
                                              )),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.id?.toString() ?? "")),
                            DataCell(
                              FutureBuilder<Hall?>(
                                future: _hallProvider.getById(e.hallId!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data?.name ?? '');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                            DataCell(Text(e.seatNumber?.toString() ?? "")),
                            DataCell(Text(e.category?.toString() ?? "")),
                            DataCell(Text(e.status?.toString() ?? "")),
                            DataCell(IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteRecord(e.id!),
                            )),
                          ]))
                  .toList() ??
              []),
    ));
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _seatProvider.delete(id);

      if (success) {
        var data = await _seatProvider.get();
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
