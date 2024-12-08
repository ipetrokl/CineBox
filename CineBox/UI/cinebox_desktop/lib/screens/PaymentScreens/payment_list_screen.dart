import 'package:cinebox_desktop/models/Booking/booking.dart';
import 'package:cinebox_desktop/models/Payment/payment.dart';
import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/booking_provider.dart';
import 'package:cinebox_desktop/providers/payment_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  SearchResult<Payment>? result;
  TextEditingController _ftsController = TextEditingController();
  late PaymentProvider _paymentProvider;
  late BookingProvider _bookingProvider;
  late UsersProvider _userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _paymentProvider = context.read<PaymentProvider>();
    _bookingProvider = context.read<BookingProvider>();
    _userProvider = context.read<UsersProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _paymentProvider.get();

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(214, 212, 203, 1),
      child: Column(
        children: [_buildSearch(), _buildDataListView()],
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
          )
        ],
      ),
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Theme(
          data: Theme.of(context).copyWith(
              cardTheme: Theme.of(context).cardTheme.copyWith(
                    color: const Color.fromRGBO(220, 220, 206, 1),
                  )),
          child: PaginatedDataTable(
            header: const Center(
              child: Text('Payments'),
            ),
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Status')),
            ],
            source: DataTableSourceRows(
                result?.result ?? [], _bookingProvider, _userProvider),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }
}

class DataTableSourceRows extends DataTableSource {
  final List<Payment> payments;
  final BookingProvider bookingProvider;
  final UsersProvider usersProvider;

  DataTableSourceRows(this.payments, this.bookingProvider, this.usersProvider);

  @override
  DataRow getRow(int index) {
    final payment = payments[index];
    return DataRow(
      cells: [
        DataCell(
          FutureBuilder<Users?>(
            future: usersProvider.getById(payment.booking!.userId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.username.toString() ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(Text(payment.amount?.toString() ?? "")),
        DataCell(Text(payment.paymentStatus?.toString() ?? "")),
      ],
    );
  }

  @override
  int get rowCount => payments.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
