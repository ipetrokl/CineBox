import 'package:cinebox_mobile/models/News/news.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class NewsProvider extends BaseProvider<News> {
  NewsProvider() : super("News");

 @override
  News fromJson(data) {
    return News.fromJson(data);
  }
}