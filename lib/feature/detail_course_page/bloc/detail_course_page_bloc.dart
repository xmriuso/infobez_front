import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';

import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';

part 'detail_course_page_event.dart';

part 'detail_course_page_state.dart';

@lazySingleton
class DetailCoursePageBloc
    extends Bloc<DetailCoursePageEvent, DetailCoursePageState> {
  final ProjectUseCase projectUseCase;

  DetailCoursePageBloc(this.projectUseCase) : super(AllCoursesPageInitial()) {
    on<LoadDetailCourseEvent>(_onLoadDetailCourseEvent);
    on<LikeEvent>(_onLikeEvent);
  }

  Future<void> _onLoadDetailCourseEvent(
      LoadDetailCourseEvent event, Emitter<DetailCoursePageState> emit) async {
    try {
      emit(DetailCourseLoadState());
      final detailCourse =
          await projectUseCase.getDetailCourse(idCourse: event.courseId);
      final modulesByCourseId =
          await projectUseCase.getModulesByCourceId(idCourse: event.courseId);
      emit(AllCoursesPageLoadedState(
          detailCourse: detailCourse, modulesByCourseId: modulesByCourseId));
    } catch (e) {
      emit(DetailCourseErrorState());
    }
  }

  Future<void> _onLikeEvent(
      LikeEvent event, Emitter<DetailCoursePageState> emit) async {
    // emit(AllCoursesLoadPage());
    // emit(AllCoursesPageLoaded(allCourses: allCourses));
  }
}
