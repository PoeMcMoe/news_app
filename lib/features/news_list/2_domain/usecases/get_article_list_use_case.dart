import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/2_domain/repositories/article_repository.dart';

class GetArticleListUseCase {
  final ArticleRepository repository;

  GetArticleListUseCase(this.repository);

  Future<List<Article>> call() async {
    return await repository.getArticleList();
  }
}
