import 'package:cinebox_desktop/models/movie.dart';
import 'package:cinebox_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  Movie? movie;
  MovieDetailScreen({super.key, this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(title: widget.movie?.title ?? "Movie Details", child: Text("Details"));
  }
}
