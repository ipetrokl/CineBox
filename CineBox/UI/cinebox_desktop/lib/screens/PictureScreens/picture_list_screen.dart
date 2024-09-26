import 'dart:convert';
import 'package:cinebox_desktop/models/Picture/picture.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/picture_provider.dart';
import 'package:cinebox_desktop/screens/PictureScreens/picture_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PictureListScreen extends StatefulWidget {
  const PictureListScreen({super.key});

  @override
  State<PictureListScreen> createState() => _PictureListScreenState();
}

class _PictureListScreenState extends State<PictureListScreen> {
  SearchResult<Picture>? result;
  late PictureProvider _pictureProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _pictureProvider = context.read<PictureProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _pictureProvider.get();

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
          ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (_) => PictureDetailScreen(
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
              child: Text('Pictures'),
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Picture')),
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

  void _navigateToDetail(Picture picture) {
    showDialog(
      context: context,
      builder: (_) => PictureDetailScreen(
        picture: picture,
        onClose: () {
          _fetchData();
        },
      ),
    );
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _pictureProvider.delete(id);

      if (success) {
        var data = await _pictureProvider.get();
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
  final List<Picture> pictures;
  final Function(int) onDelete;
  final Function(Picture) onRowSelected;

  DataTableSourceRows(this.pictures, this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final picture = pictures[index];
    return DataRow(
      cells: [
        DataCell(Text(picture.id?.toString() ?? '')),
        DataCell(
          Container(
            width: 40,
            height: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: picture.picture1 != null && picture.picture1 != ""
                    ? MemoryImage(base64Decode(picture.picture1!))
                    : AssetImage("assets/images/empty.jpg")
                        as ImageProvider<Object>,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        DataCell(IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => onDelete(picture.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(picture);
        }
      },
    );
  }

  @override
  int get rowCount => pictures.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
