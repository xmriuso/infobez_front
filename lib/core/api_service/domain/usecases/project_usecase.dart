import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../entities/all_courses_entity.dart';
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
}
