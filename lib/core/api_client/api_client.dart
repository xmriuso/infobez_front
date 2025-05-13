import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8000/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = html.window.localStorage['access_token'];
          print('1342342341234 $token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401 &&
              !error.requestOptions.path.contains('/auth/refresh')) {
            final refreshed = await _refreshToken();
            if (refreshed) {
              final newToken = html.window.localStorage['access_token'];
              final opts = error.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newToken';
              final cloneReq = await dio.fetch(opts);
              return handler.resolve(cloneReq);
            }
          }
          return handler.next(error);
        },
      ),
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    ]);
  }

  Future<bool> _refreshToken() async {
    try {
      final response = await dio.get(
        'auth/refresh',
        options: Options(extra: {
          'withCredentials': true,
        }),
      );
      final newToken = response.data['access_token'];
      if (newToken != null) {
        html.window.localStorage['access_token'] = newToken;
        return true;
      }
      return false;
    } catch (e) {
      print('❌ Ошибка при обновлении токена: $e');
      return false;
    }
  }
}
