import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:cinebox_mobile/providers/users_provider.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:cinebox_mobile/screens/profil_detail_screen.dart';
import 'package:cinebox_mobile/screens/profil_edit_password_screen.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:cinebox_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ProfilScreen extends StatefulWidget {
  static const String routeName = "/profil";
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;

  ProfilScreen(
      {super.key,
      required this.cinemaId,
      required this.initialDate,
      required this.cinemaName});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UsersProvider _usersProvider;
  SearchResult<Users>? result;

  @override
  void initState() {
    super.initState();
    _usersProvider = context.read<UsersProvider>();
    loadData();
  }

  Future loadData() async {
    try {
      var data = await _usersProvider
          .get(filter: {'username': Authorization.username});

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = result?.result.first;

    return MasterScreen(
      cinemaId: widget.cinemaId,
      initialDate: widget.initialDate,
      cinemaName: widget.cinemaName,
      child: Column(
        children: [
          _buildSupport(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromRGBO(97, 72, 199, 1)),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (_) => ProfilDetailScreen(
                        users: user,
                        onClose: () {
                          loadData();
                        },
                      ),
                    );
                  },
                  child: const Text("Edit")),
              SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromRGBO(97, 72, 199, 1)),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (_) => ProfilEditPasswordScreen(
                        users: user,
                        onClose: () {
                          loadData();
                        },
                      ),
                    );
                  },
                  child: const Text("Change password"))
            ],
          ),
        ],
      ),
    );
  }

  FormBuilder _buildSupport() {
    final user = result?.result.first;

    return FormBuilder(
      key: _formKey,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "Profil",
                    style: TextStyle(
                        fontSize: 30, color: Colors.black.withAlpha(160)),
                  ),
                ),
                SizedBox(height: 10),
                const Divider(
                    thickness: 1, color: Color.fromARGB(200, 21, 36, 118)),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    user?.username ?? "Username",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black.withAlpha(160),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                _buildReadOnlyField("Name", user?.name ?? ''),
                const SizedBox(height: 30),
                _buildReadOnlyField("Surname", user?.surname ?? ''),
                const SizedBox(height: 30),
                _buildReadOnlyField("Email", user?.email ?? ''),
                const SizedBox(height: 30),
                _buildReadOnlyField("Phone", user?.phone ?? ''),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToDetail(Users users) {
    showDialog(
      context: context,
      builder: (_) => ProfilDetailScreen(
        users: users,
        onClose: () {
          loadData();
        },
      ),
    );
  }
}
