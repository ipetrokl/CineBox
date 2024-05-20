import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/models/Seat/seat.dart';

class Cart {
  List<CartItem> items = [];
}

class CartItem {
  late Movie movie;
  late double amount;
  late int count;
  late Screening screening;
  late int cinemaId;
  final List<Seat> selectedSeats;
  CartItem(this.movie, this.count, this.amount, this.screening, this.cinemaId,
      this.selectedSeats);

  String getSeatNumbersString() {
    return selectedSeats.map((seat) => seat.seatNumber).join(', ');
  }
}
