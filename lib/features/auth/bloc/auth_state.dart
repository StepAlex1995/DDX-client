part of 'auth_bloc.dart';

abstract class AuthState {}

final class AuthInitState extends AuthState {}

final class AuthProgressState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final User user;

  AuthSuccessState({required this.user});
}

final class AuthErrorState extends AuthState {
  final int code;
  final String msg;

  AuthErrorState({required this.code, required this.msg});
}
