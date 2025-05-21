part of 'create_course_page_bloc.dart';

sealed class CreateCoursePageState extends Equatable {
  const CreateCoursePageState();

  @override
  List<Object?> get props => [];
}

final class AllCoursesPageInitial extends CreateCoursePageState {}

final class CreateCoursesLoadState extends CreateCoursePageState {}

final class CreateCoursesErrorState extends CreateCoursePageState {}

final class CreateCourseSuccessState extends CreateCoursePageState {}

class CreateCoursesPageLoadedState extends CreateCoursePageState {
  final DetailCourseEntity? detailCourse;
  final AllLessonsEntity? modulesByCourseId;
  final List<Uint8List?> imagesFiles;
  final Uint8List? courseImage;
  final bool? update;

  const CreateCoursesPageLoadedState({
    this.detailCourse,
    this.modulesByCourseId,
    this.update,
    this.courseImage,
    required this.imagesFiles,
  });

  CreateCoursesPageLoadedState copyWith({
    DetailCourseEntity? detailCourse,
    AllLessonsEntity? modulesByCourseId,
    List<Uint8List?>? imagesFiles,
    Uint8List? courseImage,
    bool? update,
  }) {
    return CreateCoursesPageLoadedState(
      detailCourse: detailCourse ?? this.detailCourse,
      courseImage: courseImage ?? this.courseImage,
      modulesByCourseId: modulesByCourseId ?? this.modulesByCourseId,
      imagesFiles: imagesFiles ?? this.imagesFiles,
      update: update ?? this.update,
    );
  }

  @override
  List<Object?> get props => [
        detailCourse,
        courseImage,
        modulesByCourseId,
        update,
        imagesFiles,
      ];
}
