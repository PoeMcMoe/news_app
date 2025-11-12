import 'package:news_app/app/client/app_client.dart';
import 'package:news_app/features/news_list/3_data/datasources/news_remote_data_source.dart';
import 'package:news_app/features/news_list/3_data/models/news_model.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final AppClient client;

  NewsRemoteDataSourceImpl(this.client);

  @override
  Future<List<NewsModel>> getNewsList() async {
    throw UnimplementedError();
    final response = await client.get('/news');
    final List<dynamic> data = response.data['articles'] ?? [];
    return data.map((json) => NewsModel.fromJson(json)).toList();
  }
}
