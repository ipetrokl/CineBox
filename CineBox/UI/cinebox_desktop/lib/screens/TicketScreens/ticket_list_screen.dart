import 'package:cinebox_desktop/models/Ticket/ticket.dart';
import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/ticket_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  SearchResult<Ticket>? result;
  TextEditingController _ftsController = TextEditingController();
  late TicketProvider _ticketProvider;
  late UsersProvider _usersProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _ticketProvider = context.read<TicketProvider>();
    _usersProvider = context.read<UsersProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _ticketProvider.get();

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
      child: SizedBox(
        width: double.infinity,
        child: Theme(
          data: Theme.of(context).copyWith(
              cardTheme: Theme.of(context).cardTheme.copyWith(
                    color: const Color.fromRGBO(220, 220, 206, 1),
                  )),
          child: PaginatedDataTable(
            header: const Center(
              child: Text('Tickets'),
            ),
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Ticket Code')),
              DataColumn(label: Text('QR Code')),
              DataColumn(label: Text('Price')),
            ],
            source: DataTableSourceRows(
              result?.result ?? [],
              _usersProvider,
            ),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }
}

class DataTableSourceRows extends DataTableSource {
  final List<Ticket> tickets;
  final UsersProvider usersProvider;

  DataTableSourceRows(this.tickets, this.usersProvider);

  @override
  DataRow getRow(int index) {
    final ticket = tickets[index];
    return DataRow(
      cells: [
        DataCell(
          FutureBuilder<Users?>(
            future: usersProvider.getById(ticket.userId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.username.toString() ?? '');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        DataCell(Text(ticket.ticketCode?.toString() ?? "")),
        DataCell(Text(ticket.qrCode?.toString() ?? "")),
        DataCell(Text(ticket.price?.toString() ?? "")),
      ],
    );
  }

  @override
  int get rowCount => tickets.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
