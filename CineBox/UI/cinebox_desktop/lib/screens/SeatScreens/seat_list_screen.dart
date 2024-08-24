import 'package:cinebox_desktop/models/Hall/hall.dart';
import 'package:cinebox_desktop/models/Seat/seat.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/hall_provider.dart';
import 'package:cinebox_desktop/providers/seat_provider.dart';
import 'package:cinebox_desktop/screens/SeatScreens/seat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatListScreen extends StatefulWidget {
  const SeatListScreen({super.key});

  @override
  State<SeatListScreen> createState() => _SeatListScreenState();
}

class _SeatListScreenState extends State<SeatListScreen> {
  SearchResult<Seat>? result;
  TextEditingController _ftsController = TextEditingController();
  late SeatProvider _seatProvider;
  late HallProvider _hallProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _seatProvider = context.read<SeatProvider>();
    _hallProvider = context.read<HallProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _seatProvider.get();

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching data: $e");
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
              decoration: InputDecoration(labelText: "Hall or Category"),
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
                showDialog(
                  context: context,
                  builder: (_) => SeatDetailScreen(
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
              child: Text('Seats'),
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Hall')),
              DataColumn(label: Text('Seat Number')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(result?.result ?? [], _hallProvider,
                _deleteRecord, _navigateToDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(Seat seat) {
    showDialog(
      context: context,
      builder: (_) => SeatDetailScreen(
        seat: seat,
        onClose: () {
          _fetchData();
        },
      ),
    );
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
      print("Error deleting data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete data. Please try again."),
        ),
      );
    }
  }
}

class DataTableSourceRows extends DataTableSource {
  final List<Seat> seats;
  final HallProvider hallProvider;
  final Function(int) onDelete;
  final Function(Seat) onRowSelected;

  DataTableSourceRows(
      this.seats, this.hallProvider, this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final seat = seats[index];
    return DataRow(
      cells: [
        DataCell(Text(seat.id?.toString() ?? "")),
        DataCell(
          FutureBuilder<Hall?>(
            future: hallProvider.getById(seat.hallId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.name ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(Text(seat.seatNumber?.toString() ?? "")),
        DataCell(Text(seat.category?.toString() ?? "")),
        DataCell(Text(seat.status?.toString() ?? "")),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(seat.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(seat);
        }
      },
    );
  }

  @override
  int get rowCount => seats.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
