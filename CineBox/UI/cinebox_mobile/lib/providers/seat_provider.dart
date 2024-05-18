import 'dart:convert';
import 'package:cinebox_mobile/models/Seat/seat.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SeatProvider extends BaseProvider<Seat> {
  SeatProvider() : super("Seat");

  @override
  Seat fromJson(data) {
    return Seat.fromJson(data);
  }
}