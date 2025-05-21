part of 'profile_page_bloc.dart';

sealed class ProfilePageState extends Equatable {
  const ProfilePageState();

  @override
  List<Object?> get props => [];
}

final class ProfilePageInitial extends ProfilePageState {}

final class ProfilePageLoadingState extends ProfilePageState {}

final class ProfilePageErrorState extends ProfilePageState {}

class ProfilePageLoadedState extends ProfilePageState {
  final UserInfoEntity? userInfo;
  final Uint8List? image;

  const ProfilePageLoadedState({
    required this.userInfo,
    required this.image,
  });

  ProfilePageLoadedState copyWith({
    UserInfoEntity? userInfo,
    Uint8List? image,
  }) {
    return ProfilePageLoadedState(
      userInfo: userInfo ?? this.userInfo,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        userInfo,
        image,
      ];
}
