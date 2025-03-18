import '../entities/all_courses_entity.dart';

abstract class ProjectRepository {
  Future<AllCoursesEntity?> getAllCourses({
    int? numberPage,
    int? quantity,
    String? search,
  });
}
