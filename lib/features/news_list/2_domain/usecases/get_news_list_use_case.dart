import 'package:news_app/features/news_list/2_domain/entities/news.dart';
import 'package:news_app/features/news_list/2_domain/repositories/news_repository.dart';

class GetNewsListUseCase {
  final NewsRepository repository;

  GetNewsListUseCase(this.repository);

  Future<List<News>> call() async {
    return await repository.getNewsList();
  }
}
