import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';

import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';

import 'dart:typed_data';

part 'detail_course_page_event.dart';

part 'detail_course_page_state.dart';

@lazySingleton
class DetailCoursePageBloc
    extends Bloc<DetailCoursePageEvent, DetailCoursePageState> {
  final ProjectUseCase projectUseCase;

  DetailCoursePageBloc(this.projectUseCase) : super(AllCoursesPageInitial()) {
    on<LoadDetailCourseEvent>(_onLoadDetailCourseEvent);
    on<LikeEvent>(_onLikeEvent);
    on<LoadImagesEvent>(_onLoadImagesEvent);
    on<SetDetailModule>(_onSetDetailModule);
  }

  Future<void> _onLoadDetailCourseEvent(
      LoadDetailCourseEvent event, Emitter<DetailCoursePageState> emit) async {
    try {
      emit(DetailCourseLoadState());
      List<Uint8List?> buff = [];

      final detailCourse =
          await projectUseCase.getDetailCourse(idCourse: event.courseId);
      final modulesByCourseId =
          await projectUseCase.getModulesByCourceId(idCourse: event.courseId);
      for (int i = 0; i < (modulesByCourseId?.data?.length ?? 0); i++) {
        buff.add(null);
      }
      emit(
        AllCoursesPageLoadedState(
          detailCourse: detailCourse,
          modulesByCourseId: modulesByCourseId,
          imagesFiles: buff,
        ),
      );
    } catch (e) {
      emit(DetailCourseErrorState());
    }
  }

  Future<void> _onLoadImagesEvent(
      LoadImagesEvent event, Emitter<DetailCoursePageState> emit) async {
    List<String> images = [];
    if (state is AllCoursesPageLoadedState) {
      final currentState = state as AllCoursesPageLoadedState;

      images = currentState.modulesByCourseId?.data
              ?.map((e) => e.featuredImage?.small ?? '')
              .toList() ??
          [];
    }

    for (int i = 0; i < images.length; i++) {
      if (state is AllCoursesPageLoadedState) {
        final currentState = state as AllCoursesPageLoadedState;
        List<Uint8List?> buff = currentState.imagesFiles;
        final currentImage =
            await projectUseCase.getImageFromString(image: images[i]);
        buff[i] = currentImage;
        final update = currentState.update ?? false;
        emit(
          currentState.copyWith(
            imagesFiles: buff,
            update: !update,
          ),
        );
      }
    }
  }

  Future<void> _onLikeEvent(
      LikeEvent event, Emitter<DetailCoursePageState> emit) async {
    // emit(AllCoursesLoadPage());
    // emit(AllCoursesPageLoaded(allCourses: allCourses));
  }

  Future<void> _onSetDetailModule(
      SetDetailModule event, Emitter<DetailCoursePageState> emit) async {
    if (state is AllCoursesPageLoadedState) {
      final currentState = state as AllCoursesPageLoadedState;
      emit(currentState.copyWith(selectedModuleIndex: event.moduleIndex));
    }
  }
}
