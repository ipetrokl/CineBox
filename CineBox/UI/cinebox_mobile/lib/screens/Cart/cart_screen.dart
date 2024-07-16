import 'dart:convert';
import 'package:cinebox_mobile/models/Cart/cart.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/models/Seat/seat.dart';
import 'package:cinebox_mobile/providers/booking_provider.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/cinema_provider.dart';
import 'package:cinebox_mobile/providers/hall_provider.dart';
import 'package:cinebox_mobile/screens/Booking/booking_screen.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/cart";
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;

  const CartScreen(
      {super.key,
      required this.cinemaId,
      required this.initialDate,
      required this.cinemaName});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider _cartProvider;
  late BookingProvider _bookingProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartProvider = context.watch<CartProvider>();
    _bookingProvider = context.read<BookingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      cinemaId: widget.cinemaId,
      initialDate: widget.initialDate,
      cinemaName: widget.cinemaName,
      child: Column(
        children: [
          Expanded(
              child: Scrollbar(
                  trackVisibility: true, child: _buildProductCardList())),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Total: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(
                                _calculateTotal() % 1 == 0
                                    ? "${_calculateTotal().toInt()} €"
                                    : "${_calculateTotal().toStringAsFixed(2)} €",
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                        thickness: 1, color: Color.fromRGBO(97, 72, 199, 1)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(5),
                            backgroundColor:
                                const Color.fromRGBO(97, 72, 199, 1)),
                        onPressed: _cartProvider.cart.items.isEmpty
                            ? () {
                                _showEmptyCartMessage(context);
                              }
                            : () {
                                Navigator.pushNamed(
                                    context, BookingScreen.routeName,
                                    arguments: {
                                      'cinemaId': widget.cinemaId,
                                      'initialDate': widget.initialDate,
                                      'cinemaName': widget.cinemaName
                                    });
                              },
                        child: const Text(
                          "Proceed to payment",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEmptyCartMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Empty Cart'),
          content: Text('Your cart is empty. Please add items to proceed.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductCardList() {
    return ListView.builder(
      itemCount: _cartProvider.cart.items.length,
      itemBuilder: (context, index) {
        return _buildProductCard(_cartProvider.cart.items[index], index);
      },
    );
  }

  Widget _buildProductCard(CartItem item, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color.fromARGB(200, 21, 36, 118), width: 1)),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 6.0, right: 6),
          title: Row(
            children: [
              SizedBox(
                width: 70,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image:
                        item.movie.picture != null && item.movie.picture != ""
                            ? MemoryImage(base64Decode(item.movie.picture!))
                            : const AssetImage("assets/images/empty.jpg")
                                as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.movie.title ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        const Text("Cinema: ",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        FutureBuilder<String?>(
                          future: _fetchCinema(item.cinemaId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox.shrink();
                            } else if (snapshot.hasError) {
                              return Text("Error");
                            } else {
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Hall: ",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        FutureBuilder<String?>(
                          future: _fetchHall(item.movie, item.cinemaId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox.shrink();
                            } else if (snapshot.hasError) {
                              return Text("Error");
                            } else {
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Screening: ",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(item.screening.category!,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Seats: ",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(
                          item.getSeatNumbersString(),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Tickets: ",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(item.count.toString(),
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Price: ",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(
                            _formatPrice(
                                item.screening, item.selectedSeats, item),
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                      DateFormat('dd.MM.yyyy.')
                          .format(item.screening.screeningTime!),
                      style: const TextStyle(fontSize: 10)),
                  Text(
                      "${DateFormat('HH:mm').format(item.screening.screeningTime!)} h",
                      style: const TextStyle(fontSize: 10)),
                  SizedBox(height: 50),
                  IconButton(
                    alignment: Alignment.bottomRight,
                    iconSize: 18,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _cartProvider.removeFromSum(item.movie, item.screening);
                      _cartProvider.cart.items.removeAt(index);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _fetchHall(Movie movie, int cinemaId) async {
    late HallProvider _hallProvider;
    _hallProvider = context.read<HallProvider>();
    var data = await _hallProvider
        .get(filter: {'movieId': movie.id, 'cinemaId': cinemaId});
    String? hall = data.result[0].name;
    return hall;
  }

  String _formatPrice(Screening screening, List<Seat> seats, CartItem item) {
    double amount = 0;
    for (var seat in seats) {
      if (seat.category == "Double") {
        amount += screening.price! * 2;
      } else {
        amount += screening.price!;
      }
    }
    item.amount = amount;
    String formattedPrice =
        amount % 1 == 0 ? amount.toInt().toString() : amount.toStringAsFixed(2);

    return formattedPrice + " €";
  }

  Future<String?> _fetchCinema(int cinemaId) async {
    late CinemaProvider _cinemaProvider;
    _cinemaProvider = context.read<CinemaProvider>();
    var data = await _cinemaProvider.getById(cinemaId);
    String? cinema = data!.name;
    return cinema;
  }

  double _calculateTotal() {
    double sum = 0;
    for (var item in _cartProvider.cart.items) {
      sum += item.amount;
    }
    return sum;
  }
}
