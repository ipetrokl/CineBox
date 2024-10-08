import 'package:cinebox_mobile/providers/logged_in_user_provider.dart';
import 'package:cinebox_mobile/providers/movie_provider.dart';
import 'package:cinebox_mobile/providers/users_provider.dart';
import 'package:cinebox_mobile/screens/cinema_screen.dart';
import 'package:cinebox_mobile/screens/register_screen.dart';
import 'package:cinebox_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late MovieProvider _movieProvider;
  late UsersProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _movieProvider = context.read<MovieProvider>();
    _userProvider = context.read<UsersProvider>();

    return Container(
      color: const Color.fromRGBO(97, 72, 199, 1),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
          child: Card(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.1,
                  image: AssetImage("assets/images/CineBoxLogo.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
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
                          fixedSize: const Size(150, 40),
                          backgroundColor:
                              const Color.fromRGBO(97, 72, 199, 1)),
                      onPressed: () async {
                        var username = _usernameController.text;
                        var password = _passwordController.text;

                        Authorization.username = username;
                        Authorization.password = password;

                        try {
                          await _movieProvider.get();
                          var data = await _userProvider.get();

                          for (var user in data.result) {
                            if (username == user.username) {
                              Provider.of<LoggedInUserProvider>(context,
                                      listen: false)
                                  .setUser(user);
                            }
                          }

                          Navigator.pushNamed(context, CinemaScreen.routeName);
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "If you don't have account:",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (_) => RegisterScreen(),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
