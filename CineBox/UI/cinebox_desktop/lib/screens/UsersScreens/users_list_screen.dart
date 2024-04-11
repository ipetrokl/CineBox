import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:cinebox_desktop/screens/UsersScreens/users_detail_screen.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  SearchResult<Users>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late UsersProvider _usersProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _usersProvider = context.read<UsersProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Users List",
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => UsersDetailScreen(
                            users: null,
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
                'Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Surname',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Email',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Phone',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Username',
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
          ],
          rows: result?.result
                  .map((Users e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    print('selected: ${e.id}'),
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UsersDetailScreen(
                                                users: e,
                                              )),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.id?.toString() ?? "")),
                            DataCell(Text(e.name?.toString() ?? "")),
                            DataCell(Text(e.surname?.toString() ?? "")),
                            DataCell(Text(e.email?.toString() ?? "")),
                            DataCell(Text(e.phone?.toString() ?? "")),
                            DataCell(Text(e.username?.toString() ?? "")),
                            DataCell(Text(e.status?.toString() ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
