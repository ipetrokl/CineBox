import 'package:cinebox_desktop/models/Booking/booking.dart';
import 'package:cinebox_desktop/models/Ticket/ticket.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/booking_provider.dart';
import 'package:cinebox_desktop/providers/ticket_provider.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  SearchResult<Ticket>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late TicketProvider _ticketProvider;
  late BookingProvider _bookingProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _ticketProvider = context.read<TicketProvider>();
    _bookingProvider = context.read<BookingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Ticket List",
      child: Container(
        child: Column(
          children: [_buildSearch(), _buildDataListView()],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Ticket code"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _ticketProvider.get(filter: {
                  'fts': _ftsController.text,
                });

                setState(() {
                  result = data;
                });
              },
              child: const Text("Search")),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: const [
            DataColumn(
                label: Expanded(
              child: Text(
                'ID',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Booking Id',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Ticket Code',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'QR code',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Price',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
          ],
          rows: result?.result
                  .map((Ticket e) => DataRow(
                          cells: [
                            DataCell(Text(e.id?.toString() ?? "")),
                            DataCell(
                              FutureBuilder<Booking?>(
                                future: _bookingProvider.getById(e.bookingId!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data?.id.toString() ?? '');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                            DataCell(Text(e.ticketCode?.toString() ?? "")),
                            DataCell(Text(e.qrCode?.toString() ?? "")),
                            DataCell(Text(e.price?.toString() ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
