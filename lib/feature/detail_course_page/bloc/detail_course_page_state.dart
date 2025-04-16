part of 'detail_course_page_bloc.dart';

sealed class DetailCoursePageState extends Equatable {
  const DetailCoursePageState();

  @override
  List<Object?> get props => [];
}

final class AllCoursesPageInitial extends DetailCoursePageState {}

final class DetailCourseLoadState extends DetailCoursePageState {}

final class DetailCourseErrorState extends DetailCoursePageState {}

class AllCoursesPageLoadedState extends DetailCoursePageState {
  final DetailCourseEntity? detailCourse;
  final AllLessonsEntity? modulesByCourseId;
  final List<Uint8List?> imagesFiles;
  final bool? update;
  final int? selectedModuleIndex;

  const AllCoursesPageLoadedState({
    this.detailCourse,
    this.modulesByCourseId,
    this.update,
    this.selectedModuleIndex,
    required this.imagesFiles,
  });

  AllCoursesPageLoadedState copyWith({
    DetailCourseEntity? detailCourse,
    AllLessonsEntity? modulesByCourseId,
    List<Uint8List?>? imagesFiles,
    bool? update,
    int? selectedModuleIndex,
  }) {
    return AllCoursesPageLoadedState(
      detailCourse: detailCourse ?? this.detailCourse,
      modulesByCourseId: modulesByCourseId ?? this.modulesByCourseId,
      imagesFiles: imagesFiles ?? this.imagesFiles,
      update: update ?? this.update,
      selectedModuleIndex: selectedModuleIndex ?? this.selectedModuleIndex,
    );
  }

  @override
  List<Object?> get props => [
        detailCourse,
        modulesByCourseId,
        update,
        selectedModuleIndex,
        imagesFiles,
      ];
}
