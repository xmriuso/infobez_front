part of 'my_courses_page_bloc.dart';

sealed class MyCoursesPageEvent extends Equatable {
  const MyCoursesPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyCoursesEvent extends MyCoursesPageEvent {
  const LoadMyCoursesEvent();
}

class LoadImagesEvent extends MyCoursesPageEvent {
  const LoadImagesEvent();
}
