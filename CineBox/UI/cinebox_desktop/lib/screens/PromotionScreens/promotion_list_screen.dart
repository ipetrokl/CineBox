import 'package:cinebox_desktop/models/Promotion/promotion.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/promotion_provider.dart';
import 'package:cinebox_desktop/screens/PromotionScreens/promotion_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PromotionListScreen extends StatefulWidget {
  const PromotionListScreen({super.key});

  @override
  State<PromotionListScreen> createState() => _PromotionListScreenState();
}

class _PromotionListScreenState extends State<PromotionListScreen> {
  SearchResult<Promotion>? result;
  TextEditingController _ftsController = TextEditingController();
  late PromotionProvider _promotionProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _promotionProvider = context.read<PromotionProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _promotionProvider.get();

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
              decoration: InputDecoration(labelText: "Code"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _promotionProvider.get(filter: {
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
                  builder: (_) => PromotionDetailScreen(
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
              child: Text('Promotions'),
            ),
            columns: const [
              DataColumn(label: Text('Code')),
              DataColumn(label: Text('Discount')),
              DataColumn(label: Text('Expiration Date')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(
                result?.result ?? [], _showDeleteConfirmationDialog, _navigateToDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(Promotion promotion) {
    showDialog(
      context: context,
      builder: (_) => PromotionDetailScreen(
        promotion: promotion,
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
          content: const Text("Are you sure you want to delete this record?"),
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
      var success = await _promotionProvider.delete(id);

      if (success) {
        var data = await _promotionProvider.get();
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
  final List<Promotion> promotions;
  final Function(int) onDelete;
  final Function(Promotion) onRowSelected;

  DataTableSourceRows(this.promotions, this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final promotion = promotions[index];
    final DateTime? expirationDate = promotion.expirationDate;
    final String formattedDate = expirationDate != null
        ? DateFormat('yyyy-MM-dd').format(expirationDate)
        : "";

    return DataRow(
      cells: [
        DataCell(Text(promotion.code?.toString() ?? "")),
        DataCell(Text(promotion.discount?.toString() ?? "")),
        DataCell(Text(formattedDate)),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(promotion.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(promotion);
        }
      },
    );
  }

  @override
  int get rowCount => promotions.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
