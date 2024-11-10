import 'package:cinebox_desktop/models/Promotion/promotion.dart';
import 'package:cinebox_desktop/providers/promotion_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class PromotionDetailScreen extends StatefulWidget {
  Promotion? promotion;
  final OnDialogClose? onClose;
  PromotionDetailScreen({super.key, this.promotion, this.onClose});

  @override
  State<PromotionDetailScreen> createState() => _PromotionDetailScreenState();
}

class _PromotionDetailScreenState extends State<PromotionDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late PromotionProvider _promotionProvider;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'code': widget.promotion?.code,
      'discount': widget.promotion?.discount.toString(),
      'expirationDate': widget.promotion?.expirationDate,
    };

    _promotionProvider = context.read<PromotionProvider>();
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
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 70)),
                    ElevatedButton(
                        onPressed: () async {
                          _formKey.currentState?.save();

                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              if (widget.promotion == null) {
                                await _promotionProvider
                                    .insert(_formKey.currentState?.value);
                              } else {
                                await _promotionProvider.update(
                                    widget.promotion!.id!,
                                    _formKey.currentState?.value);
                              }

                              _formKey.currentState?.reset();

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
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Code"),
                  name: 'code',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Code is required'),
                  ]),
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Discount"),
                  name: 'discount',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Discount is required'),
                    FormBuilderValidators.numeric(
                        errorText: 'Discount must be a valid number'),
                    (value) {
                      final num? parsedValue = num.tryParse(value!);
                      if (parsedValue == null ||
                          parsedValue < 1.00 ||
                          parsedValue > 100.00) {
                        return 'Discount must be between 1% and 100%';
                      }
                      return null;
                    },
                  ]),
                ),
                SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: "expirationDate",
                  inputType: InputType.both,
                  decoration:
                      const InputDecoration(labelText: "Expiration Date"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Expiration date is required'),
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
