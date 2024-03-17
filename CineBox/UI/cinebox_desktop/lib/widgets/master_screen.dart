import 'package:cinebox_desktop/main.dart';
import 'package:cinebox_desktop/screens/movie_detail_screen.dart';
import 'package:cinebox_desktop/screens/movie_list_screen.dart';
import 'package:flutter/material.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreenWidget({this.child, this.title, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title ?? ""), backgroundColor: Colors.blue),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text("LOGIN"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => LoginPage()),
                  );
                },
              ),
              ListTile(
                title: Text("Movies"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const MovieListScreen()),
                  );
                },
              ),
              ListTile(
                title: Text("MovieDetails"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const MovieDetailScreen()),
                  );
                },
              )
            ],
          ),
        ),
        body: widget.child!);
  }
}
