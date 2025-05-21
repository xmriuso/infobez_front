part of 'auth_page_bloc.dart';

sealed class AuthPageEvent extends Equatable {
  const AuthPageEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthEvent extends AuthPageEvent {
  const CheckAuthEvent();
}

class LogOutEvent extends AuthPageEvent {
  const LogOutEvent();
}

class LoginEvent extends AuthPageEvent {
  final String username;
  final String password;

  const LoginEvent({
    required this.username,
    required this.password,
  });
}

class RegisterEvent extends AuthPageEvent {
  final String name;
  final String email ;
  final String password;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
