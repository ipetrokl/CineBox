import 'dart:convert';

import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/picture_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:cinebox_desktop/screens/UsersScreens/users_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinebox_desktop/models/Picture/picture.dart' as MyAppPicture;

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  SearchResult<Users>? result;
  TextEditingController _ftsController = TextEditingController();
  late UsersProvider _usersProvider;
  late PictureProvider _pictureProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _usersProvider = context.read<UsersProvider>();
    _pictureProvider = context.read<PictureProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _usersProvider.get();

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
              decoration: InputDecoration(labelText: "Search"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _usersProvider.get(filter: {
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
                  builder: (_) => UsersDetailScreen(
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
              child: Text('Users'),
            ),
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Surname')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Username')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Picture')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(
                result?.result ?? [],
                _showDeleteConfirmationDialog,
                _navigateToDetail,
                _pictureProvider),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(Users users) {
    showDialog(
      context: context,
      builder: (_) => UsersDetailScreen(
        users: users,
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
      var success = await _usersProvider.delete(id);

      if (success) {
        var data = await _usersProvider.get();
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
  final List<Users> userses;
  final Function(int) onDelete;
  final Function(Users) onRowSelected;
  final PictureProvider pictureProvider;

  DataTableSourceRows(
      this.userses, this.onDelete, this.onRowSelected, this.pictureProvider);

  @override
  DataRow getRow(int index) {
    final users = userses[index];
    return DataRow(
      cells: [
        DataCell(Text(users.name?.toString() ?? "")),
        DataCell(Text(users.surname?.toString() ?? "")),
        DataCell(Text(users.email?.toString() ?? "")),
        DataCell(Text(users.phone?.toString() ?? "")),
        DataCell(Text(users.username?.toString() ?? "")),
        DataCell(Text(users.status?.toString() ?? "")),
        DataCell(
          FutureBuilder<MyAppPicture.Picture?>(
            future: users.pictureId != null
                ? pictureProvider.getById(users.pictureId!)
                : null,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: 40,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      image: snapshot.data?.picture1 != null &&
                              snapshot.data?.picture1 != ""
                          ? MemoryImage(base64Decode(snapshot.data!.picture1!))
                          : AssetImage("assets/images/empty.jpg")
                              as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error loading picture');
              } else {
                return Container(
                  width: 40,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const Image(
                      image: AssetImage("assets/images/empty.jpg")
                          as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            },
          ),
        ),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(users.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(users);
        }
      },
    );
  }

  @override
  int get rowCount => userses.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
