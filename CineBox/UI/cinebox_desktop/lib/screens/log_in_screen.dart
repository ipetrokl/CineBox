import 'package:cinebox_desktop/models/UsersRole/usersRole.dart';
import 'package:cinebox_desktop/providers/admin_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/role_provider.dart';
import 'package:cinebox_desktop/providers/usersRole_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:cinebox_desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late MovieProvider _movieProvider;
  late UsersProvider _usersProvider;
  late RoleProvider _roleProvider;
  late UsersRoleProvider _usersRoleProvider;

  @override
  Widget build(BuildContext context) {
    _movieProvider = context.read<MovieProvider>();
    _usersProvider = context.read<UsersProvider>();
    _roleProvider = context.read<RoleProvider>();
    _usersRoleProvider = context.read<UsersRoleProvider>();

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Image.asset(
              "assets/images/CineBoxLogo.jpeg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
              child: Card(
                elevation: 8, // Dodajte sjenu na karticu da se istakne
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      const Text(
                        "Login to Your Account",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.person),
                        ),
                        controller: _usernameController,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.password),
                        ),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 40)),
                        onPressed: () async {
                          var username = _usernameController.text;
                          var password = _passwordController.text;
                          print("Sign In proceed $username, $password");

                          Authorization.username = username;
                          Authorization.password = password;

                          var users = await _usersProvider.get();
                          for (var user in users.result) {
                            if (username == user.username) {
                              var usersRoles = await _usersRoleProvider.get();
                              for (var userRole in usersRoles.result) {
                                if (userRole.userId == user.id) {
                                  var role = await _roleProvider
                                      .getById(userRole.roleId!);
                                  if (role != null && role.name == 'admin') {
                                    Provider.of<IsAdminCheckProvider>(context,
                                            listen: false)
                                        .isAdmin = true;
                                  }
                                }
                              }
                            }
                          }

                          try {
                            await _movieProvider.get();

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => MasterScreen(),
                              ),
                            );
                          } on Exception catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Error"),
                                content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text("Sign In"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
