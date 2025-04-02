part of 'detail_course_page_bloc.dart';

sealed class DetailCoursePageEvent extends Equatable {
  const DetailCoursePageEvent();

  @override
  List<Object?> get props => [];
}

class LoadDetailCourseEvent extends DetailCoursePageEvent {
  final int courseId;

  const LoadDetailCourseEvent({required this.courseId});
}

class LikeEvent extends DetailCoursePageEvent {
  final int? courseId;
  final int? moludeId;

  const LikeEvent({this.courseId, this.moludeId});
}

class LoadImagesEvent extends DetailCoursePageEvent {
  const LoadImagesEvent();
}
