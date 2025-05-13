part of 'auth_page_bloc.dart';

sealed class AuthPageState extends Equatable {
  const AuthPageState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthPageState {}
final class AuthLoadingState extends AuthPageState {}
final class AuthErrorState extends AuthPageState {}
final class AuthSuccessState extends AuthPageState {}

