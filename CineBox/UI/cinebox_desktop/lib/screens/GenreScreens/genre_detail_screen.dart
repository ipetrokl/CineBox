import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/providers/genre_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class GenreDetailScreen extends StatefulWidget {
  Genre? genre;
  final OnDialogClose? onClose;
  GenreDetailScreen({super.key, this.genre, this.onClose});

  @override
  State<GenreDetailScreen> createState() => _GenreDetailScreenState();
}

class _GenreDetailScreenState extends State<GenreDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late GenreProvider _genreProvider;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'name': widget.genre?.name,
    };

    _genreProvider = context.read<GenreProvider>();
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
                              if (widget.genre == null) {
                                await _genreProvider
                                    .insert(_formKey.currentState?.value);
                              } else {
                                await _genreProvider.update(widget.genre!.id!,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
