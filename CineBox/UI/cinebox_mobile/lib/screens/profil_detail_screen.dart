import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:cinebox_mobile/providers/users_provider.dart';
import 'package:cinebox_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class ProfilDetailScreen extends StatefulWidget {
  Users? users;
  final OnDialogClose? onClose;
  ProfilDetailScreen({super.key, this.users, this.onClose});

  @override
  State<ProfilDetailScreen> createState() => _ProfilDetailScreenState();
}

class _ProfilDetailScreenState extends State<ProfilDetailScreen> {
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
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        final formData = Map<String, dynamic>.from(
                            _formKey.currentState!.value);

                        formData['password'] = Authorization.password ?? '';
                        formData['passwordConfirmation'] =
                            Authorization.password ?? '';

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
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Validation failed. Please check your input.'),
                          ),
                        );
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
