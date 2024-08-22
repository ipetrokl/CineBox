import 'dart:convert';
import 'dart:io';
import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends BaseProvider<Users> {
  UsersProvider() : super("Users");

  Future<dynamic> registerUser(dynamic userData) async {
    String _baseURL = Platform.isIOS
        ? "http://localhost:7137/" // iOS
        : "http://10.0.2.2:7137/"; // Android

    String _endPoint = "Users/register";

    var url = "$_baseURL$_endPoint";
    var uri = Uri.parse(url);

    var jsonRequest = jsonEncode(userData);
    var headers = {"Content-Type": "application/json"};

    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw new Exception("Unknown error");
    }
  }

  @override
  Users fromJson(data) {
    return Users.fromJson(data);
  }
}
