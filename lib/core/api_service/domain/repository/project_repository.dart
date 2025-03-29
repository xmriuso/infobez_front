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

  Future<AllLessonsEntity?> getModulesByCourceId({
    required int idCourse,
  });
}
