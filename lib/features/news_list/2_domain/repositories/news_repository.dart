import 'package:news_app/features/news_list/2_domain/entities/news.dart';

abstract class NewsRepository {
  Future<List<News>> getNewsList();
}
