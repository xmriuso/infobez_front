import 'package:test_web_project/core/api_service/data/models/detail_course_model.dart';
import 'package:test_web_project/core/api_service/data/models/modules_by_id_model.dart';

import '../models/all_courses_model.dart';

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
}
