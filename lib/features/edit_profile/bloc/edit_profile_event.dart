part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class TryEditProfileEvent extends EditProfileEvent {
  final User user;
  final UpdateUserRequestModel updateUserModel;

  TryEditProfileEvent({required this.user, required this.updateUserModel});

}

class EditProfileInitEvent extends EditProfileEvent {}
