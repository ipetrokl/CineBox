import 'dart:convert';

import 'package:cinebox_desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MovieProvider with ChangeNotifier {
  static String? _baseURL;
  String _endPoint = "Movie";

  MovieProvider() {
    _baseURL = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7137/");
  }

  Future<dynamic> get() async {
    var url = "$_baseURL$_endPoint";

    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw new Exception("Unknown error");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw new Exception("Unauthorized");
    } else {
      throw new Exception("Something had happened please try again");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "content-type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }
}
