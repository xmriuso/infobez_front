import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';
import 'package:test_web_project/core/di/di.dart';

import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';

import 'dart:typed_data';

import '../../../core/services/cache_service_cubit/cache_service_cubit.dart';

part 'favourites_courses_page_event.dart';

part 'favourites_courses_page_state.dart';

@lazySingleton
class FavouritesCoursesPageBloc
    extends Bloc<FavouritesCoursesPageEvent, FavouritesCoursesPageState> {
  final ProjectUseCase projectUseCase;

  FavouritesCoursesPageBloc(this.projectUseCase)
      : super(FavouritesCoursesPageInitial()) {
    on<LoadFavouriteCoursesEvent>(_onLoadFavouriteCoursesEvent);
    on<LoadFavouriteCoursesImagesEvent>(_onLoadFavouriteCoursesImagesEvent);
  }

  Future<void> _onLoadFavouriteCoursesEvent(LoadFavouriteCoursesEvent event,
      Emitter<FavouritesCoursesPageState> emit) async {
    List<DetailCourseEntity> favouriteCoursesList = [];
    List<Uint8List?> buff = [];

    emit(FavouritesCoursesLoadState());
    final favouriteCoursesIds = getIt.get<CacheServiceCubit>().state.favourites;
    for (var id in favouriteCoursesIds) {
      final favouriteCourses =
          await projectUseCase.getDetailCourse(idCourse: id);
      if (favouriteCourses != null) {
        buff.add(null);
        favouriteCoursesList.add(favouriteCourses);
      }
    }
    emit(
      FavouritesCoursesLoadedState(
        favouriteCourses: favouriteCoursesList,
        imagesFiles: buff,
      ),
    );
  }

  Future<void> _onLoadFavouriteCoursesImagesEvent(
      LoadFavouriteCoursesImagesEvent event,
      Emitter<FavouritesCoursesPageState> emit) async {
    List<String> images = [];
    final thisState = state as FavouritesCoursesLoadedState;

    images = thisState.favouriteCourses
        .map((e) => e.featuredImage?.small ?? '')
        .toList();

    for (int i = 0; i < images.length; i++) {
      final currentState = state as FavouritesCoursesLoadedState;

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
