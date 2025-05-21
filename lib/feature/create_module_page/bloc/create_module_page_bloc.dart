import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api_service/domain/entities/modules_by_id_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';
import 'dart:html' as html;
import 'dart:typed_data';

part 'create_module_page_event.dart';

part 'create_module_page_state.dart';

@lazySingleton
class CreateModulePageBloc
    extends Bloc<CreateModulePageEvent, CreateModulePageState> {
  final ProjectUseCase projectUseCase;

  CreateModulePageBloc(this.projectUseCase) : super(AllCoursesPageInitial()) {
    on<LoadDetailModuleEvent>(_onLoadDetailModuleEvent);
    on<CreateModuleEvent>(_onCreateModuleEvent);
  }

  Future<void> _onLoadDetailModuleEvent(
      LoadDetailModuleEvent event, Emitter<CreateModulePageState> emit) async {
    try {
      emit(DetailCourseLoadState());
      if (event.moduleId != null && event.moduleId != 0) {
        final module =
            await projectUseCase.getModuleById(moduleId: event.moduleId!);

        final moduleImage = await projectUseCase.getImageFromString(
            image: module?.featuredImage?.small ?? '');

        emit(
          AllCoursesPageLoadedState(
            detailModule: module,
            moduleImage: moduleImage,
          ),
        );
        return;
      }
      emit(
        AllCoursesPageLoadedState(
          detailModule: null,
          moduleImage: null,
        ),
      );
    } catch (e) {
      emit(DetailCourseErrorState());
    }
  }

  Future<void> _onCreateModuleEvent(
      CreateModuleEvent event, Emitter<CreateModulePageState> emit) async {
    try {
      emit(DetailCourseLoadState());
      if (event.moduleId == 0) {
        await projectUseCase.createModule(
          courseId: event.courseId,
          title: event.title,
          description: event.description,
          image: event.image,
          videoUrl: event.videoUrl,
        );
        emit(
          SuccessCreateState(),
        );
      } else {
        await projectUseCase.updateModule(
          id: event.moduleId,
          title: event.title,
          description: event.description,
          image: event.image,
          videoUrl: event.videoUrl,
        );
        emit(
          SuccessCreateState(),
        );
      }
    } catch (e) {
      emit(DetailCourseErrorState());
    }
  }
}
