import 'package:cinebox_desktop/models/Promotion/promotion.dart';
import 'package:cinebox_desktop/providers/promotion_provider.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
    // TODO: implement initState
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
    return Dialog(
        backgroundColor: const Color.fromRGBO(214, 212, 203, 1),
        insetPadding: const EdgeInsets.all(200),
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
                        if (widget.promotion == null) {
                          await _promotionProvider
                              .insert(_formKey.currentState?.value);
                        } else {
                          await _promotionProvider.update(widget.promotion!.id!,
                              _formKey.currentState?.value);
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
                  decoration: InputDecoration(labelText: "Code"),
                  name: 'code',
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Discount"),
                  name: 'discount',
                ),
                SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: "expirationDate",
                  inputType: InputType.both,
                  decoration:
                      const InputDecoration(labelText: "Expiration Date"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
