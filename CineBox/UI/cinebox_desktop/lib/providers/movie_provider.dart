import 'dart:convert';

import 'package:cinebox_desktop/models/movie.dart';
import 'package:cinebox_desktop/models/search_result.dart';
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

  Future<SearchResult<Movie>> get() async {
    var url = "$_baseURL$_endPoint";

    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<Movie>();

      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(Movie.fromJson(item));
      }

      // "id": 1,
      // "title": "Brzi i Zestoki",
      // "description": "super film",
      // "releaseDate": "2024-03-17T00:00:00",
      // "duration": 3,
      // "genre": "Action",
      // "director": "Ante Antic",

      return result;
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
