import 'package:dartx/dartx.dart';
import 'package:news_app/app/client/app_client.dart';
import 'package:news_app/app/constants.dart';
import 'package:news_app/features/news_list/3_data/datasources/article_remote_data_source.dart';
import 'package:news_app/features/news_list/3_data/models/article_model.dart';

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final AppClient client;

  ArticleRemoteDataSourceImpl(this.client);

  @override
  Future<List<ArticleModel>> getTopHeadlines({
    required int page,
    required int pageSize,
  }) async {
    print('Making call page:$page, pageSize:$pageSize');
    // await Future.delayed(1.seconds);
    //
    // return List.generate(
    //   pageSize,
    //   (index) => ArticleModel(
    //     title: 'Sample Article Title PAGE:$page, INDEX:$index',
    //     description: 'This is a description for sample article .',
    //     url: 'https://example.com/article',
    //     urlToImage: 'https://via.placeholder.com/150',
    //     publishedAt: DateTime.now().subtract(Duration(days: index)),
    //     content: 'This is the content of sample article.',
    //     author: 'Test',
    //   ),
    // );

    final response = await client.get(
      '/top-headlines',
      params: {
        'country': 'us',
        'apiKey': newsApiKey,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      },
    );
    final List<dynamic> data = response.data['articles'] ?? [];
    return data.map((json) => ArticleModel.fromJson(json)).toList();
  }
}
