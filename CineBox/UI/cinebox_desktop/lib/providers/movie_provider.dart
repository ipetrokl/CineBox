import 'dart:convert';

import 'package:cinebox_desktop/models/Movie/movie.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

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

    var jsonRequest = jsonEncode({
      ...request,
      'performedFrom': request['performedFrom']?.toIso8601String(),
      'performedTo': request['performedTo']?.toIso8601String()
    });

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

    var jsonRequest = jsonEncode({
      ...request,
      'performedFrom': request['performedFrom'].toIso8601String(),
      'performedTo': request['performedTo'].toIso8601String()
    });

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
