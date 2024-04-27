import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:cinebox_mobile/models/Movie/movie.dart';
import 'package:cinebox_mobile/models/Review/review.dart';
import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:cinebox_mobile/providers/logged_in_user_provider.dart';
import 'package:cinebox_mobile/providers/movie_provider.dart';
import 'package:cinebox_mobile/providers/review_provider.dart';
import 'package:cinebox_mobile/providers/users_provider.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

typedef OnDialogClose = void Function();

class ReviewAddScreen extends StatefulWidget {
  final int movieId;
  Review? review;
  final OnDialogClose? onClose;
  ReviewAddScreen(
      {super.key, required this.movieId, this.review, this.onClose});

  @override
  State<ReviewAddScreen> createState() => _ReviewAddScreenState();
}

class _ReviewAddScreenState extends State<ReviewAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ReviewProvider _reviewProvider;
  late MovieProvider _movieProvider;
  late LoggedInUserProvider _loggedInUserProvider;
  SearchResult<Movie>? movieResult;
  bool isLoading = true;
  int? _selectedRating;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'userId': widget.review?.userId.toString(),
      'movieId': widget.review?.movieId.toString(),
      'rating': widget.review?.rating.toString(),
      'comment': widget.review?.comment,
    };

    _reviewProvider = context.read<ReviewProvider>();
    _movieProvider = context.read<MovieProvider>();
    _loggedInUserProvider = context.read<LoggedInUserProvider>();
    initForm();
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

  Future initForm() async {
    try {
      var data = await _movieProvider.get();

      setState(() {
        movieResult = data;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 70)),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 21, 36, 118),
                    ),
                    onPressed: () async {
                      _formKey.currentState?.saveAndValidate();

                      try {
                        if (widget.review == null) {
                          var request = Map.from(_formKey.currentState!.value);
                          request['userId'] = Provider.of<LoggedInUserProvider>(
                                  context,
                                  listen: false)
                              .user!
                              .id;
                          request['movieId'] = widget.movieId;
                          request['rating'] = _selectedRating;
                          await _reviewProvider.insert(request);
                        }
                        if (widget.onClose != null) {
                          widget.onClose!();
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Success"),
                            content: const Text("Review saved successfully."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              )
                            ],
                          ),
                        );
                      } on Exception catch (e) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Error"),
                                  content: Text(e.toString()),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("OK"))
                                  ],
                                ));
                      }
                    },
                    child: const Text("Save"))
              ],
            ),
          ],
        ),
      ),
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Center(
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(2.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStar(1),
                    _buildStar(2),
                    _buildStar(3),
                    _buildStar(4),
                    _buildStar(5),
                  ],
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: "Comment"),
                  name: 'comment',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStar(int starNumber) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRating = starNumber;
        });
      },
      child: Icon(
        _selectedRating != null && starNumber <= _selectedRating!
            ? Icons.star
            : Icons.star_border,
      ),
    );
  }
}
