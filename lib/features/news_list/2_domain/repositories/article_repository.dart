import 'package:news_app/features/news_list/2_domain/entities/article.dart';

abstract class ArticleRepository {
  Future<List<Article>> getArticleList({
    required int page,
    required int pageSize,
  });
}
