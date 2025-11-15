import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/2_domain/repositories/article_repository.dart';
import 'package:news_app/features/news_list/3_data/datasources/article_remote_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource _articleRemoteDataSource;

  ArticleRepositoryImpl(this._articleRemoteDataSource);

  @override
  Future<List<Article>> getArticleList({
    required int page,
    required int pageSize,
  }) async {
    final articleModels = await _articleRemoteDataSource.getTopHeadlines(
      page: page,
      pageSize: pageSize,
    );
    return articleModels.map((model) => model.toEntity()).toList();
  }
}
