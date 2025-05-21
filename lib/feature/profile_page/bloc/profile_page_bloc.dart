import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';
import 'package:test_web_project/core/di/di.dart';

import '../../../core/api_service/domain/entities/all_courses_entity.dart';
import '../../../core/api_service/domain/entities/user_info_entity.dart';
import '../../../core/api_service/domain/usecases/project_usecase.dart';

import 'dart:typed_data';

import '../../../core/services/cache_service_cubit/cache_service_cubit.dart';
import 'dart:html' as html;

part 'profile_page_event.dart';

part 'profile_page_state.dart';

@lazySingleton
class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final ProjectUseCase projectUseCase;

  ProfilePageBloc(this.projectUseCase) : super(ProfilePageInitial()) {
    on<GetMyUserInfo>(_onGetMyUserInfo);
    on<ChangeUserInfo>(_onChangeUserInfo);
  }

  Future<void> _onGetMyUserInfo(
      GetMyUserInfo event, Emitter<ProfilePageState> emit) async {
    emit(ProfilePageLoadingState());
    try {
      final userInfo = await projectUseCase.getMyUserInfo();
      Uint8List? image;
      if (userInfo?.featuredImage?.small != null) {
        image = await _onLoadImageEvent(userInfo!.featuredImage!.small!);
      }
      emit(
        ProfilePageLoadedState(
          userInfo: userInfo,
          image: image,
        ),
      );
    } catch (e) {
      emit(ProfilePageErrorState());
    }
  }

  Future<void> _onChangeUserInfo(
      ChangeUserInfo event, Emitter<ProfilePageState> emit) async {
    if (state is ProfilePageLoadedState) {
      final currentState = state as ProfilePageLoadedState;
      emit(ProfilePageLoadingState());
      try {
        await projectUseCase.userUpdate(
          name: event.name != currentState.userInfo?.name ? event.name : null,
          email:
              event.email != currentState.userInfo?.email ? event.email : null,
          password: event.password,
          image: event.image,
        );
        await Future.delayed(Duration(milliseconds: 500));
        final userInfo = await projectUseCase.getMyUserInfo();
        Uint8List? image;
        if (userInfo?.featuredImage?.small != null) {
          image = await _onLoadImageEvent(userInfo!.featuredImage!.small!);
        }
        emit(
          ProfilePageLoadedState(
            userInfo: userInfo,
            image: image,
          ),
        );
      } catch (e) {
        emit(ProfilePageErrorState());
      }
    }
  }

  Future<Uint8List?> _onLoadImageEvent(String image) async {
    try {
      return await projectUseCase.getImageFromString(image: image);
    } catch (e) {}
    return null;
  }
}
