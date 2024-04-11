import 'package:cinebox_desktop/models/Booking/booking.dart';
import 'package:cinebox_desktop/models/Payment/payment.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/booking_provider.dart';
import 'package:cinebox_desktop/providers/payment_provider.dart';
import 'package:cinebox_desktop/screens/HallScreens/hall_detail_screen.dart';
import 'package:cinebox_desktop/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  SearchResult<Payment>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late PaymentProvider _paymentProvider;
  late BookingProvider _bookingProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _paymentProvider = context.read<PaymentProvider>();
    _bookingProvider = context.read<BookingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Payment List",
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
              decoration: InputDecoration(labelText: "Booking Id or Status"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _paymentProvider.get(filter: {
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
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => HallDetailScreen(
                            hall: null,
                          )),
                );
              },
              child: const Text("Add"))
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
                'Booking',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Amount',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
            DataColumn(
                label: Expanded(
              child: Text(
                'Status',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
          ],
          rows: result?.result
                  .map((Payment e) => DataRow(
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
                            DataCell(Text(e.amount?.toString() ?? "")),
                            DataCell(Text(e.paymentStatus?.toString() ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
