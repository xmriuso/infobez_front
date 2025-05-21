import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';
import 'package:test_web_project/core/di/di.dart';
import 'package:test_web_project/main.dart';

import '../../../core/api_client/api_client.dart';
import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';

import 'dart:typed_data';

import '../../app/routing/route_path.dart';

part 'auth_page_event.dart';

part 'auth_page_state.dart';

@lazySingleton
class AuthPageBloc extends Bloc<AuthPageEvent, AuthPageState> {
  final ProjectUseCase projectUseCase;

  AuthPageBloc(this.projectUseCase) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<CheckAuthEvent>(_onCheckAuthEvent);
    on<LogOutEvent>(_onLogOutEvent);
  }

  Future<void> _onCheckAuthEvent(
      CheckAuthEvent event, Emitter<AuthPageState> emit) async {
    final bool = await getIt.get<ApiClient>().refreshToken();
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
      router.router.goNamed(RoutePath.allCoursesPage);
    } catch (e) {
      emit(AuthErrorState());
    }
  }

  Future<void> _onLogOutEvent(
      LogOutEvent event, Emitter<AuthPageState> emit) async {
    ApiClient.deleteToken();
    emit(AuthInitial());
    router.router.go(RoutePath.authPage);
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
        SuccessRegisterState(),
      );
    } catch (e) {
      emit(AuthErrorState());
    }
  }
}
