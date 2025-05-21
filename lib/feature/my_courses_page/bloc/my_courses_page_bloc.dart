import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';

import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';

import 'dart:typed_data';

part 'my_courses_page_event.dart';

part 'my_courses_page_state.dart';

@lazySingleton
class MyCoursesPageBloc extends Bloc<MyCoursesPageEvent, MyCoursesPageState> {
  final ProjectUseCase projectUseCase;

  MyCoursesPageBloc(this.projectUseCase) : super(AllCoursesPageInitial()) {
    on<LoadMyCoursesEvent>(_onLoadMyCoursesEvent);
    on<LoadImagesEvent>(_onLoadImagesEvent);
  }

  Future<void> _onLoadMyCoursesEvent(
      LoadMyCoursesEvent event, Emitter<MyCoursesPageState> emit) async {
    try {
      emit(DetailCourseLoadState());
      List<Uint8List?> buff = [];
      final userInfo = await projectUseCase.getMyUserInfo();
      if (userInfo?.id != null) {
        List<DetailCourseEntity?>? detailCourse;
        try {
          detailCourse =
              await projectUseCase.getByIdCreator(userId: userInfo!.id!);
        } catch (e) {}

        for (int i = 0; i < (detailCourse?.length ?? 0); i++) {
          buff.add(null);
        }

        emit(
          AllCoursesPageLoadedState(
            myCourses: detailCourse,
            imagesFiles: buff,
          ),
        );
      }
    } catch (e) {
      emit(DetailCourseErrorState());
    }
  }

  Future<void> _onLoadImagesEvent(
      LoadImagesEvent event, Emitter<MyCoursesPageState> emit) async {
    List<String> images = [];
    if (state is AllCoursesPageLoadedState) {
      final currentState = state as AllCoursesPageLoadedState;

      images = currentState.myCourses
              ?.map((e) => e?.featuredImage?.small ?? '')
              .toList() ??
          [];
    }

    for (int i = 0; i < images.length; i++) {
      if (state is AllCoursesPageLoadedState) {
        try {
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
        } catch (e) {}
      }
    }
  }
}
