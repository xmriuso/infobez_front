part of 'profile_page_bloc.dart';

sealed class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object?> get props => [];
}

class GetMyUserInfo extends ProfilePageEvent {
  const GetMyUserInfo();
}

class ChangeUserInfo extends ProfilePageEvent {
  final String? name;
  final String? email;
  final String? password;
  final html.File? image;

  const ChangeUserInfo({this.name, this.email, this.password, this.image});
}
