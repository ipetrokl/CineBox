import 'package:cinebox_desktop/main.dart';
import 'package:cinebox_desktop/screens/movie_detail_screen.dart';
import 'package:cinebox_desktop/screens/movie_list_screen.dart';
import 'package:cinebox_desktop/screens/screening_detail_screen.dart';
import 'package:cinebox_desktop/screens/screening_list_screen.dart';
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
          title: Text(widget.title ?? ""),
          backgroundColor: Colors.blue,
          actions: [
            if (Navigator.canPop(context))
              Container(
                child: SizedBox(
                  width: 100,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text("LOGIN"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
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
                        builder: (context) => MovieDetailScreen()),
                  );
                },
              ),
              ListTile(
                title: Text("ScreeningList"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ScreeningListScreen()),
                  );
                },
              ),
              ListTile(
                title: Text("ScreeningDetails"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ScreeningDetailScreen()),
                  );
                },
              )
            ],
          ),
        ),
        body: widget.child!);
  }
}
