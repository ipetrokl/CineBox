import 'package:cinebox_desktop/models/movie.dart';
import 'package:cinebox_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MovieDetailScreen extends StatefulWidget {
  Movie? movie;
  MovieDetailScreen({super.key, this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'title': widget.movie?.title,
      'description': widget.movie?.description
    };
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // if (widget.movie != null) {
    //   setState(() {
    //     _formKey.currentState?.patchValue({'title': widget.movie?.title});
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: widget.movie?.title ?? "Movie Details", child: _buildForm());
  }

  FormBuilder _buildForm() {
    return FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    decoration: InputDecoration(labelText: "Title"),
                    name: 'title',
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    decoration: InputDecoration(labelText: "Description"),
                    name: 'description',
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
