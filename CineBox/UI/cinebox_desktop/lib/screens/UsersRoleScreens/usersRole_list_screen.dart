import 'package:cinebox_desktop/models/Role/role.dart';
import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/UsersRole/usersRole.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/role_provider.dart';
import 'package:cinebox_desktop/providers/usersRole_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:cinebox_desktop/screens/UsersRoleScreens/usersRole_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UsersRoleListScreen extends StatefulWidget {
  const UsersRoleListScreen({super.key});

  @override
  State<UsersRoleListScreen> createState() => _UsersRoleListScreenState();
}

class _UsersRoleListScreenState extends State<UsersRoleListScreen> {
  SearchResult<UsersRole>? result;
  late UsersRoleProvider _usersRoleProvider;
  late UsersProvider _usersProvider;
  late RoleProvider _roleProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _usersRoleProvider = context.read<UsersRoleProvider>();
    _usersProvider = context.read<UsersProvider>();
    _roleProvider = context.read<RoleProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _usersRoleProvider.get();

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
        children: [_buildAdd(), _buildDataListView()],
      ),
    );
  }

  Widget _buildAdd() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (_) => UsersRoleDetailScreen(
                  onClose: () {
                    _fetchData();
                  },
                ),
              );
            },
            child: const Text("Add"),
          )
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
              child: Text('UsersRoles'),
            ),
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Date Of Modification')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(result?.result ?? [], _usersProvider,
                _roleProvider, _showDeleteConfirmationDialog, _navigateToDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(UsersRole usersRole) {
    showDialog(
      context: context,
      builder: (_) => UsersRoleDetailScreen(
        usersRole: usersRole,
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
      var success = await _usersRoleProvider.delete(id);

      if (success) {
        var data = await _usersRoleProvider.get();
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
  final List<UsersRole> usersRoles;
  final UsersProvider usersProvider;
  final RoleProvider roleProvider;
  final Function(int) onDelete;
  final Function(UsersRole) onRowSelected;

  DataTableSourceRows(this.usersRoles, this.usersProvider, this.roleProvider,
      this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final usersRole = usersRoles[index];
    final DateTime? dateOfModification = usersRole.dateOfModification;
    final String formattedDate = dateOfModification != null
        ? DateFormat('yyyy-MM-dd HH:mm').format(dateOfModification)
        : "";

    return DataRow(
      cells: [
        DataCell(
          FutureBuilder<Users?>(
            future: usersProvider.getById(usersRole.userId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.name ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(
          FutureBuilder<Role?>(
            future: roleProvider.getById(usersRole.roleId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.name ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(Text(formattedDate)),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(usersRole.usersRolesId!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(usersRole);
        }
      },
    );
  }

  @override
  int get rowCount => usersRoles.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
