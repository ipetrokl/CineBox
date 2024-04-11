import 'dart:convert';
import 'dart:io';

import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/genre_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  Movie? movie;
  MovieDetailScreen({super.key, this.movie});

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'genreId': widget.movie?.genreId.toString(),
      'title': widget.movie?.title,
      'description': widget.movie?.description,
      'releaseDate': widget.movie?.releaseDate,
      'duration': widget.movie?.duration.toString(),
      'director': widget.movie?.director
    };

    _movieProvider = context.read<MovieProvider>();
    _genreProvider = context.read<GenreProvider>();
    initForm();
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

  Future initForm() async {
    genreResult = await _genreProvider.get();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: widget.movie?.title ?? "Movie Details",
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

                      var request = new Map.from(_formKey.currentState!.value);
                      request['picture'] = _base64Image;

                      try {
                        if (widget.movie == null) {
                          await _movieProvider.insert(request);
                        } else {
                          await _movieProvider.update(
                              widget.movie!.id!, request);
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
                  decoration: InputDecoration(labelText: "Title"),
                  name: 'title',
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Description"),
                  name: 'description',
                ),
                SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: "releaseDate",
                  inputType: InputType.both,
                  decoration: const InputDecoration(labelText: "Release Date"),
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Duration"),
                  name: 'duration',
                ),
                SizedBox(height: 20),
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
                  items: genreResult?.result
                          .map((item) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: item.id.toString(),
                                child: Text(item.name ?? ""),
                              ))
                          .toList() ??
                      [],
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Director"),
                  name: 'director',
                ),
                SizedBox(height: 20),
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
                            : Icon(Icons.photo),
                        title: Text("Select image"),
                        trailing: Icon(Icons.file_upload),
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
