import 'package:cinebox_desktop/models/Cinema/cinema.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class CinemaDetailScreen extends StatefulWidget {
  Cinema? cinema;
  final OnDialogClose? onClose;
  CinemaDetailScreen({super.key, this.cinema, this.onClose});

  @override
  State<CinemaDetailScreen> createState() => _CinemaDetailScreenState();
}

class _CinemaDetailScreenState extends State<CinemaDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late CinemaProvider _cinemaProvider;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'name': widget.cinema?.name,
      'location': widget.cinema?.location,
    };

    _cinemaProvider = context.read<CinemaProvider>();
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
        child: SingleChildScrollView(
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
                          if (widget.cinema == null) {
                            await _cinemaProvider
                                .insert(_formKey.currentState?.value);
                          } else {
                            await _cinemaProvider.update(
                                widget.cinema!.id!, _formKey.currentState?.value);
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
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Name"),
                  name: 'name',
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Location"),
                  name: 'location',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
