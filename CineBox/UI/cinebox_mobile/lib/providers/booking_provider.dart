

import 'package:cinebox_mobile/models/Booking/booking.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class BookingProvider extends BaseProvider<Booking> {
  BookingProvider() : super("Booking");

  @override
  fromJson(data) {
    // TODO: implement fromJson
    return Booking(1,1,1,1);
  }
}