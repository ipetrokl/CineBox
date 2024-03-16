import 'package:cinebox_desktop/screens/movie_detail_screen.dart';
import 'package:cinebox_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Movie List",
      child: Container(
        child: Column(
          children: [
            Text("Test"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  print("Back proceed");
                  //Navigator.of(context).pop();
                  Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const MovieDetailScreen()),
                      );
                },
                child: Text("Back"))
          ],
        ),
      ),
    );
  }
}
