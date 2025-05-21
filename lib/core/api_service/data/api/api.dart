import 'dart:typed_data';

import 'package:test_web_project/core/api_service/data/models/detail_course_model.dart';
import 'package:test_web_project/core/api_service/data/models/modules_by_id_model.dart';

import '../models/all_courses_model.dart';
import '../models/user_info_model.dart';
import 'dart:html' as html;

abstract class Api {
  Future<AllCoursesModel?> getAllCourses({
    int? numberPage = 10,
    int? quantity = 10,
    String? search,
  });

  Future<DetailCourseModel?> getDetailCourse({
    required int idCourse,
  });

  Future<AllLessonsModel?> getModulesByCourceId({
    required int idCourse,
  });

  Future<Uint8List?> getImageFromString({
    required String image,
  });

  Future<void> userCreate({
    required String name,
    required String email,
    required String password,
  });

  Future<void> login({
    required String username,
    required String password,
  });

  Future<UserInfoModel?> getMyUserInfo();

  Future<void> userUpdate({
    String? name,
    String? email,
    String? password,
    html.File? image,
  });

  Future<List<DetailCourseModel?>?> getByIdCreator({
    required int userId,
  });

  Future<void> createCourse({
    String? title,
    String? description,
    html.File? image,
  });

  Future<void> updateCourse({
    int? id,
    String? title,
    String? description,
    html.File? image,
  });

  Future<LessonModel?> getModuleById({
    required int moduleId,
  });

  Future<void> updateModule({
    int? id,
    String? title,
    String? description,
    String? videoUrl,
    html.File? image,
  });

  Future<void> createModule({
    int? id,
    String? title,
    String? description,
    String? videoUrl,
    html.File? image,
  });
}
