import 'package:cinebox_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Movie Details",
      child: Text("Details")
    );
  }
}
