import 'dart:typed_data';

import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';

import '../entities/all_courses_entity.dart';

abstract class ProjectRepository {
  Future<AllCoursesEntity?> getAllCourses({
    int? numberPage,
    int? quantity,
    String? search,
  });

  Future<DetailCourseEntity?> getDetailCourse({
    required int idCourse,
  });

  Future<AllLessonsEntity?> getModulesByCourseId({
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
}
