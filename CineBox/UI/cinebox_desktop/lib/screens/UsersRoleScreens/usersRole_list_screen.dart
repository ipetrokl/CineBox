import 'package:cinebox_desktop/models/Role/role.dart';
import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/UsersRole/usersRole.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/role_provider.dart';
import 'package:cinebox_desktop/providers/usersRole_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:cinebox_desktop/screens/UsersRoleScreens/usersRole_detail_screen.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UsersRoleListScreen extends StatefulWidget {
  const UsersRoleListScreen({super.key});

  @override
  State<UsersRoleListScreen> createState() => _UsersRoleListScreenState();
}

class _UsersRoleListScreenState extends State<UsersRoleListScreen> {
  SearchResult<UsersRole>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late UsersRoleProvider _usersRoleProvider;
  late UsersProvider _usersProvider;
  late RoleProvider _roleProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _usersRoleProvider = context.read<UsersRoleProvider>();
    _usersProvider = context.read<UsersProvider>();
    _roleProvider = context.read<RoleProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "UsersRole List",
      child: Container(
        child: Column(
          children: [_buildAdd(), _buildDataListView()],
        ),
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
            // Pozivanje get metode
            var data = await _usersRoleProvider.get();
            setState(() {
              result = data;
            });
          },
          child: const Text("Get All"),
        ),
        SizedBox(width: 20),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UsersRoleDetailScreen(
                    usersRole: null,
                  ),
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
                'User',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Role',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Date of Modification',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
          ],
          rows: result?.result
                  .map((UsersRole e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    print('selected: ${e.usersRolesId}'),
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UsersRoleDetailScreen(
                                                usersRole: e,
                                              )),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.usersRolesId?.toString() ?? "")),
                            DataCell(
                              FutureBuilder<Users?>(
                                future: _usersProvider.getById(e.userId!),
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
                                future: _roleProvider.getById(e.roleId!),
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
                                Text(e.dateOfModification?.toString() ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
