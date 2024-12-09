import 'dart:convert';

import 'package:cinebox_desktop/models/Reports/terminOccupiedReport.dart';
import 'package:cinebox_desktop/models/Screening/screening.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ScreeningProvider extends BaseProvider<Screening> {
  ScreeningProvider() : super("Screening");

  @override
  Screening fromJson(data) {
    return Screening.fromJson(data);
  }

  @override
  Future<Screening> insert(request) async {
    var url = "${BaseProvider.baseUrl}Screening";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode({
      ...request,
      'screeningTime': request['screeningTime']?.toIso8601String()
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
    var url = "${BaseProvider.baseUrl}Screening/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode({
      ...request,
      'screeningTime': request['screeningTime'].toIso8601String()
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

  Future<List<TerminOccupiedReport>> fetchTerminOccupiedReport() async {
    final String url = '${BaseProvider.baseUrl}Screening/termins';

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => TerminOccupiedReport.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load termins report');
    }
  }
}
