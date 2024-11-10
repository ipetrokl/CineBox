import 'package:cinebox_desktop/models/Booking/booking.dart';
import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/booking_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  SearchResult<Booking>? result;
  TextEditingController _ftsController = TextEditingController();
  late BookingProvider _bookingProvider;
  late UsersProvider _usersProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _bookingProvider = context.read<BookingProvider>();
    _usersProvider = context.read<UsersProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _bookingProvider.get();

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
              decoration: InputDecoration(labelText: "User name"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _bookingProvider.get(filter: {
                  'fts': _ftsController.text,
                });

                setState(() {
                  result = data;
                });
              },
              child: const Text("Search")),
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
              child: Text('Bookings'),
            ),
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Movie')),
              DataColumn(label: Text('Screening time')),
              DataColumn(label: Text('Promotion')),
              DataColumn(label: Text('Price')),
            ],
            source: DataTableSourceRows(result?.result ?? [], _usersProvider),
          ),
        ),
      ),
    ));
  }
}

class DataTableSourceRows extends DataTableSource {
  final List<Booking> bookings;
  final UsersProvider usersProvider;

  DataTableSourceRows(this.bookings, this.usersProvider);

  @override
  @override
  DataRow getRow(int index) {
    final booking = bookings[index];
    final DateTime? screeningTime = booking.screening?.screeningTime;

    final String formattedDate = screeningTime != null
        ? DateFormat('yyyy-MM-dd HH:mm').format(screeningTime)
        : "";

    return DataRow(
      cells: [
        DataCell(
          FutureBuilder<Users?>(
            future: usersProvider.getById(booking.userId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.name ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(Text(booking.screening?.movie?.title ?? "")),
        DataCell(Text(formattedDate)),
        DataCell(Text(booking.promotion?.code ?? "")),
        DataCell(Text(booking.price?.toString() ?? "")),
      ],
    );
  }

  @override
  int get rowCount => bookings.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
