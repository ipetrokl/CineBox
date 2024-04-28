import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:cinebox_mobile/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatefulWidget {
  Users? users;
  RegisterScreen({super.key, this.users});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late UsersProvider _usersProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'name': widget.users?.name,
      'surname': widget.users?.surname,
      'email': widget.users?.email,
      'phone': widget.users?.phone,
      'username': widget.users?.username,
      'password': widget.users?.password,
      'passwordConfirmation': widget.users?.passwordConfirmation,
      'status': widget.users?.status ?? true,
    };

    _usersProvider = context.read<UsersProvider>();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // if (widget.movie != null) {
    //   setState(() {
    //     _formKey.currentState?.patchValue({'title': widget.movie?.title});
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SingleChildScrollView(
      child: Column(
        children: [
          _buildForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 70)),
              ElevatedButton(
                  onPressed: () async {

                    _formKey.currentState?.saveAndValidate();

                    try {
                      if (widget.users == null) {
                        await _usersProvider
                            .registerUser(_formKey.currentState?.value);
                      }

                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Success"),
                          content: Text("Registrated, you can sign in now"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            )
                          ],
                        ),
                      );
                    } on Exception catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text("Error"),
                                content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("OK"))
                                ],
                              ));
                    }
                  },
                  child: Text("Save"))
            ],
          ),
        ],
      ),
    ));
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Center(
        child: Container(
          width: 800,
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Name"),
                  name: 'name',
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Surname"),
                  name: 'surname',
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Email"),
                  name: 'email',
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Phone"),
                  name: 'phone',
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Username"),
                  name: 'username',
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Password"),
                  name: 'password',
                ),
                FormBuilderTextField(
                  decoration:
                      InputDecoration(labelText: "Password Confirmation"),
                  name: 'passwordConfirmation',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
