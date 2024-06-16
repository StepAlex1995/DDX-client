part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthUserEvent extends AuthEvent {
  final AuthUser authUser;

  AuthUserEvent({required this.authUser});
}

class AuthInitEvent extends AuthEvent {}
