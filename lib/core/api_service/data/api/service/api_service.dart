import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/data/api/api.dart';
import 'package:test_web_project/core/api_service/data/models/detail_course_model.dart';
import 'package:test_web_project/core/api_service/data/models/modules_by_id_model.dart';

import '../../models/all_courses_model.dart';
import 'dart:typed_data';
import 'dart:html' as html; // Используем dart:html для работы с DOM

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
        'courses/getPageByDescription/',
        queryParameters: {
          'number_page': 1,
          'quantity_on_page': 10,
          if (search != null) 'description': search,
          //if (numberPage != null) 'number_page': numberPage,
          //if (quantity != null)'quantity_on_page': quantity,
        },
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

  @override
  Future<DetailCourseModel?> getDetailCourse({
    required int idCourse,
  }) async {
    try {
      final response = await _dio.get(
        'courses/getById/$idCourse',
        // queryParameters: params,
      );
      if (response.data != null) {
        return DetailCourseModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('❌ Ошибка GET: $e');
      return null;
    }
  }

  @override
  Future<AllLessonsModel?> getModulesByCourceId({
    required int idCourse,
  }) async {
    try {
      final response = await _dio.get(
        'modules/getPageByCourseAndDescription/$idCourse',
        // queryParameters: params,
      );
      if (response.data != null) {
        return AllLessonsModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('❌ Ошибка GET: $e');
      return null;
    }
  }

  @override
  Future<Uint8List?> getImageFromString({
    required String image,
  }) async {
    try {
      final response = await _dio.get(
        'images/getByName/$image',
        options: Options(
            responseType: ResponseType.bytes), // Указываем, что ожидаем байты
      );

      if (response.statusCode == 200) {
        // Получаем байты изображения из поля 'data'
        Uint8List bytes = response
            .data; // response.data теперь будет типа Uint8List, если указан ResponseType.bytes
        return bytes;
      } else {
        print('❌ Ошибка: Статус не 200. Код: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Ошибка GET: $e');
      return null;
    }
  }
}
