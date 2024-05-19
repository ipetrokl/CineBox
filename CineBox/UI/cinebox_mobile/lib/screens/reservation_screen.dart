import 'package:cinebox_mobile/models/Cinema/cinema.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/models/Seat/seat.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/seat_provider.dart';
import 'package:cinebox_mobile/utils/Hall_utils/hall_seats.dart';
import 'package:cinebox_mobile/utils/Hall_utils/screen_object.dart';
import 'package:cinebox_mobile/utils/Hall_utils/seat_visualization.dart';
import 'package:cinebox_mobile/utils/Hall_utils/seat_type.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class ReservationScreen extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;
  final Movie movie;
  final Screening screening;
  final int cinemaId;
  const ReservationScreen(
      {super.key,
      this.initialValue = 0,
      required this.onChanged,
      required this.movie,
      required this.screening,
      required this.cinemaId});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late CartProvider _cartProvider;
  late SeatProvider _seatProvider;
  SearchResult<Seat>? seats;
  late int _counter = 0;
  List<Seat> selectedSeats = [];

  @override
  void initState() {
    super.initState();
    _cartProvider = context.read<CartProvider>();
    _seatProvider = context.read<SeatProvider>();
    fetchSeats();
    // _counter = widget.initialValue;
  }

  Future fetchSeats() async {
    try {
      var data =
          await _seatProvider.get(filter: {'hallId': widget.screening.hallId});
      setState(() {
        seats = data;
        for (var item in _cartProvider.cart.items) {
          if (widget.screening.id == item.screening.id) {
            selectedSeats = item.selectedSeats;
          }
        }
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //     widget.onChanged(_counter);
  //   });
  // }

  // void _decrementCounter() {
  //   setState(() {
  //     if (_counter > 0) {
  //       _counter--;
  //       widget.onChanged(_counter);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromARGB(255, 160, 150, 197),
      insetPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: 10.0),
            // _buildCounterWidget(),
            const SizedBox(height: 30.0),
            _buildCurvedScreen(),
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Screen",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 20.0),
            _buildSeats(),
            const SizedBox(height: 8.0),
            _buildSeatInfos(),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(1),
                      fixedSize: const Size(120, 20),
                      backgroundColor: const Color.fromRGBO(97, 72, 199, 1)),
                  child: const Text(
                    "Add to Basket",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () async {
                    if (_counter > 0) {
                      _cartProvider.addToCart(
                        widget.movie,
                        widget.screening,
                        widget.cinemaId,
                        selectedSeats,
                        _counter,
                      );
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                            title: const Center(
                                child: Text(
                              'Item added to basket  \u{1F389}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(97, 72, 199, 1)),
                            )),
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Zatvori trenutni dijalog
                                  Navigator.of(context).pop();
                                  // Zatvori glavni dijalog
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text('You need to choose minimum one seat.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildCounterWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(15),
  //               color: Color.fromARGB(255, 218, 205, 205)),
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Number of seats: ',
  //                   style: TextStyle(fontSize: 12),
  //                 ),
  //                 Row(
  //                   children: [
  //                     IconButton(
  //                       onPressed: _decrementCounter,
  //                       icon: const Icon(Icons.remove),
  //                     ),
  //                     Text(_counter.toString()),
  //                     IconButton(
  //                       onPressed: _incrementCounter,
  //                       icon: const Icon(Icons.add),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSeatInfos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        child: Row(
          children: [
            const Text("Available", style: TextStyle(fontSize: 10)),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.green,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.event_seat,
                      color: Colors.white,
                      size: 15,
                    ),
                  )),
            ),
            SizedBox(width: 20),
            const Text("Booked", style: TextStyle(fontSize: 10)),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.red,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.event_seat,
                      color: Colors.white,
                      size: 15,
                    ),
                  )),
            ),
            SizedBox(width: 20),
            const Text("Unavailable", style: TextStyle(fontSize: 10)),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.grey,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.event_seat,
                      color: Colors.white,
                      size: 15,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurvedScreen() {
    return CustomPaint(
      size: Size(330, 10),
      painter: ScreenPainter(),
    );
  }

  Widget _buildSeats() {
    if (seats == null) {
      return CircularProgressIndicator();
    } else {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: SeatBuilder.buildSeats(
            onSeatChanged: (int count) {
              setState(() {
                _counter = count;
              });
            },
            seats: seats!.result,
            selectedSeats: selectedSeats),
      );
    }
  }
}
