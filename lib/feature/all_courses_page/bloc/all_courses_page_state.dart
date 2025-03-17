part of 'all_courses_page_bloc.dart';

sealed class AllCoursesPageState extends Equatable {
  const AllCoursesPageState();

  @override
  List<Object> get props => [];
}

final class AllCoursesPageInitial extends AllCoursesPageState {}

final class AllCoursesLoadPage extends AllCoursesPageState {}

class AllCoursesPageLoaded extends AllCoursesPageState {
  final List<AllCoursesModel>? allCourses;

  const AllCoursesPageLoaded({this.allCourses});
}
