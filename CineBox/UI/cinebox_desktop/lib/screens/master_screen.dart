import 'package:cinebox_desktop/main.dart';
import 'package:cinebox_desktop/screens/MovieScreens/movie_detail_screen.dart';
import 'package:cinebox_desktop/screens/MovieScreens/movie_list_screen.dart';
import 'package:cinebox_desktop/screens/ScreeningScreens/screening_detail_screen.dart';
import 'package:cinebox_desktop/screens/ScreeningScreens/screening_list_screen.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreen({this.child, this.title, super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
        backgroundColor: Colors.blue,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200], // Boja bočnog izbornika
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
                          builder: (context) => const MovieListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("MovieDetails"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("ScreeningList"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreeningListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("ScreeningDetails"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreeningDetailScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: widget.child!,
          ),
        ],
      ),
    );
  }
}
