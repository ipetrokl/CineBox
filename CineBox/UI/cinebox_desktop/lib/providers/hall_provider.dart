import 'dart:convert';

import 'package:cinebox_desktop/models/Hall/hall.dart';
import 'package:cinebox_desktop/models/Reports/hallOccupancyReport.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class HallProvider extends BaseProvider<Hall> {
  HallProvider() : super("Hall");

  @override
  Hall fromJson(data) {
    return Hall.fromJson(data);
  }

  Future<List<HallOccupancyReport>> fetchHallOccupancyReport(
      DateTime selectedDate, int cinemaId) async {
    final String url =
        '${BaseProvider.baseUrl}Hall/occupancy?selectedDate=${selectedDate.toIso8601String()}&cinemaId=$cinemaId';

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => HallOccupancyReport.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load occupancy report');
    }
  }
}
