import 'package:cinebox_desktop/models/Cinema/cinema.dart';
import 'package:cinebox_desktop/models/News/news.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:cinebox_desktop/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class NewsDetailScreen extends StatefulWidget {
  News? news;
  final OnDialogClose? onClose;
  NewsDetailScreen({super.key, this.news, this.onClose});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late NewsProvider _newsProvider;
  late CinemaProvider _cinemaProvider;
  SearchResult<Cinema>? cinemaResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'cinema': widget.news?.cinemaId.toString(),
      'name': widget.news?.name,
      'description': widget.news?.description,
    };

    _newsProvider = context.read<NewsProvider>();
    _cinemaProvider = context.read<CinemaProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    cinemaResult = await _cinemaProvider.get();
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
                isLoading ? const SizedBox() : _buildForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 70)),
                    ElevatedButton(
                        onPressed: () async {
                          _formKey.currentState?.save();

                          var request = Map.from(_formKey.currentState!.value);
                          request['createdDate'] = DateTime.now();

                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              if (widget.news == null) {
                                await _newsProvider.insert(request);
                              } else {
                                await _newsProvider.update(
                                    widget.news!.id!, request);
                              }

                              _formKey.currentState?.reset();
                              _formKey.currentState?.fields['cinemaId']
                                  ?.reset();

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
                  name: 'cinemaId',
                  decoration: InputDecoration(
                    labelText: 'Cinema',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['cinemaId']?.reset();
                      },
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Cinema is required'),
                  ]),
                  items: cinemaResult?.result
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
                  decoration: InputDecoration(labelText: "Name"),
                  name: 'name',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Name is required'),
                  ]),
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Description"),
                  name: 'description',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Description is required'),
                  ]),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
