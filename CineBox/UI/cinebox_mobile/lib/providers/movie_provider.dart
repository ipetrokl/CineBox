import 'dart:convert';
import 'dart:io';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class MovieProvider extends BaseProvider<Movie> {
  MovieProvider() : super("Movie");

  @override
  Movie fromJson(data) {
    return Movie.fromJson(data);
  }

  Future<List<Movie>> getRecommendedMovies(int userId, DateTime selectedDate) async {
    String _endPoint = "Movie/GetRecommendedMovies/$userId/$selectedDate";

    var url = "${BaseProvider.baseUrl}$_endPoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body) as List;
      return data
          .map((json) => Movie.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw new Exception("Failed to fetch data for ID: $userId");
    }
  }
}
