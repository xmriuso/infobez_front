import 'dart:typed_data';

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
    final result = await projectRepository.getAllCourses(
      numberPage: numberPage,
      quantity: quantity,
      search: search,
    );
    return result;

    return null;
  }

  Future<DetailCourseEntity?> getDetailCourse({
    required int idCourse,
  }) async {
    final result = await projectRepository.getDetailCourse(
      idCourse: idCourse,
    );
    return result;

    return null;
  }

  Future<AllLessonsEntity?> getModulesByCourceId({
    required int idCourse,
  }) async {
    final result = await projectRepository.getModulesByCourseId(
      idCourse: idCourse,
    );
    return result;

    return null;
  }

  Future<Uint8List?> getImageFromString({
    required String image,
  }) async {
    final result = await projectRepository.getImageFromString(
      image: image,
    );
    return result;
    return null;
  }

  Future<void> userCreate({
    required String name,
    required String email,
    required String password,
  }) async {
    await projectRepository.userCreate(
      name: name,
      email: email,
      password: password,
    );
    return;
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    await projectRepository.login(
      username: username,
      password: password,
    );
    return;
  }
}
