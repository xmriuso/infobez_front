part of 'favourites_courses_page_bloc.dart';

sealed class FavouritesCoursesPageEvent extends Equatable {
  const FavouritesCoursesPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavouriteCoursesEvent extends FavouritesCoursesPageEvent {
  const LoadFavouriteCoursesEvent();
}

class LoadFavouriteCoursesImagesEvent extends FavouritesCoursesPageEvent {
  const LoadFavouriteCoursesImagesEvent();
}