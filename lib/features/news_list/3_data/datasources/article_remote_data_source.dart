import 'package:news_app/features/news_list/3_data/models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines({
    required int page,
    required int pageSize,
  });
}
