import 'package:news_app/features/news_list/3_data/models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNewsList();
}
