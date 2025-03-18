import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';

part 'all_courses_page_event.dart';

part 'all_courses_page_state.dart';

@lazySingleton
class AllCoursesPageBloc
    extends Bloc<AllCoursesPageEvent, AllCoursesPageState> {
  final ProjectUseCase projectUseCase;

  AllCoursesPageBloc(this.projectUseCase) : super(AllCoursesPageInitial()) {
    on<LoadAllCoursesEvent>(_onLoadAllCoursesEvent);
  }

  Future<void> _onLoadAllCoursesEvent(
      LoadAllCoursesEvent event, Emitter<AllCoursesPageState> emit) async {
    emit(AllCoursesLoadPage());
    final allCourses = await projectUseCase.getAllCourses();
    emit(AllCoursesPageLoaded(allCourses: allCourses));
  }
}
