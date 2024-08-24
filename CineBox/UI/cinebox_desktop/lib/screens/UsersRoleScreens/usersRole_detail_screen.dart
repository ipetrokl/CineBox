import 'package:cinebox_desktop/models/Role/role.dart';
import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/UsersRole/usersRole.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/role_provider.dart';
import 'package:cinebox_desktop/providers/usersRole_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class UsersRoleDetailScreen extends StatefulWidget {
  UsersRole? usersRole;
  final OnDialogClose? onClose;
  UsersRoleDetailScreen({super.key, this.usersRole, this.onClose});

  @override
  State<UsersRoleDetailScreen> createState() => _UsersRoleDetailScreenState();
}

class _UsersRoleDetailScreenState extends State<UsersRoleDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late UsersRoleProvider _usersRoleProvider;
  late UsersProvider _usersProvider;
  late RoleProvider _roleProvider;
  SearchResult<Users>? usersResult;
  SearchResult<Role>? roleResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'userId': widget.usersRole?.userId.toString(),
      'roleId': widget.usersRole?.roleId.toString(),
      'dateOfModification': widget.usersRole?.dateOfModification,
    };

    _usersRoleProvider = context.read<UsersRoleProvider>();
    _usersProvider = context.read<UsersProvider>();
    _roleProvider = context.read<RoleProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    usersResult = await _usersProvider.get();
    roleResult = await _roleProvider.get();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: const Color.fromRGBO(214, 212, 203, 1),
        insetPadding: const EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              isLoading ? Container() : _buildForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 70)),
                  ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState?.saveAndValidate();
          
                        try {
                          if (widget.usersRole == null) {
                            await _usersRoleProvider
                                .insert(_formKey.currentState?.value);
                          } else {
                            await _usersRoleProvider.update(
                                widget.usersRole!.usersRolesId!,
                                _formKey.currentState?.value);
                          }
          
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
                FormBuilderDropdown<String>(
                  name: 'userId',
                  decoration: InputDecoration(
                    labelText: 'User',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['userId']?.reset();
                      },
                    ),
                  ),
                  items: usersResult?.result
                          .map((item) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: item.id.toString(),
                                child: Text(item.name ?? ""),
                              ))
                          .toList() ??
                      [],
                ),
                SizedBox(height: 20),
                FormBuilderDropdown<String>(
                  name: 'roleId',
                  decoration: InputDecoration(
                    labelText: 'Role',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['roleId']?.reset();
                      },
                    ),
                  ),
                  items: roleResult?.result
                          .map((item) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: item.id.toString(),
                                child: Text(item.name ?? ""),
                              ))
                          .toList() ??
                      [],
                ),
                SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: "dateOfModification",
                  inputType: InputType.both,
                  decoration:
                      const InputDecoration(labelText: "Date of moficitaion"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
