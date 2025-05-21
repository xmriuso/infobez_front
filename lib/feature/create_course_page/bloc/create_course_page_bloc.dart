import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';

import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';
import 'dart:html' as html;
import 'dart:typed_data';

part 'create_course_page_event.dart';

part 'create_course_page_state.dart';

@lazySingleton
class CreateCoursePageBloc
    extends Bloc<CreateCoursePageEvent, CreateCoursePageState> {
  final ProjectUseCase projectUseCase;

  CreateCoursePageBloc(this.projectUseCase) : super(AllCoursesPageInitial()) {
    on<LoadDetailCourseEvent>(_onLoadDetailCourseEvent);
    on<CreateCourseEvent>(_onCreateCourseEvent);
    on<LoadCreateCoursesImagesEvent>(_onLoadCreateCoursesImagesEvent);
  }

  Future<void> _onLoadDetailCourseEvent(
      LoadDetailCourseEvent event, Emitter<CreateCoursePageState> emit) async {
    try {
      emit(CreateCoursesLoadState());
      if (event.courseId != null && event.courseId != 0) {
        List<Uint8List?> buff = [];
        final detailCourse =
            await projectUseCase.getDetailCourse(idCourse: event.courseId!);

        final courseImage = await projectUseCase.getImageFromString(
            image: detailCourse?.featuredImage?.small ?? '');
        final modulesByCourseId = await projectUseCase.getModulesByCourceId(
            idCourse: event.courseId!);
        for (int i = 0; i < (modulesByCourseId?.data?.length ?? 0); i++) {
          buff.add(null);
        }

        emit(
          CreateCoursesPageLoadedState(
            detailCourse: detailCourse,
            modulesByCourseId: modulesByCourseId,
            imagesFiles: buff,
            courseImage: courseImage,
          ),
        );
        return;
      }
      emit(
        CreateCoursesPageLoadedState(
          detailCourse: null,
          modulesByCourseId: null,
          imagesFiles: [],
        ),
      );
    } catch (e) {
      emit(CreateCoursesErrorState());
    }
  }

  Future<void> _onCreateCourseEvent(
      CreateCourseEvent event, Emitter<CreateCoursePageState> emit) async {
    try {
      emit(CreateCoursesLoadState());
      if (event.courseId == 0) {
        await projectUseCase.createCourse(
          title: event.title,
          description: event.description,
          image: event.image,
        );
        emit(
          CreateCourseSuccessState(),
        );
      } else {
        await projectUseCase.updateCourse(
          id: event.courseId,
          title: event.title,
          description: event.description,
          image: event.image,
        );
        emit(
          CreateCourseSuccessState(),
        );
      }
    } catch (e) {
      emit(CreateCoursesErrorState());
    }
  }

  Future<void> _onLoadCreateCoursesImagesEvent(
      LoadCreateCoursesImagesEvent event,
      Emitter<CreateCoursePageState> emit) async {
    List<String> images = [];
    if (state is CreateCoursesPageLoadedState) {
      final currentState = state as CreateCoursesPageLoadedState;

      images = currentState.modulesByCourseId?.data
              ?.map((e) => e.featuredImage?.small ?? '')
              .toList() ??
          [];
    }

    for (int i = 0; i < images.length; i++) {
      if (state is CreateCoursesPageLoadedState) {
        try {
          final currentState = state as CreateCoursesPageLoadedState;
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
