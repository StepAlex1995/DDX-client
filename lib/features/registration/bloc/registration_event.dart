part of 'registration_bloc.dart';

abstract class RegistrationEvent {}

class RegistrationUserEvent extends RegistrationEvent {
  final RegUser regUser;

  RegistrationUserEvent({required this.regUser});
}

class RegistrationInitEvent extends RegistrationEvent {}
