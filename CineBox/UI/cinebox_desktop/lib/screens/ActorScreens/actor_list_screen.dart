import 'package:cinebox_desktop/models/Actor/actor.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/actor_provider.dart';
import 'package:cinebox_desktop/screens/ActorScreens/actor_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActorListScreen extends StatefulWidget {
  const ActorListScreen({super.key});

  @override
  State<ActorListScreen> createState() => _ActorListScreenState();
}

class _ActorListScreenState extends State<ActorListScreen> {
  SearchResult<Actor>? result;
  TextEditingController _ftsController = TextEditingController();
  late ActorProvider _actorProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _actorProvider = context.read<ActorProvider>();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var data = await _actorProvider.get();

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
              decoration: InputDecoration(labelText: "Name"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _actorProvider.get(filter: {
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
                showDialog(
                  context: context,
                  builder: (_) => ActorDetailScreen(
                    onClose: () {
                      _fetchData();
                    },
                  ),
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
      child: SizedBox(
        width: double.infinity,
        child: Theme(
          data: Theme.of(context).copyWith(
              cardTheme: Theme.of(context).cardTheme.copyWith(
                    color: const Color.fromRGBO(220, 220, 206, 1),
                  )),
          child: PaginatedDataTable(
            header: const Center(
              child: Text('Actors'),
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Actions')),
            ],
            source: DataTableSourceRows(
                result?.result ?? [], _deleteRecord, _navigateToDetail),
            showCheckboxColumn: false,
          ),
        ),
      ),
    ));
  }

  void _navigateToDetail(Actor actor) {
    showDialog(
      context: context,
      builder: (_) => ActorDetailScreen(
        actor: actor,
        onClose: () {
          _fetchData();
        },
      ),
    );
  }

  void _deleteRecord(int id) async {
    try {
      var success = await _actorProvider.delete(id);

      if (success) {
        var data = await _actorProvider.get();
        setState(() {
          result = data;
        });
      }
    } catch (e) {
      print("Error deleting data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete data. Please try again."),
        ),
      );
    }
  }
}

class DataTableSourceRows extends DataTableSource {
  final List<Actor> actors;
  final Function(int) onDelete;
  final Function(Actor) onRowSelected;

  DataTableSourceRows(this.actors, this.onDelete, this.onRowSelected);

  @override
  DataRow getRow(int index) {
    final actor = actors[index];
    return DataRow(
      cells: [
        DataCell(Text(actor.id?.toString() ?? '')),
        DataCell(Text(actor.name ?? '')),
        DataCell(IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => onDelete(actor.id!),
        )),
      ],
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelected(actor);
        }
      },
    );
  }

  @override
  int get rowCount => actors.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
