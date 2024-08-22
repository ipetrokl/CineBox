import 'dart:convert';
import 'dart:typed_data';
import 'package:cinebox_mobile/models/Ticket/ticket.dart';
import 'package:cinebox_mobile/providers/logged_in_user_provider.dart';
import 'package:cinebox_mobile/providers/seat_provider.dart';
import 'package:cinebox_mobile/providers/ticket_provider.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TicketScreen extends StatefulWidget {
  static const String routeName = "/ticket";
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;

  const TicketScreen(
      {super.key,
      required this.cinemaId,
      required this.initialDate,
      required this.cinemaName});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  late TicketProvider _ticketProvider;
  late LoggedInUserProvider _loggedInUserProvider;
  late SeatProvider _seatProvider;
  SearchResult<Ticket>? result;

  @override
  void initState() {
    super.initState();
    _ticketProvider = context.read<TicketProvider>();
    _loggedInUserProvider = context.read<LoggedInUserProvider>();
    _seatProvider = context.read<SeatProvider>();
    loadData();
  }

  Future loadData() async {
    try {
      var ticketdata = await _ticketProvider.get(filter: {
        'currentDate': DateTime.now(),
        'userId': _loggedInUserProvider.user!.id
      });
      for (var seat in ticketdata.result) {}
      setState(() {
        result = ticketdata;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double navigationBarHeight = MediaQuery.of(context).padding.bottom;
    double availableScreenHeight =
        screenHeight - statusBarHeight - navigationBarHeight;
    return MasterScreen(
      cinemaId: widget.cinemaId,
      initialDate: widget.initialDate,
      cinemaName: widget.cinemaName,
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 1,
              image: AssetImage("assets/images/movie3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: availableScreenHeight - 112,
                child: Scrollbar(
                  trackVisibility: true,
                  child: GridView(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 2.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                    ),
                    scrollDirection: Axis.vertical,
                    children: _buildTicketList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTicketList() {
    if (result == null || result!.result.isEmpty) {
      return [Center(child: Text('No ticket found.'))];
    }

    return result!.result.map((ticket) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color.fromRGBO(97, 72, 199, 1), width: 2)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white.withOpacity(0.6),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 9.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        ticket.bookingSeat!.booking!.screening!.movie!.title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ]),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Date: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                    DateFormat('dd.MMM.yyyy.').format(ticket
                                        .bookingSeat!
                                        .booking!
                                        .screening!
                                        .screeningTime!),
                                    style: const TextStyle(fontSize: 10)),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Hall: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  ticket.bookingSeat!.seat!.hall!.name!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Seat number: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  ticket.bookingSeat!.seat!.seatNumber!
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Price: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                    ticket.price! % 1 == 0
                                        ? "${ticket.price!.toInt()} €"
                                        : "${ticket.price!.toStringAsFixed(2)} €",
                                    style: const TextStyle(fontSize: 10)),
                              ],
                            )
                          ]),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Time: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                  "${DateFormat('HH:mm').format(ticket.bookingSeat!.booking!.screening!.screeningTime!)} h",
                                  style: const TextStyle(fontSize: 10)),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Cinema: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                ticket.bookingSeat!.seat!.hall!.cinema!.name!,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Seat type: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                ticket.bookingSeat!.seat!.category!.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Screening: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                ticket
                                    .bookingSeat!.booking!.screening!.category!,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showQRCodeDialog(ticket),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.memory(
                            _formatQRCode(ticket),
                            scale: 5,
                          ),
                          SizedBox(height: 3),
                          Text(
                            ticket.ticketCode!,
                            style: const TextStyle(
                              fontSize: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Uint8List _formatQRCode(Ticket ticket) {
    Uint8List decodedBytes = base64Decode(ticket.qrCode!);
    return decodedBytes;
  }

  void _showQRCodeDialog(Ticket ticket) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white70,
          insetPadding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Center(
                child: Image.memory(
                  _formatQRCode(ticket),
                  scale: 1,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
