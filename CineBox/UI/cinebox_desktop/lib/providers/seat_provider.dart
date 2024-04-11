import 'package:cinebox_desktop/models/Seat/seat.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class SeatProvider extends BaseProvider<Seat> {
  SeatProvider() : super("Seat");

  @override
  Seat fromJson(data) {

    return Seat.fromJson(data);
  }
}