part of 'detail_module_page_bloc.dart';

abstract class DetailModulePageEvent extends Equatable {
  const DetailModulePageEvent();

  @override
  List<Object> get props => [];
}

class LoadModulesEvent extends DetailModulePageEvent {
  final int courseId;

  const LoadModulesEvent(this.courseId);

  @override
  List<Object> get props => [courseId];
}