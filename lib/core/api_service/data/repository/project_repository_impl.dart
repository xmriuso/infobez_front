import 'package:injectable/injectable.dart';
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
}
