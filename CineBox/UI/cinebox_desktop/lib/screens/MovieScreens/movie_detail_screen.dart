import 'dart:convert';
import 'dart:io';
import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/Picture/picture.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/genre_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class MovieDetailScreen extends StatefulWidget {
  Movie? movie;
  final OnDialogClose? onClose;
  MovieDetailScreen({super.key, this.movie, this.onClose});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late MovieProvider _movieProvider;
  late GenreProvider _genreProvider;
  SearchResult<Genre>? genreResult;
  bool isLoading = true;
  File? _selectedImage;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'genreId': widget.movie?.genreId.toString(),
      'title': widget.movie?.title,
      'description': widget.movie?.description,
      'performedFrom': widget.movie?.performedFrom,
      'performedTo': widget.movie?.performedTo,
      'director': widget.movie?.director
    };

    _movieProvider = context.read<MovieProvider>();
    _genreProvider = context.read<GenreProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    genreResult = await _genreProvider.get();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromRGBO(214, 212, 203, 1),
      insetPadding: const EdgeInsets.all(100),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                isLoading ? const SizedBox() : _buildForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 70)),
                    ElevatedButton(
                        onPressed: () async {
                          _formKey.currentState?.save();

                          final formData = Map<String, dynamic>.from(
                              _formKey.currentState!.value);

                          if (_base64Image != null) {
                            formData['pictureData'] = _base64Image;
                          }

                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              if (widget.movie == null) {
                                await _movieProvider.insert(formData);
                              } else {
                                await _movieProvider.update(
                                    widget.movie!.id!, formData);
                              }

                              _formKey.currentState?.reset();
                              _formKey.currentState?.fields['genreId']?.reset();
                              _formKey.currentState?.fields['pictureId']
                                  ?.reset();

                              if (widget.onClose != null) {
                                widget.onClose!();
                              }

                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Success"),
                                  content: const Text("Saved successfully."),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"),
                                    )
                                  ],
                                ),
                              );
                            } on Exception catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text("Error"),
                                        content: Text(e.toString()),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("OK"))
                                        ],
                                      ));
                            }
                          }
                        },
                        child: const Text("Save"))
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
        ],
      ),
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Center(
        child: Container(
          width: 800,
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: "Title"),
                  name: 'title',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Title is required'),
                  ]),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: "Description"),
                  name: 'description',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Description is required'),
                  ]),
                ),
                const SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: "performedFrom",
                  inputType: InputType.both,
                  decoration:
                      const InputDecoration(labelText: "Performed From"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Performed from is required'),
                  ]),
                ),
                const SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: "performedTo",
                  inputType: InputType.both,
                  decoration: const InputDecoration(labelText: "Performed To"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Performed to is required'),
                  ]),
                ),
                const SizedBox(height: 20),
                FormBuilderDropdown<String>(
                  name: 'genreId',
                  decoration: InputDecoration(
                    labelText: 'Genre',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['genreId']?.reset();
                      },
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Genre is required'),
                  ]),
                  items: genreResult?.result
                          .map((item) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: item.id.toString(),
                                child: Text(item.name ?? ""),
                              ))
                          .toList() ??
                      [],
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: "Director"),
                  name: 'director',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Director is required'),
                  ]),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: _selectedImage != null
                      ? Image.file(_selectedImage!, width: 50, height: 50)
                      : const Icon(Icons.photo),
                  title: const Text("Select image"),
                  trailing: const Icon(Icons.file_upload),
                  onTap: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                    );
                    if (result != null && result.files.single.path != null) {
                      setState(() {
                        _selectedImage = File(result.files.single.path!);
                        _base64Image =
                            base64Encode(_selectedImage!.readAsBytesSync());
                      });
                    }
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
