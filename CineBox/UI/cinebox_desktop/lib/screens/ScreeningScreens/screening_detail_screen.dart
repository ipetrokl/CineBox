import 'package:cinebox_desktop/models/Hall/hall.dart';
import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/models/Screening/screening.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/hall_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/screening_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class ScreeningDetailScreen extends StatefulWidget {
  Screening? screening;
  final OnDialogClose? onClose;
  ScreeningDetailScreen({super.key, this.screening, this.onClose});

  @override
  State<ScreeningDetailScreen> createState() => _ScreeningDetailScreenState();
}

class _ScreeningDetailScreenState extends State<ScreeningDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late MovieProvider _movieProvider;
  late HallProvider _hallProvider;
  late ScreeningProvider _screeningProvider;
  SearchResult<Movie>? movieResult;
  SearchResult<Hall>? hallResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'movieId': widget.screening?.movieId.toString(),
      'hallId': widget.screening?.hallId.toString(),
      'category': widget.screening?.category,
      'screeningTime': widget.screening?.screeningTime,
      'price': widget.screening?.price.toString()
    };

    _movieProvider = context.read<MovieProvider>();
    _hallProvider = context.read<HallProvider>();
    _screeningProvider = context.read<ScreeningProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    movieResult = await _movieProvider.get();
    hallResult = await _hallProvider.get();
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
                              if (widget.screening == null) {
                                await _screeningProvider
                                    .insert(_formKey.currentState?.value);
                              } else {
                                await _screeningProvider.update(
                                    widget.screening!.id!,
                                    _formKey.currentState?.value);
                              }

                              _formKey.currentState?.reset();
                              _formKey.currentState?.fields['movieId']?.reset();
                              _formKey.currentState?.fields['hallId']?.reset();

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
                SizedBox(height: 20),
                FormBuilderDropdown<String>(
                  name: 'hallId',
                  decoration: InputDecoration(
                    labelText: 'Halls',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['hallId']?.reset();
                      },
                    ),
                    hintText: 'Select Hall',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Hall is required'),
                  ]),
                  items: hallResult?.result
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
                        name: "screeningTime",
                        inputType: InputType.both,
                        decoration:
                            const InputDecoration(labelText: "Screening Time"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Screening time is required'),
                        ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Category"),
                  name: 'category',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Category is required'),
                  ]),
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Price"),
                  name: 'price',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Price is required'),
                    FormBuilderValidators.numeric(
                        errorText: 'Price must be a valid number'),
                    (value) {
                      final num? parsedValue = num.tryParse(value!);
                      if (parsedValue == null ||
                          parsedValue < 0.01 ||
                          parsedValue > 1000.00) {
                        return 'Price must be between 0.01€ and 1,000.00€';
                      }
                      return null;
                    },
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
