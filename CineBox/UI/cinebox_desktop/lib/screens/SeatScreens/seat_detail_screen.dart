import 'package:cinebox_desktop/models/Hall/hall.dart';
import 'package:cinebox_desktop/models/Seat/seat.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/hall_provider.dart';
import 'package:cinebox_desktop/providers/seat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class SeatDetailScreen extends StatefulWidget {
  Seat? seat;
  final OnDialogClose? onClose;
  SeatDetailScreen({super.key, this.seat, this.onClose});

  @override
  State<SeatDetailScreen> createState() => _SeatDetailScreenState();
}

class _SeatDetailScreenState extends State<SeatDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late SeatProvider _seatProvider;
  late HallProvider _hallProvider;
  SearchResult<Hall>? hallResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'hallId': widget.seat?.hallId.toString(),
      'seatNumber': widget.seat?.seatNumber.toString(),
      'category': widget.seat?.category,
      'status': widget.seat?.status ?? true,
    };

    _seatProvider = context.read<SeatProvider>();
    _hallProvider = context.read<HallProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
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
                              if (widget.seat == null) {
                                await _seatProvider
                                    .insert(_formKey.currentState?.value);
                              } else {
                                await _seatProvider.update(widget.seat!.id!,
                                    _formKey.currentState?.value);
                              }

                              _formKey.currentState?.reset();
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
          width: 800,
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilderDropdown<String>(
                  name: 'hallId',
                  decoration: InputDecoration(
                    labelText: 'Hall',
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
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Seat Number"),
                  name: 'seatNumber',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Seat number is required'),
                    FormBuilderValidators.numeric(
                        errorText: 'Price must be a valid number'),
                  ]),
                ),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Category"),
                  name: 'category',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Category is required'),
                  ]),
                ),
                FormBuilderCheckbox(
                  name: 'status',
                  title: Text('Active'),
                  initialValue: _initialValue['active'],
                  onChanged: (value) {
                    setState(() {
                      _initialValue['active'] = value;
                    });
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
