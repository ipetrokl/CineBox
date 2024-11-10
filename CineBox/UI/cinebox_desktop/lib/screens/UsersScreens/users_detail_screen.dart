import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class UsersDetailScreen extends StatefulWidget {
  Users? users;
  final OnDialogClose? onClose;
  UsersDetailScreen({super.key, this.users, this.onClose});

  @override
  State<UsersDetailScreen> createState() => _UsersDetailScreenState();
}

class _UsersDetailScreenState extends State<UsersDetailScreen> {
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
      'status': widget.users?.status ?? false,
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
        backgroundColor: const Color.fromRGBO(214, 212, 203, 1),
        insetPadding: const EdgeInsets.all(100),
        child: Stack(children: [
          SingleChildScrollView(
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
                                    .insert(_formKey.currentState?.value);
                              } else {
                                await _usersProvider.update(widget.users!.id!,
                                    _formKey.currentState?.value);
                              }

                              _formKey.currentState?.reset();

                              if (widget.onClose != null) {
                                widget.onClose!();
                              }

                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text("Success"),
                                  content: Text("Saved successfully."),
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
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text("Error"),
                                        content: Text(e.toString()),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
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
          ),
          Positioned(
            right: 5,
            top: 5,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ]));
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
                    FormBuilderValidators.phoneNumber(
                        regex: RegExp(r'^\+?\d{9,15}$'),
                        errorText: 'Invalid phone number format, must be e.g. +387111111')
                  ]),
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Username"),
                  name: 'username',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Username is required'),
                    FormBuilderValidators.minLength(4)
                  ]),
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Password"),
                  name: 'password',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Password is required'),
                    FormBuilderValidators.minLength(4),
                    FormBuilderValidators.maxLength(50)
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
                FormBuilderCheckbox(
                  name: 'status',
                  title: Text('Active'),
                  initialValue: _initialValue['active'],
                  onChanged: (value) {
                    setState(() {
                      _initialValue['active'] = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
