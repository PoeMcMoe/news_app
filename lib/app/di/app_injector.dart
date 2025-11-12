import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/app/client/app_client.dart';

class AppInjector {
  static GetIt getIt = GetIt.instance;

  static Future<void> setupInjector() async {
    _setupClient();
    _setUpSources();
    _setUpRepositories();
    _setupUseCases();
  }

  static _setupClient() {
    getIt.registerLazySingleton<Dio>(() {
      final dio = Dio(
        BaseOptions(
          connectTimeout: 30.seconds,
          receiveTimeout: 30.seconds,
          sendTimeout: 30.seconds,
        ),
      );

      dio.interceptors.addAll([
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      ]);

      return dio;
    });

    getIt.registerLazySingleton<AppClient>(
      () => AppClient(getIt<Dio>()),
    );
  }

  static _setUpSources() {}

  static _setUpRepositories() {}

  static _setupUseCases() {}
}
