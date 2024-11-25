import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:cinebox_mobile/providers/users_provider.dart';
import 'package:cinebox_mobile/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class ProfilEditPasswordScreen extends StatefulWidget {
  Users? users;
  final OnDialogClose? onClose;
  ProfilEditPasswordScreen({super.key, this.users, this.onClose});

  @override
  State<ProfilEditPasswordScreen> createState() =>
      _ProfilEditPasswordScreenState();
}

class _ProfilEditPasswordScreenState extends State<ProfilEditPasswordScreen> {
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
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 70)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: const Color.fromRGBO(97, 72, 199, 1)),
                    onPressed: () async {
                      _formKey.currentState?.save();

                      if (_formKey.currentState?.validate() ?? false) {
                        final formData = Map<String, dynamic>.from(
                            _formKey.currentState!.value);

                        formData['name'] = widget.users?.name ?? '';
                        formData['surname'] = widget.users?.surname ?? '';
                        formData['email'] = widget.users?.email ?? '';
                        formData['phone'] = widget.users?.phone ?? '';
                        formData['status'] = widget.users?.status ?? false;

                        try {
                          if (widget.users == null) {
                            await _usersProvider.insert(formData);
                          } else {
                            await _usersProvider.update(
                                widget.users!.id!, formData);
                          }

                          if (widget.onClose != null) {
                            widget.onClose!();
                          }

                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("Success"),
                              content: Text("Profile data saved successfully."),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  ),
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
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: Text("Save"),
                  )
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
                    decoration: InputDecoration(labelText: "Password"),
                    name: 'password',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Password is required'),
                      FormBuilderValidators.minLength(4),
                      FormBuilderValidators.maxLength(50),
                    ])),
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
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
