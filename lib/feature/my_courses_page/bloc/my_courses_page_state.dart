part of 'my_courses_page_bloc.dart';

sealed class MyCoursesPageState extends Equatable {
  const MyCoursesPageState();

  @override
  List<Object?> get props => [];
}

final class AllCoursesPageInitial extends MyCoursesPageState {}

final class DetailCourseLoadState extends MyCoursesPageState {}

final class DetailCourseErrorState extends MyCoursesPageState {}

class AllCoursesPageLoadedState extends MyCoursesPageState {
  final List<DetailCourseEntity?>? myCourses;
  final List<Uint8List?> imagesFiles;
  final bool? update;

  const AllCoursesPageLoadedState({
    this.myCourses,
    this.update,
    required this.imagesFiles,
  });

  AllCoursesPageLoadedState copyWith({
    List<DetailCourseEntity?>? myCourses,
    AllLessonsEntity? modulesByCourseId,
    List<Uint8List?>? imagesFiles,
    bool? update,
  }) {
    return AllCoursesPageLoadedState(
      myCourses: myCourses ?? this.myCourses,
      imagesFiles: imagesFiles ?? this.imagesFiles,
      update: update ?? this.update,
    );
  }

  @override
  List<Object?> get props => [
        myCourses,
        update,
        imagesFiles,
      ];
}
