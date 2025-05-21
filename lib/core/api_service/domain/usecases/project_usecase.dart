import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';

import '../entities/all_courses_entity.dart';
import '../entities/detail_course_entity.dart';
import '../entities/user_info_entity.dart';
import '../repository/project_repository.dart';
import 'dart:html' as html;

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

  Future<void> userUpdate({
    String? name,
    String? email,
    String? password,
    html.File? image,
  }) async {
    return await projectRepository.userUpdate(
      name: name,
      email: email,
      password: password,
      image: image,
    );
  }

  Future<void> createCourse({
    String? title,
    String? description,
    html.File? image,
  }) async {
    return await projectRepository.createCourse(
      title: title,
      description: description,
      image: image,
    );
  }

  Future<List<DetailCourseEntity?>?> getByIdCreator({
    required int userId,
  }) async {
    return await projectRepository.getByIdCreator(
      userId: userId,
    );
  }

  Future<UserInfoEntity?> getMyUserInfo() async {
    return await projectRepository.getMyUserInfo();
  }

  Future<void> updateCourse({
    int? id,
    String? title,
    String? description,
    html.File? image,
  }) async {
    return await projectRepository.updateCourse(
      id: id,
      title: title,
      description: description,
      image: image,
    );
  }

  Future<LessonEntity?> getModuleById({
    required int moduleId,
  }) async {
    return await projectRepository.getModuleById(
      moduleId: moduleId,
    );
  }

  Future<void> updateModule({
    int? id,
    String? title,
    String? description,
    String? videoUrl,
    html.File? image,
  }) async {
    return await projectRepository.updateModule(
      id: id,
      title: title,
      description: description,
      videoUrl: videoUrl,
      image: image,
    );
  }

  Future<void> createModule({
    int? courseId,
    String? title,
    String? description,
    String? videoUrl,
    html.File? image,
  }) async {
    return await projectRepository.createModule(
      id: courseId,
      title: title,
      description: description,
      videoUrl: videoUrl,
      image: image,
    );
  }
}
