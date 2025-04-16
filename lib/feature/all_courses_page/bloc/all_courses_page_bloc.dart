import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';
import 'dart:typed_data';

part 'all_courses_page_event.dart';

part 'all_courses_page_state.dart';

@lazySingleton
class AllCoursesPageBloc
    extends Bloc<AllCoursesPageEvent, AllCoursesPageState> {
  final ProjectUseCase projectUseCase;

  AllCoursesPageBloc(this.projectUseCase) : super(AllCoursesPageInitial()) {
    on<LoadAllCoursesEvent>(_onLoadAllCoursesEvent);
    on<LoadAllCoursesImagesEvent>(_onLoadAllCoursesImagesEvent);
  }

  Future<void> _onLoadAllCoursesEvent(
      LoadAllCoursesEvent event, Emitter<AllCoursesPageState> emit) async {
    emit(AllCoursesLoadPage());
    List<Uint8List?> buff = [];
    final allCourses = await projectUseCase.getAllCourses();
    for (int i = 0; i < (allCourses?.data?.length ?? 0); i++) {
      buff.add(null);
    }
    emit(
      AllCoursesPageLoaded(
        allCourses: allCourses,
        imagesFiles: buff,
      ),
    );
  }

  Future<void> _onLoadAllCoursesImagesEvent(LoadAllCoursesImagesEvent event,
      Emitter<AllCoursesPageState> emit) async {
    List<String> images = [];
    if (state is AllCoursesPageLoaded) {
      final currentState = state as AllCoursesPageLoaded;

      images = currentState.allCourses?.data
              ?.map((e) => e.featuredImage?.small ?? '')
              .toList() ??
          [];
    }

    for (int i = 0; i < images.length; i++) {
      if (state is AllCoursesPageLoaded) {
        final currentState = state as AllCoursesPageLoaded;
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
}
