import 'dart:convert';

import 'package:cinebox_desktop/models/News/news.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;


class NewsProvider extends BaseProvider<News> {
  NewsProvider() : super("News");

  @override
  News fromJson(data) {

    return News.fromJson(data);
  }

  @override
  Future<News> insert(request) async {
    var url = "http://localhost:7137/News";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode({
      ...request,
      'createdDate': request['createdDate']?.toIso8601String()
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
  Future<News> update(int id, [request]) async {
    var url = "http://localhost:7137/News/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode({
      ...request,
      'createdDate': request['createdDate'].toIso8601String()
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