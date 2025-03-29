import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';

import '../entities/all_courses_entity.dart';
import '../entities/detail_course_entity.dart';
import '../repository/project_repository.dart';

@lazySingleton
class ProjectUseCase {
  final ProjectRepository projectRepository;

  const ProjectUseCase({required this.projectRepository});

  Future<AllCoursesEntity?> getAllCourses({
    int? numberPage,
    int? quantity,
    String? search,
  }) async {
    try {
      final result = await projectRepository.getAllCourses(
        numberPage: numberPage,
        quantity: quantity,
        search: search,
      );
      return result;
    } on DioException catch (e) {}
    return null;
  }

      Future<DetailCourseEntity?> getDetailCourse({
    required int idCourse,
  }) async {
    try {
      final result = await projectRepository.getDetailCourse(
        idCourse: idCourse,
      );
      return result;
    } on DioException catch (e) {}
    return null;
  }

  Future<AllLessonsEntity?> getModulesByCourceId({
    required int idCourse,
  }) async {
    try {
      final result = await projectRepository.getModulesByCourceId(
        idCourse: idCourse,
      );
      return result;
    } on DioException catch (e) {}
    return null;
  }
 
}
