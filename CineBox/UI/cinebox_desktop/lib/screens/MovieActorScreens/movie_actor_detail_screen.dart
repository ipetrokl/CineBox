import 'package:cinebox_desktop/models/Actor/actor.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/MovieActor/movieActor.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/actor_provider.dart';
import 'package:cinebox_desktop/providers/movie_actor_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class MovieActorDetailScreen extends StatefulWidget {
  MovieActor? movieActor;
  final OnDialogClose? onClose;
  MovieActorDetailScreen({super.key, this.movieActor, this.onClose});

  @override
  State<MovieActorDetailScreen> createState() => _MovieActorDetailScreenState();
}

class _MovieActorDetailScreenState extends State<MovieActorDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late MovieActorProvider _movieActorProvider;
  late MovieProvider _movieProvider;
  late ActorProvider _actorProvider;
  SearchResult<Movie>? movieResult;
  SearchResult<Actor>? actorResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'movieId': widget.movieActor?.movieId.toString(),
      'actorId': widget.movieActor?.actorId.toString(),
    };

    _movieActorProvider = context.read<MovieActorProvider>();
    _movieProvider = context.read<MovieProvider>();
    _actorProvider = context.read<ActorProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    movieResult = await _movieProvider.get();
    actorResult = await _actorProvider.get();
    setState(() {
      isLoading = false;
    });
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
                isLoading ? Container() : _buildForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 70)),
                    ElevatedButton(
                        onPressed: () async {
                          _formKey.currentState?.save();

                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              if (widget.movieActor == null) {
                                await _movieActorProvider
                                    .insert(_formKey.currentState?.value);
                              } else {
                                await _movieActorProvider.update(
                                    widget.movieActor!.id!,
                                    _formKey.currentState?.value);
                              }

                              _formKey.currentState?.reset();
                              _formKey.currentState?.fields['movieId']?.reset();
                              _formKey.currentState?.fields['actorId']?.reset();

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
                FormBuilderDropdown<String>(
                  name: 'movieId',
                  decoration: InputDecoration(
                    labelText: 'Movies',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['movieId']?.reset();
                      },
                    ),
                    hintText: 'Select Movie',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Movie is required'),
                  ]),
                  items: movieResult?.result
                          .map((item) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: item.id.toString(),
                                child: Text(item.title ?? ""),
                              ))
                          .toList() ??
                      [],
                ),
                FormBuilderDropdown<String>(
                  name: 'actorId',
                  decoration: InputDecoration(
                    labelText: 'Actors',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['actorId']?.reset();
                      },
                    ),
                    hintText: 'Select Actor',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Actor is required'),
                  ]),
                  items: actorResult?.result
                          .map((item) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: item.id.toString(),
                                child: Text(item.name ?? ""),
                              ))
                          .toList() ??
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
