part of 'create_course_page_bloc.dart';

sealed class CreateCoursePageState extends Equatable {
  const CreateCoursePageState();

  @override
  List<Object?> get props => [];
}

final class AllCoursesPageInitial extends CreateCoursePageState {}

final class DetailCourseLoadState extends CreateCoursePageState {}

final class DetailCourseErrorState extends CreateCoursePageState {}

final class SuccessCreateState extends CreateCoursePageState {}

class AllCoursesPageLoadedState extends CreateCoursePageState {
  final DetailCourseEntity? detailCourse;
  final AllLessonsEntity? modulesByCourseId;
  final List<Uint8List?> imagesFiles;
  final Uint8List? courseImage;
  final bool? update;

  const AllCoursesPageLoadedState({
    this.detailCourse,
    this.modulesByCourseId,
    this.update,
    this.courseImage,
    required this.imagesFiles,
  });

  AllCoursesPageLoadedState copyWith({
    DetailCourseEntity? detailCourse,
    AllLessonsEntity? modulesByCourseId,
    List<Uint8List?>? imagesFiles,
    Uint8List? courseImage,
    bool? update,
  }) {
    return AllCoursesPageLoadedState(
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
