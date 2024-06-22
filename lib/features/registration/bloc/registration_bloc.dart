import 'package:ddx_trainer/repository/user_repository/abstract_user_repository.dart';
import 'package:ddx_trainer/repository/user_repository/model/auth_user.dart';
import 'package:ddx_trainer/repository/user_repository/model/base_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/user_repository/model/reg_user.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AbstractUserRepository userRepository;

  RegistrationBloc(this.userRepository) : super(RegistrationInitState()) {
    on<RegistrationUserEvent>((event, emit) async {
      emit(RegistrationInitState());
      try {
        if (event.regUser.login.isEmpty ||
            event.regUser.password.isEmpty ||
            event.regUser.passwordRepeat.isEmpty) {
          emit(RegistrationErrorState(
              code: 400, msg: AppTxt.errorInputDataIsEmpty));
        } else if (event.regUser.password != event.regUser.passwordRepeat) {
          emit(RegistrationErrorState(
              code: 400, msg: AppTxt.errorPasswordsNotEqual));
        } else {
          emit(RegistrationProgressState());
          final regRsponse = await userRepository.signUp(event.regUser);
          if (regRsponse.code != 200) {
            if (regRsponse.code == 401) {
              emit(RegistrationErrorState(
                  code: 400, msg: AppTxt.errorUserIsAlreadyExist));
            } else {
              emit(RegistrationErrorState(
                  code: 500, msg: AppTxt.errorServerResponse));
            }
          } else {
            ///authorization new user
            final userResponse = await userRepository.signIn(AuthUser(
                login: event.regUser.login, password: event.regUser.password));
            if (userResponse.code != 200 || userResponse.data == null) {
              if (userResponse.code == 404) {
                emit(RegistrationErrorState(
                    code: 404, msg: AppTxt.errorLoginOrPass));
              } else {
                emit(RegistrationErrorState(
                    code: 500, msg: AppTxt.errorServerResponse));
              }
            } else {
              final user = userResponse.data!.user;
              user.isFullProfile = user.name != BaseModel.NO_DATA_STR &&
                  user.phone == BaseModel.NO_DATA_STR;
              userRepository.saveUser(user);
              emit(RegistrationSuccessState(user: user));
            }
          }
        }
      } catch (e) {
        emit(
            RegistrationErrorState(code: 500, msg: AppTxt.errorServerResponse));
      }
    });

    on<RegistrationInitEvent>((event, emit) async {
      emit(RegistrationInitState());
    });
  }
}
