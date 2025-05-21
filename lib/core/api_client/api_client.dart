import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';
import 'package:test_web_project/main.dart';

import '../../feature/app/routing/routing.dart';

@lazySingleton
class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://91.105.198.246:8000/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = html.window.localStorage['access_token'];
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401 &&
              !error.requestOptions.path.contains('auth/refresh')) {
            final refreshed = await refreshToken();
            if (refreshed) {
              final newToken = html.window.localStorage['access_token'];
              final opts = error.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newToken';
              final cloneReq = await dio.fetch(opts);
              return handler.resolve(cloneReq);
            } else {
              router.router.go(RoutePath.authPage);
              // final context = navigatorKey.currentContext;
              // if (context != null) {
              //   GoRouter.of(context).go(RoutePath.authPage);
              // }
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

  static void deleteToken() {
    html.window.localStorage.remove('access_token');
    html.document.cookie = 'refresh_token=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/';
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = _getRefreshTokenFromCookie();
      if (refreshToken == null) {
        print('❌ refresh_token отсутствует в cookie');
        return false;
      }

      final response = await dio.post(
        'auth/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
          },
        ),
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

  String? _getRefreshTokenFromCookie() {
    final cookies = html.document.cookie?.split('; ') ?? [];
    for (final cookie in cookies) {
      if (cookie.startsWith('refresh_token=')) {
        return cookie.substring('refresh_token='.length);
      }
    }
    return null;
  }
}
