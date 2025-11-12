import 'package:news_app/features/news_list/2_domain/entities/news.dart';
import 'package:news_app/features/news_list/2_domain/repositories/news_repository.dart';
import 'package:news_app/features/news_list/3_data/datasources/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<News>> getNewsList() async {
    final newsModels = await remoteDataSource.getNewsList();
    return newsModels.map((model) => model.toEntity()).toList();
  }
}
