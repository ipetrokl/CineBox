import 'dart:convert';
import 'dart:math';

import 'package:cinebox_mobile/models/Cart/cart.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/providers/booking_provider.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/cinema_provider.dart';
import 'package:cinebox_mobile/providers/hall_provider.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/util.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider _cartProvider;
  late BookingProvider _bookingProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _cartProvider = context.watch<CartProvider>();
    _bookingProvider = context.read<BookingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      child: Column(
        children: [
          Expanded(child: _buildProductCardList()),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Total: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(
                                _cartProvider.sum % 1 == 0
                                    ? _cartProvider.sum.toInt().toString() +
                                        " €"
                                    : _cartProvider.sum.toStringAsFixed(2) +
                                        " €",
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                        thickness: 1, color: Color.fromRGBO(97, 72, 199, 1)),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 5),
                        child: _buildBuyButton(),
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

  Widget _buildProductCardList() {
    return Container(
      child: ListView.builder(
        itemCount: _cartProvider.cart.items.length,
        itemBuilder: (context, index) {
          return _buildProductCard(_cartProvider.cart.items[index], index);
        },
      ),
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
          title: Row(
            children: [
              Text(item.count.toString(), style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 15),
              SizedBox(
                width: 60,
                height: 95,
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
                    Text(item.movie.title ?? ""),
                    Text(
                        DateFormat('HH:mm')
                                .format(item.screening.screeningTime!) +
                            " h",
                        style: const TextStyle(fontSize: 12)),
                    Row(
                      children: [
                        SizedBox(
                          height: 15,
                          child: FutureBuilder<String?>(
                            future: _fetchCinema(item.cinemaId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox.shrink();
                              } else if (snapshot.hasError) {
                                return Text("Error");
                              } else {
                                return Text(
                                  snapshot.data! + ", ",
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                          child: FutureBuilder<String?>(
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
                                    fontSize: 10,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(item.screening.category!,
                        style: const TextStyle(fontSize: 12)),
                    Row(
                      children: [
                        const Text("Price: ", style: TextStyle(fontSize: 12)),
                        Text(_formatPrice(item.screening, item.count),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                iconSize: 20,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _cartProvider.removeFromSum(item.movie, item.screening);
                  _cartProvider.cart.items.removeAt(index);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBuyButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(1),
          fixedSize: const Size(80, 20),
          backgroundColor: const Color.fromRGBO(97, 72, 199, 1)),
      child: Text(
        "Buy",
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () async {
        List<Map> items = [];
        _cartProvider.cart.items.forEach((item) {
          items.add({
            "id": item.movie.id,
            "amount": item.count,
          });
        });
        Map booking = {
          "items": items,
        };

        await _bookingProvider.insert(booking);

        _cartProvider.cart.items.clear();
        setState(() {});
      },
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

  String _formatPrice(Screening screening, int count) {
    double amount = screening.price! * count;
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
}
