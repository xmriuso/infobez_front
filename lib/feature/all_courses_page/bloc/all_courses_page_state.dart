part of 'all_courses_page_bloc.dart';

sealed class AllCoursesPageState extends Equatable {
  const AllCoursesPageState();

  @override
  List<Object?> get props => [];
}

final class AllCoursesPageInitial extends AllCoursesPageState {}

final class AllCoursesLoadPage extends AllCoursesPageState {}

class AllCoursesPageLoaded extends AllCoursesPageState {
  final AllCoursesEntity? allCourses;
  final List<Uint8List?> imagesFiles;
  final bool? update;

  const AllCoursesPageLoaded({
    this.allCourses,
    required this.imagesFiles,
    this.update,
  });

  AllCoursesPageLoaded copyWith({
    AllCoursesEntity? allCourses,
    List<Uint8List?>? imagesFiles,
    bool? update,
  }) {
    return AllCoursesPageLoaded(
      allCourses: allCourses ?? this.allCourses,
      imagesFiles: imagesFiles ?? this.imagesFiles,
      update: update ?? this.update,
    );
  }

  @override
  List<Object?> get props => [
        allCourses,
        imagesFiles,
        update,
      ];
}
