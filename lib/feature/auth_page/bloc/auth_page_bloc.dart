import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';
import 'package:test_web_project/core/di/di.dart';

import '../../../core/api_client/api_client.dart';
import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';

import 'dart:typed_data';

part 'auth_page_event.dart';

part 'auth_page_state.dart';

@lazySingleton
class AuthPageBloc extends Bloc<AuthPageEvent, AuthPageState> {
  final ProjectUseCase projectUseCase;

  AuthPageBloc(this.projectUseCase) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<CheckAuthEvent>(_onCheckAuthEvent);
  }

  Future<void> _onCheckAuthEvent(
      CheckAuthEvent event, Emitter<AuthPageState> emit) async {
    final bool = await getIt.get<ApiClient>().refreshToken();
    print('123421342314 $bool');
    if (bool) {
      emit(
        AuthSuccessState(),
      );
    }
  }

  Future<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthPageState> emit) async {
    try {
      emit(AuthLoadingState());
      await projectUseCase.login(
        username: event.username,
        password: event.password,
      );
      emit(
        AuthSuccessState(),
      );
    } catch (e) {
      emit(AuthErrorState());
    }
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthPageState> emit) async {
    try {
      emit(AuthLoadingState());
      await projectUseCase.userCreate(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(
        AuthSuccessState(),
      );
    } catch (e) {
      emit(AuthErrorState());
    }
  }
}
