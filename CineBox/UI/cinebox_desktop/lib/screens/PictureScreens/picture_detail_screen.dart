import 'dart:convert';
import 'dart:io';
import 'package:cinebox_desktop/models/Picture/picture.dart';
import 'package:cinebox_desktop/providers/picture_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class PictureDetailScreen extends StatefulWidget {
  Picture? picture;
  final OnDialogClose? onClose;
  PictureDetailScreen({super.key, this.picture, this.onClose});

  @override
  State<PictureDetailScreen> createState() => _PictureDetailScreenState();
}

class _PictureDetailScreenState extends State<PictureDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late PictureProvider _pictureProvider;

  @override
  void initState() {
    super.initState();
    _initialValue = {};

    _pictureProvider = context.read<PictureProvider>();
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
                          _formKey.currentState?.saveAndValidate();

                          var request = Map.from(_formKey.currentState!.value);
                          request['picture1'] = _base64Image;

                          try {
                            if (widget.picture == null) {
                              await _pictureProvider.insert(request);
                            } else {
                              await _pictureProvider.update(
                                  widget.picture!.id!, request);
                            }

                            _formKey.currentState?.reset();
                            _formKey.currentState?.fields['imageId']?.reset();
                            setState(() {
                              _image = null;
                              _base64Image = null;
                            });

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
                                            onPressed: () =>
                                                Navigator.pop(context),
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
                FormBuilderField(
                  name: "imageId",
                  builder: (field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Choose image",
                        errorText: field.errorText,
                      ),
                      child: ListTile(
                        leading: _image != null
                            ? Image.file(_image!, width: 50, height: 50)
                            : const Icon(Icons.photo),
                        title: const Text("Select image"),
                        trailing: const Icon(Icons.file_upload),
                        onTap: () async {
                          var result = await FilePicker.platform
                              .pickFiles(type: FileType.image);

                          if (result != null &&
                              result.files.single.path != null) {
                            setState(() {
                              _image = File(result.files.single.path!);
                              _base64Image =
                                  base64Encode(_image!.readAsBytesSync());
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  File? _image;
  String? _base64Image;

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      setState(() {
        _image = File(result.files.single.path!);
        _base64Image = base64Encode(_image!.readAsBytesSync());
      });
    }
  }
}
