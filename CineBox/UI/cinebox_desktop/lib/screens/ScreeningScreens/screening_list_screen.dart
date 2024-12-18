import 'package:cinebox_desktop/models/Hall/hall.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/Screening/screening.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/hall_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/screening_provider.dart';
import 'package:cinebox_desktop/screens/ScreeningScreens/screening_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ScreeningListScreen extends StatefulWidget {
  const ScreeningListScreen({super.key});

  @override
  State<ScreeningListScreen> createState() => _ScreeningListScreenState();
}

class _ScreeningListScreenState extends State<ScreeningListScreen> {
  late ScreeningProvider _screeningProvider;
  SearchResult<Screening>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  late MovieProvider _movieProvider;
  late HallProvider _hallProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _screeningProvider = context.read<ScreeningProvider>();
    _movieProvider = context.read<MovieProvider>();
    _hallProvider = context.read<HallProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _screeningProvider.get();

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
              controller: _categoryController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _screeningProvider.get(filter: {
                  'fts': _ftsController.text,
                  'category': _categoryController.text
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
                  builder: (_) => ScreeningDetailScreen(
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
              child: Text('Screenings'),
            ),
            columns: const [
              DataColumn(label: Text('Movie')),
              DataColumn(label: Text('Hall')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Screening Time')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(result?.result ?? [], _movieProvider,
                _hallProvider, _showDeleteConfirmationDialog, _navigateToDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(Screening screening) {
    showDialog(
      context: context,
      builder: (_) => ScreeningDetailScreen(
        screening: screening,
        onClose: () {
          _fetchData();
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content:
              const Text("Are you sure you want to delete this record?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteRecord(id);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _screeningProvider.delete(id);

      if (success) {
        var data = await _screeningProvider.get();
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
  final List<Screening> screenings;
  final MovieProvider movieProvider;
  final HallProvider hallProvider;
  final Function(int) onDelete;
  final Function(Screening) onRowSelected;

  DataTableSourceRows(this.screenings, this.movieProvider, this.hallProvider,
      this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final screening = screenings[index];
    final DateTime? screeningTime = screening.screeningTime;
    final String formattedDate = screeningTime != null
        ? DateFormat('yyyy-MM-dd HH:mm').format(screeningTime)
        : "";

    return DataRow(
      cells: [
        DataCell(
          FutureBuilder<Movie?>(
            future: movieProvider.getById(screening.movieId!),
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
          FutureBuilder<Hall?>(
            future: hallProvider.getById(screening.hallId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.name ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(Text(screening.category?.toString() ?? "")),
        DataCell(Text(formattedDate)),
        DataCell(Text(screening.price?.toString() ?? "")),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(screening.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(screening);
        }
      },
    );
  }

  @override
  int get rowCount => screenings.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
