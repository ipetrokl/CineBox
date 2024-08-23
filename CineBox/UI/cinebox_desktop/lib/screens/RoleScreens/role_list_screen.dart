import 'package:cinebox_desktop/models/Role/role.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/role_provider.dart';
import 'package:cinebox_desktop/screens/RoleScreens/role_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleListScreen extends StatefulWidget {
  const RoleListScreen({super.key});

  @override
  State<RoleListScreen> createState() => _RoleListScreenState();
}

class _RoleListScreenState extends State<RoleListScreen> {
  SearchResult<Role>? result;
  TextEditingController _ftsController = TextEditingController();
  late RoleProvider _roleProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _roleProvider = context.read<RoleProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _roleProvider.get();

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
              decoration: InputDecoration(labelText: "Name"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _roleProvider.get(filter: {
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
                  builder: (_) => RoleDetailScreen(
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
              child: Text('Roles'),
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Description')),
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

  void _navigateToDetail(Role role) {
    showDialog(
      context: context,
      builder: (_) => RoleDetailScreen(
        role: role,
        onClose: () {
          _fetchData();
        },
      ),
    );
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _roleProvider.delete(id);

      if (success) {
        var data = await _roleProvider.get();
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
  final List<Role> roles;
  final Function(int) onDelete;
  final Function(Role) onRowSelected;

  DataTableSourceRows(this.roles, this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final role = roles[index];
    return DataRow(
      cells: [
        DataCell(Text(role.id?.toString() ?? "")),
        DataCell(Text(role.name?.toString() ?? "")),
        DataCell(Text(role.description?.toString() ?? "")),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(role.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(role);
        }
      },
    );
  }

  @override
  int get rowCount => roles.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
