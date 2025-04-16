part of 'favourites_courses_page_bloc.dart';

sealed class FavouritesCoursesPageState extends Equatable {
  const FavouritesCoursesPageState();

  @override
  List<Object?> get props => [];
}

final class FavouritesCoursesPageInitial extends FavouritesCoursesPageState {}

final class FavouritesCoursesLoadState extends FavouritesCoursesPageState {}

final class FavouritesCoursesErrorState extends FavouritesCoursesPageState {}

class FavouritesCoursesLoadedState extends FavouritesCoursesPageState {
  final List<DetailCourseEntity> favouriteCourses;
  final List<Uint8List?> imagesFiles;
  final bool? update;

  const FavouritesCoursesLoadedState({
    required this.favouriteCourses,
    required this.imagesFiles,
    this.update,
  });

  FavouritesCoursesLoadedState copyWith({
    List<DetailCourseEntity>? favouriteCourses,
    List<Uint8List?>? imagesFiles,
    bool? update,
  }) {
    return FavouritesCoursesLoadedState(
      favouriteCourses: favouriteCourses ?? this.favouriteCourses,
      imagesFiles: imagesFiles ?? this.imagesFiles,
      update: update ?? this.update,
    );
  }

  @override
  List<Object?> get props => [
        favouriteCourses,
        imagesFiles,
        update,
      ];
}
