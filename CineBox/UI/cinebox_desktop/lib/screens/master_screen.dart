import 'package:cinebox_desktop/screens/CinemaScreens/cinema_list_screen.dart';
import 'package:cinebox_desktop/screens/MovieScreens/movie_list_screen.dart';
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
                    title: Text("Screening"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreeningListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Cinema"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CinemaListScreen(),
                        ),
                      );
                    },
                  ),
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
