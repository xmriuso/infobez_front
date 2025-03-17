part of 'all_courses_page_bloc.dart';

sealed class AllCoursesPageEvent extends Equatable {
  const AllCoursesPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllCoursesEvent extends AllCoursesPageEvent {
  const LoadAllCoursesEvent();
}
