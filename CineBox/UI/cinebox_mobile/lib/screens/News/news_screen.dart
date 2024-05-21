import 'package:cinebox_mobile/models/News/news.dart';
import 'package:cinebox_mobile/models/Promotion/promotion.dart';
import 'package:cinebox_mobile/providers/news_provider.dart';
import 'package:cinebox_mobile/providers/promotion_provider.dart';
import 'package:cinebox_mobile/screens/log_in_screen.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  static const String routeName = "/news";
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;

  const NewsScreen(
      {super.key,
      required this.cinemaId,
      required this.initialDate,
      required this.cinemaName});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late NewsProvider _newsProvider;
  SearchResult<News>? result;

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    try {
      var data = await _newsProvider.get(filter: {'cinemaId': widget.cinemaId});

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "News",
      cinemaId: widget.cinemaId,
      initialDate: widget.initialDate,
      cinemaName: widget.cinemaName,
      child: Column(
        children: [Expanded(child: _buildNews())],
      ),
    );
  }

  Widget _buildNews() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 1,
            image: AssetImage("assets/images/movie3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "News:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  const Divider(
                      thickness: 5, color: Color.fromARGB(200, 21, 36, 118)),
                  SizedBox(height: 10),
                  _buildNewsCardList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCardList() {
    if (result == null || result!.result.isEmpty) {
      return Center(child: Text('No news found.'));
    }

    return Wrap(
      spacing: 10,
      runSpacing: 15,
      children: result!.result.map((news) {
        return IntrinsicHeight(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Color.fromARGB(200, 21, 36, 118), width: 2),
              color: Colors.white.withOpacity(0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      news.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Divider(
                      thickness: 2, color: Color.fromARGB(200, 21, 36, 118)),
                  Expanded(
                    child: Text(
                      news.description!,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateFormat('dd.MM.yyyy.').format(news.createdDate!),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
