import 'dart:convert';
import 'dart:io';

import 'package:cinebox_desktop/models/cinema.dart';
import 'package:cinebox_desktop/models/movie.dart';
import 'package:cinebox_desktop/models/screening.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/screening_provider.dart';
import 'package:cinebox_desktop/screens/screening_list_screen.dart';
import 'package:cinebox_desktop/widgets/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ScreeningDetailScreen extends StatefulWidget {
  Screening? screening;
  ScreeningDetailScreen({super.key, this.screening});

  @override
  State<ScreeningDetailScreen> createState() => _ScreeningDetailScreenState();
}

class _ScreeningDetailScreenState extends State<ScreeningDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late MovieProvider _movieProvider;
  late CinemaProvider _cinemaProvider;
  late ScreeningProvider _screeningProvider;
  SearchResult<Movie>? movieResult;
  SearchResult<Cinema>? cinemaResult;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'movieId': widget.screening?.movieId.toString(),
      'cinemaId': widget.screening?.cinemaId.toString(),
      'category': widget.screening?.category,
      'startTime': widget.screening?.startTime,
      'endTime': widget.screening?.endTime,
      'price': widget.screening?.price.toString()
    };

    _movieProvider = context.read<MovieProvider>();
    _cinemaProvider = context.read<CinemaProvider>();
    _screeningProvider = context.read<ScreeningProvider>();
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
    movieResult = await _movieProvider.get();
    cinemaResult = await _cinemaProvider.get();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: widget.screening?.category ?? "Screening Details",
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
                        if (widget.screening == null) {
                          await _screeningProvider
                              .insert(_formKey.currentState?.value);
                        } else {
                          await _screeningProvider.update(widget.screening!.id!,
                              _formKey.currentState?.value);
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
          width: 600,
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
                  items: movieResult?.result
                          .map((item) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: item.id.toString(),
                                child: Text(item.title ?? ""),
                              ))
                          .toList() ??
                      [],
                ),
                SizedBox(height: 20),
                FormBuilderDropdown<String>(
                  name: 'cinemaId',
                  decoration: InputDecoration(
                    labelText: 'Cinemas',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['cinemaId']?.reset();
                      },
                    ),
                    hintText: 'Select Cinema',
                  ),
                  items: cinemaResult?.result
                          .map((item) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: item.id.toString(),
                                child: Text(item.name ?? ""),
                              ))
                          .toList() ??
                      [],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDateTimePicker(
                        name: "startTime",
                        inputType: InputType.both,
                        decoration:
                            const InputDecoration(labelText: "Start Time"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: FormBuilderDateTimePicker(
                        name: "endTime",
                        inputType: InputType.both,
                        decoration:
                            const InputDecoration(labelText: "End Time"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Category"),
                  name: 'category',
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Price"),
                  name: 'price',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
