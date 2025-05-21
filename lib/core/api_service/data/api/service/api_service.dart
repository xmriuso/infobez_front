import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/data/api/api.dart';
import 'package:test_web_project/core/api_service/data/models/detail_course_model.dart';
import 'package:test_web_project/core/api_service/data/models/modules_by_id_model.dart';

import '../../../../api_client/api_client.dart';
import '../../models/all_courses_model.dart';
import 'dart:typed_data';
import 'dart:html' as html;

import '../../models/user_info_model.dart';

@lazySingleton
class ApiService implements Api {
  final ApiClient _apiClient;

  ApiService(this._apiClient);

  @override
  Future<AllCoursesModel?> getAllCourses({
    int? numberPage,
    int? quantity,
    String? search,
  }) async {
    final response = await _apiClient.dio.get(
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
  }

  @override
  Future<DetailCourseModel?> getDetailCourse({
    required int idCourse,
  }) async {
    final response = await _apiClient.dio.get(
      'courses/getById/$idCourse',
      // queryParameters: params,
    );
    if (response.data != null) {
      return DetailCourseModel.fromJson(response.data);
    }
    return null;
  }

  @override
  Future<UserInfoModel?> getMyUserInfo() async {
    final response = await _apiClient.dio.get(
      'users/me',
    );
    if (response.data != null) {
      return UserInfoModel.fromJson(response.data);
    }
    return null;
  }

  @override
  Future<AllLessonsModel?> getModulesByCourceId({
    required int idCourse,
  }) async {
    final response = await _apiClient.dio.get(
      'modules/getPageByCourseAndDescription/$idCourse',
      // queryParameters: params,
    );
    if (response.data != null) {
      return AllLessonsModel.fromJson(response.data);
    }
    return null;
  }

  @override
  Future<void> userCreate({
    required String name,
    required String email,
    required String password,
  }) async {
    await _apiClient.dio.post(
      'users/create',
      queryParameters: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    return;
  }

  @override
  Future<void> userUpdate({
    String? name,
    String? email,
    String? password,
    html.File? image, // <-- файл изображения
  }) async {
    FormData? formData;

    if (image != null) {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(image);
      await reader.onLoad.first;
      final bytes = reader.result as Uint8List;

      formData = FormData.fromMap({
        'image': MultipartFile.fromBytes(
          bytes,
          filename: image.name,
          contentType: DioMediaType.parse('image/jpeg'),
        ),
      });
    }

    await _apiClient.dio.patch(
      'users/update',
      data: formData,
      queryParameters: {
        if (name != null && name != '') 'name': name,
        if (email != null && email != '') 'email': email,
        if (password != null && password != '') 'password': password,
      },
      // options: Options(
      //   headers: {
      //     'Content-Type': 'multipart/form-data',
      //   },
      // ),
    );
  }

  @override
  Future<void> login({
    required String username,
    required String password,
  }) async {
    final result = await _apiClient.dio.post(
      'auth/login',
      data: {
        'username': username,
        'password': password,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'accept': 'application/json',
        },
      ),
    );
    final newToken = result.data['access_token'];
    final refreshToken = result.data['refresh_token'];
    if (newToken != null) {
      html.window.localStorage['access_token'] = newToken;
    }
    if (refreshToken != null) {
      final expiryDate = DateTime.now().add(Duration(days: 30));
      html.document.cookie =
          'refresh_token=$refreshToken; path=/; expires=${expiryDate.toUtc().toIso8601String()}; SameSite=Lax';
    }
  }

  @override
  Future<Uint8List?> getImageFromString({
    required String image,
  }) async {
    final response = await _apiClient.dio.get(
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
  }
}
