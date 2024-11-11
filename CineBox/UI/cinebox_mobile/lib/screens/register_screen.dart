import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:cinebox_mobile/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
    super.didChangeDependencies();
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
                    _formKey.currentState?.save();

                    if (_formKey.currentState?.validate() ?? false) {
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
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
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
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Name is required'),
                  ]),
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Surname"),
                  name: 'surname',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Surname is required'),
                  ]),
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Email"),
                  name: 'email',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Email is required'),
                    FormBuilderValidators.email(
                        errorText: 'Invalid email format')
                  ]),
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Phone"),
                  name: 'phone',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Phone is required'),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.phoneNumber(
                        errorText:
                            'Invalid phone number format, e.g. 387111111')
                  ]),
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Username"),
                  name: 'username',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Username is required'),
                    FormBuilderValidators.minLength(4,
                        errorText: "Must be min 4 length")
                  ]),
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Password"),
                  name: 'password',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Password is required'),
                    FormBuilderValidators.minLength(4,
                        errorText: "Must be min 4 length"),
                    FormBuilderValidators.maxLength(50,
                        errorText: "Must be max 50 length")
                  ]),
                ),
                FormBuilderTextField(
                  decoration:
                      InputDecoration(labelText: "Password Confirmation"),
                  name: 'passwordConfirmation',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Password Confirmation is required'),
                    (val) {
                      if (val !=
                          _formKey.currentState?.fields['password']?.value) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
