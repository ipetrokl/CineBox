import 'package:cinebox_desktop/models/Cinema/cinema.dart';
import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/models/News/news.dart';
import 'package:cinebox_desktop/models/Promotion/promotion.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:cinebox_desktop/providers/news_provider.dart';
import 'package:cinebox_desktop/providers/promotion_provider.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
    // TODO: implement initState
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
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // if (widget.movie != null) {
    //   setState(() {
    //     _formKey.currentState?.patchValue({'title': widget.movie?.title});
    //   });
    // }
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
        insetPadding: const EdgeInsets.all(200),
        child: SingleChildScrollView(
          child: Column(
            children: [
              isLoading ? const SizedBox() : _buildForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 70)),
                  ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState?.saveAndValidate();

                        var request = Map.from(_formKey.currentState!.value);
                        request['createdDate'] = DateTime.now();

                        try {
                          if (widget.news == null) {
                            await _newsProvider
                                .insert(request);
                          } else {
                            await _newsProvider.update(
                                widget.news!.id!, request);
                          }

                          if (widget.onClose != null) {
                            widget.onClose!();
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
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Description"),
                  name: 'description',
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
