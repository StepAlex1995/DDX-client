part of 'registration_bloc.dart';

abstract class RegistrationState {}

class RegistrationInitState extends RegistrationState {}

class RegistrationProgressState extends RegistrationState {}

class RegistrationSuccessState extends RegistrationState {
  final User user;

  RegistrationSuccessState({required this.user});
}

class RegistrationErrorState extends RegistrationState {
  final int code;
  final String msg;

  RegistrationErrorState({required this.code, required this.msg});
}
