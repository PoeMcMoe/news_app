import 'package:news_app/features/news_list/3_data/models/news_model.dart';

abstract class NewsRemoteDataSource {
  /// Fetches list of news from the remote API
  ///
  /// Throws [ServerException] if the API call fails
  Future<List<NewsModel>> getNewsList();
}
