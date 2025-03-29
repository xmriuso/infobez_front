part of 'detail_course_page_bloc.dart';

sealed class DetailCoursePageState extends Equatable {
  const DetailCoursePageState();

  @override
  List<Object> get props => [];
}

final class AllCoursesPageInitial extends DetailCoursePageState {}


final class DetailCourseLoadState extends DetailCoursePageState {}
final class DetailCourseErrorState extends DetailCoursePageState {}
class AllCoursesPageLoadedState extends DetailCoursePageState {
  final DetailCourseEntity? detailCourse;
  final AllLessonsEntity? modulesByCourseId;

  const AllCoursesPageLoadedState({this.detailCourse, this.modulesByCourseId,});
}
