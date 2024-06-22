part of 'edit_profile_bloc.dart';

abstract class EditProfileState {}

final class EditProfileInitState extends EditProfileState {}

final class EditProfileProgressState extends EditProfileState {}

final class EditProfileSuccessState extends EditProfileState {
  final User user;

  EditProfileSuccessState({required this.user});
}

final class EditProfileErrorState extends EditProfileState {
  final int code;
  final String msg;

  EditProfileErrorState({required this.code, required this.msg});
}
