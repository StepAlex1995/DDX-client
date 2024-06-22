import 'package:ddx_trainer/repository/user_repository/abstract_user_repository.dart';
import 'package:ddx_trainer/repository/user_repository/model/update_user_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final AbstractUserRepository userRepository;

  EditProfileBloc(this.userRepository) : super(EditProfileInitState()) {
    on<TryEditProfileEvent>((event, emit) async {
      try {
        if (event.updateUserModel.name.isEmpty ||
            event.updateUserModel.phone.isEmpty) {
          emit(EditProfileErrorState(
              code: 400, msg: AppTxt.errorInputDataIsEmpty));
        } else {
          emit(EditProfileProgressState());
          final updateUserResponse = await userRepository.editProfile(
              event.user, event.updateUserModel);
          if (updateUserResponse.code != 200) {
            if (updateUserResponse.code == 401) {
              emit(EditProfileErrorState(
                  code: 401, msg: AppTxt.errorTokenFailed));
            } else {
              emit(EditProfileErrorState(
                  code: 500, msg: AppTxt.errorServerResponse));
            }
          } else {
            var user = await userRepository.getSavedUser();
            user!.name = updateUserResponse.data!.clientUpdated!.name!;
            user.isMan = updateUserResponse.data!.clientUpdated!.isMan!;
            user.phone = updateUserResponse.data!.clientUpdated!.phone!;
            user.birthDate = updateUserResponse.data!.clientUpdated!.birthDate!;
            user.isFullProfile = true;
            userRepository.saveUser(user);
            emit(EditProfileSuccessState(user: user));
          }
        }
      } catch (e) {
        emit(EditProfileErrorState(code: 500, msg: AppTxt.errorServerResponse));
      }
    });

    on<EditProfileInitEvent>((event, emit) async {
      emit(EditProfileInitState());
    });
  }
}
