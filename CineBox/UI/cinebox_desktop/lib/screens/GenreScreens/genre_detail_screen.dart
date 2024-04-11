
import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/providers/genre_provider.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class GenreDetailScreen extends StatefulWidget {
  Genre? genre;
  GenreDetailScreen({super.key, this.genre});

  @override
  State<GenreDetailScreen> createState() => _GenreDetailScreenState();
}

class _GenreDetailScreenState extends State<GenreDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late GenreProvider _genreProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'name': widget.genre?.name,
    };

    _genreProvider = context.read<GenreProvider>();
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

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: widget.genre?.name ?? "Genre Details",
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

                      try {
                        if (widget.genre == null) {
                          await _genreProvider.insert(_formKey.currentState?.value);
                        } else {
                          await _genreProvider.update(
                              widget.genre!.id!, _formKey.currentState?.value);
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
                  decoration: InputDecoration(labelText: "Name"),
                  name: 'name',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
