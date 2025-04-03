part of 'detail_module_page_bloc.dart';

abstract class DetailModulePageState extends Equatable {
  const DetailModulePageState();

  @override
  List<Object> get props => [];
}

class DetailModulePageInitial extends DetailModulePageState {}

class DetailModulePageLoading extends DetailModulePageState {}

class DetailModulePageLoaded extends DetailModulePageState {
  final AllLessonsEntity modules;

  const DetailModulePageLoaded({required this.modules});

  @override
  List<Object> get props => [modules];
}

class DetailModulePageEmpty extends DetailModulePageState {}

class DetailModulePageError extends DetailModulePageState {
  final String message;

  const DetailModulePageError({required this.message});

  @override
  List<Object> get props => [message];
}