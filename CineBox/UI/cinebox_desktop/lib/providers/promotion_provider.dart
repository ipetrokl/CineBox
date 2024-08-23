import 'dart:convert';

import 'package:cinebox_desktop/models/Promotion/promotion.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;


class PromotionProvider extends BaseProvider<Promotion> {
  PromotionProvider() : super("Promotion");

  @override
  Promotion fromJson(data) {

    return Promotion.fromJson(data);
  }

  @override
  Future<Promotion> insert(request) async {
    var url = "http://localhost:7137/Promotion";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(
        {...request, 'expirationDate': request['expirationDate'].toIso8601String()});

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
  Future<Promotion> update(int id, [request]) async {
    var url = "http://localhost:7137/Promotion/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(
        {...request, 'expirationDate': request['expirationDate'].toIso8601String()});

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