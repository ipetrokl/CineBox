import 'package:cinebox_desktop/models/Cinema/cinema.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:cinebox_desktop/screens/CinemaScreens/cinema_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CinemaListScreen extends StatefulWidget {
  const CinemaListScreen({super.key});

  @override
  State<CinemaListScreen> createState() => _CinemaListScreenState();
}

class _CinemaListScreenState extends State<CinemaListScreen> {
  SearchResult<Cinema>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  late CinemaProvider _cinemaProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _cinemaProvider = context.read<CinemaProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _cinemaProvider.get();

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
              decoration: InputDecoration(labelText: "Name or Location"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Name"),
              controller: _nameController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _cinemaProvider.get(filter: {
                  'fts': _ftsController.text,
                  'name': _nameController.text
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
                  builder: (_) => CinemaDetailScreen(
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
              child: Text('Cinemas'),
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(
                result?.result ?? [], _deleteRecord, _navigateToDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(Cinema cinema) {
    showDialog(
      context: context,
      builder: (_) => CinemaDetailScreen(
        cinema: cinema,
        onClose: () {
          _fetchData();
        },
      ),
    );
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

class DataTableSourceRows extends DataTableSource {
  final List<Cinema> cinemas;
  final Function(int) onDelete;
  final Function(Cinema) onRowSelected;

  DataTableSourceRows(this.cinemas, this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final cinema = cinemas[index];
    return DataRow(
      cells: [
        DataCell(Text(cinema.id?.toString() ?? "")),
        DataCell(Text(cinema.name?.toString() ?? "")),
        DataCell(Text(cinema.location?.toString() ?? "")),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(cinema.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(cinema);
        }
      },
    );
  }

  @override
  int get rowCount => cinemas.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
