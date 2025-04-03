import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/usecases/project_usecase.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';

part 'detail_module_page_event.dart';
part 'detail_module_page_state.dart';

@lazySingleton
class DetailModulePageBloc extends Bloc<DetailModulePageEvent, DetailModulePageState> {
  final ProjectUseCase _projectUseCase;

  DetailModulePageBloc(this._projectUseCase) : super(DetailModulePageInitial()) {
    on<LoadModulesEvent>(_onLoadModules);
  }

  Future<void> _onLoadModules(
    LoadModulesEvent event,
    Emitter<DetailModulePageState> emit,
  ) async {
    emit(DetailModulePageLoading());
    
    try {
      final modules = await _projectUseCase.getModulesByCourceId(idCourse: event.courseId);
      
      if (modules == null || modules.data == null || modules.data!.isEmpty) {
        emit(DetailModulePageEmpty());
      } else {
        emit(DetailModulePageLoaded(modules: modules));
      }
    } catch (e) {
      emit(DetailModulePageError(message: 'Ошибка загрузки модулей: $e'));
    }
  }
}