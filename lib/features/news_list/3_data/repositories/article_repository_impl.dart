import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/2_domain/repositories/article_repository.dart';
import 'package:news_app/features/news_list/3_data/datasources/article_remote_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;

  ArticleRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Article>> getArticleList() async {
    final articleModels = await remoteDataSource.getTopHeadlines();
    return articleModels.map((model) => model.toEntity()).toList();
  }
}
