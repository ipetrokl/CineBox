import 'package:cinebox_desktop/models/Booking/booking.dart';
import 'package:cinebox_desktop/models/Promotion/promotion.dart';
import 'package:cinebox_desktop/models/Screening/screening.dart';
import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/booking_provider.dart';
import 'package:cinebox_desktop/providers/promotion_provider.dart';
import 'package:cinebox_desktop/providers/screening_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late ScreeningProvider _screeningProvider;
  late PromotionProvider _promotionProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _bookingProvider = context.read<BookingProvider>();
    _usersProvider = context.read<UsersProvider>();
    _screeningProvider = context.read<ScreeningProvider>();
    _promotionProvider = context.read<PromotionProvider>();
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
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Screening Id')),
              DataColumn(label: Text('Promotion Id')),
              DataColumn(label: Text('Price')),
            ],
            source: DataTableSourceRows(result?.result ?? [], _usersProvider,
                _screeningProvider, _promotionProvider),
          ),
        ),
      ),
    ));
  }
}

class DataTableSourceRows extends DataTableSource {
  final List<Booking> bookings;
  final UsersProvider usersProvider;
  final ScreeningProvider screeningProvider;
  final PromotionProvider promotionProvider;

  DataTableSourceRows(this.bookings, this.usersProvider, this.screeningProvider,
      this.promotionProvider);

  @override
  @override
  DataRow getRow(int index) {
    final booking = bookings[index];
    return DataRow(
      cells: [
        DataCell(Text(booking.id?.toString() ?? "")),
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
        DataCell(
          FutureBuilder<Screening?>(
            future: screeningProvider.getById(booking.screeningId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.id.toString() ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(
          FutureBuilder<Promotion?>(
            future: promotionProvider.getById(booking.promotionId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.id.toString() ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
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
