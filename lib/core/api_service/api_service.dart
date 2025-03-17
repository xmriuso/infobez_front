import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'models/all_courses_model.dart';

@lazySingleton
class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.82:8000/',
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

  Future<List<AllCoursesModel>?> getAllCourses() async {
    try {
      final response = await _dio.get(
        'courses/getAll',
        // queryParameters: params,
      );
      if (response.data != null) {
        final list = List<AllCoursesModel>.from(
            response.data.map((x) => AllCoursesModel.fromJson(x)));
        return list;
      }
      return null;
    } catch (e) {
      print('❌ Ошибка GET: $e');
      return null;
    }
  }

  Future<Response?> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      print('❌ Ошибка POST: $e');
      return null;
    }
  }
}
