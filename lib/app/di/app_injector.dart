import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/app/client/app_client.dart';
import 'package:news_app/app/constants.dart';
import 'package:news_app/features/news_list/1_presentation/cubits/news_list_cubit.dart';
import 'package:news_app/features/news_list/2_domain/repositories/article_repository.dart';
import 'package:news_app/features/news_list/2_domain/usecases/get_article_list_use_case.dart';
import 'package:news_app/features/news_list/3_data/datasources/article_remote_data_source.dart';
import 'package:news_app/features/news_list/3_data/datasources/article_remote_data_source_impl.dart';
import 'package:news_app/features/news_list/3_data/repositories/article_repository_impl.dart';

class AppInjector {
  static GetIt getIt = GetIt.instance;

  static Future<void> setupInjector() async {
    _setupClient();
    _setUpSources();
    _setUpRepositories();
    _setupUseCases();
    _setupCubits();
  }

  static _setupClient() {
    getIt.registerLazySingleton<Dio>(() {
      final dio = Dio(
        BaseOptions(
          baseUrl: newsApiBaseUrl,
          connectTimeout: 30.seconds,
          receiveTimeout: 30.seconds,
          sendTimeout: 30.seconds,
        ),
      );

      return dio;
    });

    getIt.registerLazySingleton<AppClient>(
      () => AppClient(getIt<Dio>()),
    );
  }

  static _setUpSources() {
    getIt.registerLazySingleton<ArticleRemoteDataSource>(
      () => ArticleRemoteDataSourceImpl(getIt<AppClient>()),
    );
  }

  static _setUpRepositories() {
    getIt.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(getIt<ArticleRemoteDataSource>()),
    );
  }

  static _setupUseCases() {
    getIt.registerLazySingleton<GetArticleListUseCase>(
      () => GetArticleListUseCase(getIt<ArticleRepository>()),
    );
  }

  static _setupCubits() {
    getIt.registerFactory<NewsListCubit>(
      () => NewsListCubit(getIt<GetArticleListUseCase>()),
    );
  }
}
