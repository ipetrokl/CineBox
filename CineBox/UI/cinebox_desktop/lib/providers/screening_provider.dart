
import 'dart:convert';

import 'package:cinebox_desktop/models/screening.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class ScreeningProvider extends BaseProvider<Screening> {
  ScreeningProvider() : super("Screening");

  @override
  Screening fromJson(data) {

    return Screening.fromJson(data);
  }

  @override
  Future<Screening> insert(request) async {
    var url = "http://localhost:7137/Screening";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode({
      ...request,
      'startTime': request['startTime'].toIso8601String(),
      'endTime': request['endTime'].toIso8601String(),
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
  Future<Screening> update(int id, [request]) async {
    var url = "http://localhost:7137/Screening/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode({
      ...request,
      'startTime': request['startTime'].toIso8601String(),
      'endTime': request['endTime'].toIso8601String(),
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