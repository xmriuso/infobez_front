import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/data/api/api.dart';

import '../../models/all_courses_model.dart';

@lazySingleton
class ApiService implements Api {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/',
      connectTimeout: const Duration(milliseconds: 15000),
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  @override
  Future<AllCoursesModel?> getAllCourses({
    int? numberPage,
    int? quantity,
    String? search,
  }) async {
    try {
      final response = await _dio.get(
        'courses/getPageByDescription/${numberPage ?? 10}/${quantity ?? 10}',
        // queryParameters: params,
      );
      if (response.data != null) {
        return AllCoursesModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('❌ Ошибка GET: $e');
      return null;
    }
  }
}
