import 'package:cinebox_mobile/models/Seat/seat.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class SeatProvider extends BaseProvider<Seat> {
  SeatProvider() : super("Seat");

  @override
  Seat fromJson(data) {
    return Seat.fromJson(data);
  }
}