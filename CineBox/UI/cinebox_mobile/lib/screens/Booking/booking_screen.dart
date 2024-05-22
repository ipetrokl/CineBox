import 'dart:convert';
import 'dart:math';
import 'package:cinebox_mobile/models/Cart/cart.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/models/Seat/seat.dart';
import 'package:cinebox_mobile/providers/booking_provider.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/cinema_provider.dart';
import 'package:cinebox_mobile/providers/hall_provider.dart';
import 'package:cinebox_mobile/providers/promotion_provider.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/util.dart';

class BookingScreen extends StatefulWidget {
  static const String routeName = "/booking";
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;

  const BookingScreen(
      {super.key,
      required this.cinemaId,
      required this.initialDate,
      required this.cinemaName});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late CartProvider _cartProvider;
  late BookingProvider _bookingProvider;
  late PromotionProvider _promotionProvider;
  final TextEditingController _promoCodeController = TextEditingController();
  final FocusNode _promoCodeFocusNode = FocusNode();
  double sumDiscount = 0;
  double discount = 0.0;
  double sumWithoutDiscount = 0;

  @override
  void initState() {
    super.initState();
    _promoCodeFocusNode.addListener(() {
      if (!_promoCodeFocusNode.hasFocus) {
        _applyDiscount();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartProvider = context.watch<CartProvider>();
    _bookingProvider = context.read<BookingProvider>();
    _promotionProvider = context.read<PromotionProvider>();
    _calculateTotal();
  }

  void _applyDiscount() async {
    var promoCodes = await _promotionProvider.get(filter: {'currentDate' : DateTime.now()});
    bool promoCodeFound = false;
    for (var promoCode in promoCodes.result) {
      if (_promoCodeController.text == promoCode.code) {
        setState(() {
          discount = promoCode.discount! / 100;
          promoCodeFound = true;
        });
        break;
      }
    }
    if (!promoCodeFound) {
      setState(() {
        discount = 0.0;
      });
    }

    if (!_promoCodeFocusNode.hasFocus) {
      setState(() {
        sumDiscount = sumWithoutDiscount * discount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: MasterScreen(
          cinemaId: widget.cinemaId,
          initialDate: widget.initialDate,
          cinemaName: widget.cinemaName,
          child: Container(
            color: Color.fromARGB(255, 220, 214, 246),
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: _buildProductCardList(),
                )),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2.4, right: 8),
                  child: TextField(
                    controller: _promoCodeController,
                    focusNode: _promoCodeFocusNode,
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: "Enter promo code",
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("Price without discount: ",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold)),
                                          Text("Discount: ",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              sumWithoutDiscount % 1 == 0
                                                  ? "${sumWithoutDiscount.toInt()} €"
                                                  : "${sumWithoutDiscount.toStringAsFixed(2)} €",
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                          Text("$sumDiscount €",
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                      thickness: 1,
                                      color: Color.fromRGBO(97, 72, 199, 1)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text("Total: ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          _calculateTotal() % 1 == 0
                                              ? "${_calculateTotal().toInt()} €"
                                              : "${_calculateTotal().toStringAsFixed(2)} €",
                                          style: const TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8, bottom: 5),
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
          ),
        ),
      ),
    );
  }

  Widget _buildProductCardList() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: const Color.fromARGB(200, 21, 36, 118), width: 1)),
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
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.movie.title ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      DateFormat('dd.MMMM.yyyy.')
                          .format(item.screening.screeningTime!),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(
                      "${DateFormat('HH:mm').format(item.screening.screeningTime!)} h",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  const Divider(
                      thickness: 2,
                      color: const Color.fromRGBO(97, 72, 199, 1)),
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
                  const Divider(
                      thickness: 0.5,
                      color: const Color.fromRGBO(97, 72, 199, 1)),
                  Row(
                    children: [
                      Spacer(),
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
          ],
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

  String _formatPrice(Screening screening, List<Seat> seats, CartItem item) {
    double amount = 0;
    for (var seat in seats) {
      if (seat.category == "love") {
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
    sumWithoutDiscount = sum;
    sumDiscount = sum * discount;
    return sum - sumDiscount;
  }
}
