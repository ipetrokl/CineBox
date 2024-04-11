import 'package:cinebox_desktop/models/Role/role.dart';
import 'package:cinebox_desktop/providers/role_provider.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class RoleDetailScreen extends StatefulWidget {
  Role? role;
  RoleDetailScreen({super.key, this.role});

  @override
  State<RoleDetailScreen> createState() => _RoleDetailScreenState();
}

class _RoleDetailScreenState extends State<RoleDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late RoleProvider _roleProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'name': widget.role?.name,
      'description': widget.role?.description,
    };

    _roleProvider = context.read<RoleProvider>();
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
    return MasterScreen(
        title: widget.role?.name ?? "Role Details",
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
                        if (widget.role == null) {
                          await _roleProvider.insert(_formKey.currentState?.value);
                        } else {
                          await _roleProvider.update(
                              widget.role!.id!, _formKey.currentState?.value);
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Success"),
                            content: Text("Screening saved successfully."),
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
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Description"),
                  name: 'description',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
