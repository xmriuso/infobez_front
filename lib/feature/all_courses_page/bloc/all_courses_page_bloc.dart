import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api_service/api_service.dart';
import '../../../core/api_service/models/all_courses_model.dart';

part 'all_courses_page_event.dart';

part 'all_courses_page_state.dart';

@lazySingleton
class AllCoursesPageBloc
    extends Bloc<AllCoursesPageEvent, AllCoursesPageState> {
  final ApiService _apiService;

  AllCoursesPageBloc(this._apiService) : super(AllCoursesPageInitial()) {
    on<LoadAllCoursesEvent>(_onLoadAllCoursesEvent);
  }

  Future<void> _onLoadAllCoursesEvent(
      LoadAllCoursesEvent event, Emitter<AllCoursesPageState> emit) async {
    emit(AllCoursesLoadPage());
    final allCourses = await _apiService.getAllCourses();
    emit(AllCoursesPageLoaded(allCourses: allCourses));
  }
}
