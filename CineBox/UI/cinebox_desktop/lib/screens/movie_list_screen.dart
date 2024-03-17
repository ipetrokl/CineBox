import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/screens/movie_detail_screen.dart';
import 'package:cinebox_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late MovieProvider _movieProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _movieProvider = context.read<MovieProvider>();
  }

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
                onPressed: () async {
                  print("Back proceed");
                  //Navigator.of(context).pop();
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const MovieDetailScreen()),
                  // );

                  var data = await _movieProvider.get();
                  print("data: ${data.result[0].title}");
                },
                child: Text("Back"))
          ],
        ),
      ),
    );
  }
}
