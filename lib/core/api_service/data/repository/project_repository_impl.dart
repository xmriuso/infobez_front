import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/data/models/detail_course_model.dart';
import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';
import '../../domain/entities/all_courses_entity.dart';
import '../../domain/repository/project_repository.dart';
import '../api/service/api_service.dart';

@LazySingleton(as: ProjectRepository)
class ProjectRepositoryImpl extends ProjectRepository {
  final ApiService apiService;

  ProjectRepositoryImpl({required this.apiService});

  @override
  Future<AllCoursesEntity?> getAllCourses({
    int? numberPage,
    int? quantity,
    String? search,
  }) async {
    return await apiService.getAllCourses(
      numberPage: numberPage,
      quantity: quantity,
      search: search,
    );
  }

  @override
  Future<DetailCourseEntity?> getDetailCourse({
    required int idCourse,
  }) async {
    return await apiService.getDetailCourse(
      idCourse: idCourse,
    );
  }

  @override
  Future<AllLessonsEntity?> getModulesByCourceId({
    required int idCourse,
  }) async {
    return await apiService.getModulesByCourceId(
      idCourse: idCourse,
    );
  }

  @override
  Future<Uint8List?> getImageFromString({
    required String image,
  }) async {
    final result = await apiService.getImageFromString(image: image);
    return result;
  }
}
