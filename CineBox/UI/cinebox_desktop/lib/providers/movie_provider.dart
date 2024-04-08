import 'dart:convert';

import 'package:cinebox_desktop/models/movie.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MovieProvider extends BaseProvider<Movie> {
  MovieProvider() : super("Movie");

  @override
  Movie fromJson(data) {
    return Movie.fromJson(data);
  }

  @override
  Future<Movie> insert(request) async {
    var url = "http://localhost:7137/Movie";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(
        {...request, 'releaseDate': request['releaseDate'].toIso8601String()});

    // var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  @override
  Future<Movie> update(int id, [request]) async {
    var url = "http://localhost:7137/Movie/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(
        {...request, 'releaseDate': request['releaseDate'].toIso8601String()});

    // var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }
}
