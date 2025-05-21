part of 'create_module_page_bloc.dart';

sealed class CreateModulePageState extends Equatable {
  const CreateModulePageState();

  @override
  List<Object?> get props => [];
}

final class AllCoursesPageInitial extends CreateModulePageState {}

final class DetailCourseLoadState extends CreateModulePageState {}

final class DetailCourseErrorState extends CreateModulePageState {}

final class SuccessCreateState extends CreateModulePageState {}

class AllCoursesPageLoadedState extends CreateModulePageState {
  final LessonEntity? detailModule;
  final Uint8List? moduleImage;
  final bool? update;

  const AllCoursesPageLoadedState({
    this.detailModule,
    this.moduleImage,
    this.update,
  });

  AllCoursesPageLoadedState copyWith({
    LessonEntity? detailModule,
    AllLessonsEntity? modulesByCourseId,
    List<Uint8List?>? imagesFiles,
    Uint8List? courseImage,
    bool? update,
  }) {
    return AllCoursesPageLoadedState(
      detailModule: detailModule ?? this.detailModule,
      moduleImage: moduleImage ?? this.moduleImage,
      update: update ?? this.update,
    );
  }

  @override
  List<Object?> get props => [
        detailModule,
        moduleImage,
        update,
      ];
}
