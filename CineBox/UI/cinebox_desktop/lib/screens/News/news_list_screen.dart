import 'package:cinebox_desktop/models/Cinema/cinema.dart';
import 'package:cinebox_desktop/models/News/news.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:cinebox_desktop/providers/news_provider.dart';
import 'package:cinebox_desktop/screens/News/news_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  SearchResult<News>? result;
  TextEditingController _ftsController = TextEditingController();
  late NewsProvider _newsProvider;
  late CinemaProvider _cinemaProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    _cinemaProvider = context.read<CinemaProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _newsProvider.get();

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
              decoration: InputDecoration(labelText: "News name"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _newsProvider.get(filter: {
                  'fts': _ftsController.text,
                });

                setState(() {
                  result = data;
                });
              },
              child: const Text("Search")),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (_) => NewsDetailScreen(
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
              child: Text('News'),
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Cinema')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Description')),
              DataColumn(label: Text('Created Date')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(result?.result ?? [], _cinemaProvider, _deleteRecord, _navigateToDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(News news) {
    showDialog(
      context: context,
      builder: (_) => NewsDetailScreen(
        news: news,
        onClose: () {
          _fetchData();
        },
      ),
    );
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _newsProvider.delete(id);

      if (success) {
        var data = await _newsProvider.get();
        setState(() {
          result = data;
        });
      }
    } catch (e) {
      print("Error deleting data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete data. Please try again."),
        ),
      );
    }
  }
}

class DataTableSourceRows extends DataTableSource {
  final List<News> newses;
  final CinemaProvider cinemaProvider;
    final Function(int) onDelete;
  final Function(News) onRowSelected;

  DataTableSourceRows(this.newses, this.cinemaProvider, this.onDelete, this.onRowSelected);

  @override
  @override
  DataRow getRow(int index) {
    final news = newses[index];
    return DataRow(
      cells: [
        DataCell(Text(news.id?.toString() ?? "")),
        DataCell(
          FutureBuilder<Cinema?>(
            future: cinemaProvider.getById(news.cinemaId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.name ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(Text(news.name ?? '')),
        DataCell(Text(news.description ?? '')),
        DataCell(Text(news.createdDate?.toString() ?? '')),
        DataCell(IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => onDelete(news.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(news);
        }
      },
    );
  }

  @override
  int get rowCount => newses.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
