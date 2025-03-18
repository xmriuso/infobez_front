import '../models/all_courses_model.dart';

abstract class Api {
  Future<AllCoursesModel?> getAllCourses({
    int? numberPage = 10,
    int? quantity = 10,
    String? search,
  });
}
