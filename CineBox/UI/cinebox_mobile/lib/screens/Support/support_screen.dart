import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:cinebox_mobile/providers/users_provider.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';

class SupportScreen extends StatefulWidget {
  static const String routeName = "/support";
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;

  SupportScreen(
      {super.key,
      required this.cinemaId,
      required this.initialDate,
      required this.cinemaName});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UsersProvider _usersProvider;
  SearchResult<Users>? result;

  @override
  void initState() {
    super.initState();
    _usersProvider = context.read<UsersProvider>();
    loadData();
  }

  Future loadData() async {
    try {
      var data = await _usersProvider.get();

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  Future<void> _sendEmail(String name, String email, String content) async {
    var support = await _usersProvider.get(filter: {'username': "support"});
    String username = '';
    String password = '';
    if (support.result.isNotEmpty) {
      username = support.result.first.email!;
      password = support.result.first.surname!;
    }

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'CineBox')
      ..recipients.add(username)
      ..subject = 'Support Request from $name'
      ..text =
          'Cinema: ${widget.cinemaName}\n\nName: $name\n\nEmail: $email\n\n$content';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      _formKey.currentState?.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email sent successfully!')),
      );
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to send email. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      cinemaId: widget.cinemaId,
      initialDate: widget.initialDate,
      cinemaName: widget.cinemaName,
      child: Column(
        children: [
          Expanded(
            child: _buildSupport(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final name = _formKey
                            .currentState?.fields['nameAndSurname']?.value ??
                        '';
                    final email =
                        _formKey.currentState?.fields['email']?.value ?? '';
                    final content =
                        _formKey.currentState?.fields['content']?.value ?? '';

                    if (name.isNotEmpty &&
                        email.isNotEmpty &&
                        content.isNotEmpty) {
                      await _sendEmail(name, email, content);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Email sent successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Validation failed. Please check your input.'),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Validation failed. Please check your input.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(97, 72, 199, 1)),
                child: const Text("Send"),
              )
            ],
          ),
        ],
      ),
    );
  }

  FormBuilder _buildSupport() {
    return FormBuilder(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Email Support",
                  style: TextStyle(
                      fontSize: 20, color: Colors.black.withAlpha(160)),
                ),
              ),
              SizedBox(height: 30),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Name and Surname"),
                name: 'nameAndSurname',
              ),
              SizedBox(height: 15),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Email"),
                name: 'email',
              ),
              SizedBox(height: 35),
              FormBuilderTextField(
                decoration: const InputDecoration(
                  labelText: "Here write for our support",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                name: 'content',
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
