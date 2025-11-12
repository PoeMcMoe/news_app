import 'package:dio/dio.dart';
import 'package:news_app/app/client/app_client.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/features/news_list/3_data/datasources/news_remote_data_source.dart';
import 'package:news_app/features/news_list/3_data/models/news_model.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final AppClient client;

  NewsRemoteDataSourceImpl(this.client);

  @override
  Future<List<NewsModel>> getNewsList() async {
    try {
      throw UnimplementedError();
      // TODO: Replace with actual API endpoint
      final response = await client.get('/news');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['articles'] ?? [];
        return data.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to fetch news: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('Network error: ${e.message}');
      }
      throw ServerException('Server error: ${e.message}');
    }
  }
}
