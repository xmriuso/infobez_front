part of 'create_module_page_bloc.dart';

sealed class CreateModulePageEvent extends Equatable {
  const CreateModulePageEvent();

  @override
  List<Object?> get props => [];
}

class LoadDetailModuleEvent extends CreateModulePageEvent {
  final int? moduleId;

  const LoadDetailModuleEvent({
    required this.moduleId,
  });
}

class CreateModuleEvent extends CreateModulePageEvent {
  final String? title;
  final String? description;
  final String? videoUrl;
  final html.File? image;
  final int? moduleId;
  final int? courseId;

  const CreateModuleEvent({
    this.title,
    this.description,
    this.image,
    this.moduleId,
    this.videoUrl,
    this.courseId,
  });
}
