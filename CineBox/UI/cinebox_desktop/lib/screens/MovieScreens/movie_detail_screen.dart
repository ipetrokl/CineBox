import 'dart:convert';
import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/Picture/picture.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/genre_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/picture_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  late PictureProvider _pictureProvider;
  SearchResult<Genre>? genreResult;
  SearchResult<Picture>? pictureResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'genreId': widget.movie?.genreId.toString(),
      'title': widget.movie?.title,
      'description': widget.movie?.description,
      'performedFrom': widget.movie?.performedFrom,
      'performedTo': widget.movie?.performedTo,
      'director': widget.movie?.director,
      'pictureId': widget.movie?.pictureId.toString()
    };

    _movieProvider = context.read<MovieProvider>();
    _genreProvider = context.read<GenreProvider>();
    _pictureProvider = context.read<PictureProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    genreResult = await _genreProvider.get();
    pictureResult = await _pictureProvider.get();
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
            isLoading ? const SizedBox() : _buildForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 70)),
                ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState?.saveAndValidate();

                      var request = Map.from(_formKey.currentState!.value);

                      try {
                        if (widget.movie == null) {
                          await _movieProvider.insert(request);
                        } else {
                          await _movieProvider.update(
                              widget.movie!.id!, request);
                        }
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
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Error"),
                                  content: Text(e.toString()),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("OK"))
                                  ],
                                ));
                      }
                    },
                    child: const Text("Save"))
              ],
            ),
          ],
        ),
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
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: "Description"),
                  name: 'description',
                ),
                const SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: "performedFrom",
                  inputType: InputType.both,
                  decoration:
                      const InputDecoration(labelText: "Performed From"),
                ),
                const SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: "performedTo",
                  inputType: InputType.both,
                  decoration: const InputDecoration(labelText: "Performed To"),
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
                ),
                const SizedBox(height: 20),
                FormBuilderDropdown<String>(
                  name: 'pictureId',
                  decoration: InputDecoration(
                    labelText: 'Picture',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['pictureId']?.reset();
                      },
                    ),
                  ),
                  items: pictureResult?.result.map((item) {
                        final imageBytes = item.picture1 != null
                            ? base64Decode(item.picture1!)
                            : null;
                        return DropdownMenuItem(
                          value: item.id.toString(),
                          child: Row(
                            children: [
                              if (imageBytes != null)
                                Image.memory(imageBytes, width: 40, height: 40),
                              SizedBox(width: 8),
                              Text(item.id.toString()),
                            ],
                          ),
                        );
                      }).toList() ??
                      [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
