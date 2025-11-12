import 'package:dio/dio.dart';

class AppClient {
  final Dio _dio;
  CancelToken _cancelToken = CancelToken();

  AppClient(this._dio);

  void cancelAllRequests(Object? reason) {
    _cancelToken.cancel(reason);
    _cancelToken = CancelToken();
  }

  Future<Response<dynamic>> fetch(RequestOptions options) => _dio.fetch(options);

  Future<Response<dynamic>> get(
    String url, {
    Map<String, String?>? params,
    Map<String, String>? headers,
  }) async => await _dio.get(
    url,
    queryParameters: params,
    options: Options(headers: headers),
    cancelToken: _cancelToken,
  );
}
