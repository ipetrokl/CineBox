import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cinebox_mobile/models/Booking/booking.dart';
import 'package:cinebox_mobile/models/BookingSeat/bookingSeat.dart';
import 'package:cinebox_mobile/models/Cart/cart.dart';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Payment/payment.dart';
import 'package:cinebox_mobile/models/Promotion/promotion.dart';
import 'package:cinebox_mobile/models/Screening/screening.dart';
import 'package:cinebox_mobile/models/Seat/seat.dart';
import 'package:cinebox_mobile/models/Ticket/ticket.dart';
import 'package:cinebox_mobile/providers/booking_provider.dart';
import 'package:cinebox_mobile/providers/booking_seat_provider.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/cinema_provider.dart';
import 'package:cinebox_mobile/providers/hall_provider.dart';
import 'package:cinebox_mobile/providers/logged_in_user_provider.dart';
import 'package:cinebox_mobile/providers/payment_provider.dart';
import 'package:cinebox_mobile/providers/promotion_provider.dart';
import 'package:cinebox_mobile/providers/ticket_provider.dart';
import 'package:cinebox_mobile/screens/Movies/movie_list_screen.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  late PaymentProvider _paymentProvider;
  late LoggedInUserProvider _loggedInUserProvider;
  late TicketProvider _ticketProvider;
  late BookingSeatProvider _bookingSeatProvider;
  final TextEditingController _promoCodeController = TextEditingController();
  final FocusNode _promoCodeFocusNode = FocusNode();
  final Random _random = Random();
  int promoCodeId = 1;
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
    _paymentProvider = context.read<PaymentProvider>();
    _loggedInUserProvider = context.read<LoggedInUserProvider>();
    _ticketProvider = context.read<TicketProvider>();
    _bookingSeatProvider = context.read<BookingSeatProvider>();
    _calculateTotal();
  }

  void _applyDiscount() async {
    var promoCodes =
        await _promotionProvider.get(filter: {'currentDate': DateTime.now()});
    bool promoCodeFound = false;
    for (var promoCode in promoCodes.result) {
      if (_promoCodeController.text == promoCode.code) {
        setState(() {
          discount = promoCode.discount! / 100;
          promoCodeFound = true;
          promoCodeId = promoCode.id!;
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
      child: Scrollbar(
        trackVisibility: true,
        child: ListView.builder(
          itemCount: _cartProvider.cart.items.length,
          itemBuilder: (context, index) {
            return _buildProductCard(_cartProvider.cart.items[index], index);
          },
        ),
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
      child: const Text(
        "Buy",
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () {
        _makeBookingAndTickets();
      },
    );
  }

  Future<void> _makeBookingAndTickets() async {
    try {
      double totalAmount = _calculateTotal();
      String clientSecret =
          await _paymentProvider.createPaymentIntent(totalAmount);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Cinebox',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      for (var item in _cartProvider.cart.items) {
        Map<String, dynamic> bookingRequest = {
          "userId": _loggedInUserProvider.user!.id,
          "screeningId": item.screening.id,
          "price": totalAmount,
          "promotionId": promoCodeId,
        };

        Booking booking = await _bookingProvider.insert(bookingRequest);

        int paymentId = await _insertPaymentRecord(
            booking.id, totalAmount, 'payed, booked');

        for (var seat in item.selectedSeats) {
          String ticketCode = _generateTicketCode();
          String qrCode = await _generateQRCode(ticketCode);

          Map<String, dynamic> bookingTicketRequest = {
            "bookingId": booking.id,
            "seatId": seat.id,
          };

          BookingSeat bookingSeat =
              await _bookingSeatProvider.insert(bookingTicketRequest);

          await _updatePaymentRecord(
              paymentId, booking.id!, totalAmount, 'payed, booked, seats');

          Map<String, dynamic> ticketRequest = {
            "bookingSeatId": bookingSeat.bookingSeatId,
            "ticketCode": ticketCode,
            "qrCode": qrCode,
            "price": _ticketPrice(item.screening, seat),
            "userId": _loggedInUserProvider.user!.id,
          };

          await _ticketProvider.insert(ticketRequest);

          await _updatePaymentRecord(
              paymentId, booking.id!, totalAmount, 'successfully');
        }
      }

      _clearCartAndResetFields();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MovieListScreen(
            cinemaId: widget.cinemaId,
            initialDate: widget.initialDate,
            cinemaName: widget.cinemaName,
            message: "Payment Successful",
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment Failed: ${e.toString()}")));
    }
  }

  void _clearCartAndResetFields() {
    _cartProvider.cart.items.clear();
    _promoCodeController.clear();
    discount = 0.0;
    sumDiscount = 0.0;
    sumWithoutDiscount = 0.0;
    promoCodeId = 1;
    setState(() {});
  }

  String _generateTicketCode() {
    const chars = 'ABCDEF012345';
    return String.fromCharCodes(
      Iterable.generate(
          12, (_) => chars.codeUnitAt(_random.nextInt(chars.length))),
    );
  }

  Future<String> _generateQRCode(String ticketCode) async {
    if (ticketCode.isNotEmpty) {
      final qrImage = await QrPainter(
        data: ticketCode,
        version: QrVersions.auto,
        gapless: false,
      ).toImage(300);

      final byteData = await qrImage.toByteData(format: ImageByteFormat.png);
      final byteBuffer = byteData!.buffer;
      final base64Image = base64Encode(Uint8List.view(byteBuffer));

      return base64Image;
    }
    return '';
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
    sumWithoutDiscount = sum;
    sumDiscount = sum * discount;
    return sum - sumDiscount;
  }

  double _ticketPrice(Screening screening, Seat seat) {
    double price = 0;
    if (seat.category == "Double") {
      price = (screening.price! * 2) - (screening.price! * 2 * discount);
    } else {
      price = screening.price! - (screening.price! * discount);
    }

    return price;
  }

  Future<int> _insertPaymentRecord(
      int? bookingId, double amount, String status) async {
    Map<String, dynamic> paymentRequest = {
      "bookingId": bookingId,
      "amount": amount,
      "paymentStatus": status,
    };

    Payment payment = await _paymentProvider.insert(paymentRequest);

    return payment.id!;
  }

  Future<void> _updatePaymentRecord(
      int paymentId, int bookingId, double amount, String status) async {
    Map<String, dynamic> paymentUpdateRequest = {
      "bookingId": bookingId,
      "amount": amount,
      "paymentStatus": status,
    };

    await _paymentProvider.update(paymentId, paymentUpdateRequest);
  }
}
