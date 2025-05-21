part of 'create_course_page_bloc.dart';

sealed class CreateCoursePageEvent extends Equatable {
  const CreateCoursePageEvent();

  @override
  List<Object?> get props => [];
}

class LoadDetailCourseEvent extends CreateCoursePageEvent {
  final int? courseId;

  const LoadDetailCourseEvent({
    required this.courseId,
  });
}

class LoadCreateCoursesImagesEvent extends CreateCoursePageEvent {
  const LoadCreateCoursesImagesEvent();
}

class CreateCourseEvent extends CreateCoursePageEvent {
  final String? title;
  final String? description;
  final html.File? image;
  final int? courseId;

  const CreateCourseEvent({
    this.title,
    this.description,
    this.image,
    this.courseId,
  });
}
