import 'package:bloc/bloc.dart';
import 'package:ddx_trainer/repository/user_repository/model/auth_user.dart';
import 'package:meta/meta.dart';

import '../../../repository/user_repository/abstract_user_repository.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractUserRepository userRepository;

  AuthBloc(this.userRepository) : super(AuthInitState()) {
    on<AuthUserEvent>((event, emit) async {
      try {
        if (event.authUser.login.isEmpty || event.authUser.password.isEmpty) {
          emit(AuthErrorState(code: 400, msg: AppTxt.errorLoginOrPassIsEmpty));
        } else {
          emit(AuthProgressState());
          final userResponse = await userRepository.signIn(event.authUser);
          if (userResponse.code != 200 || userResponse.data == null) {
            if (userResponse.code == 404) {
              emit(AuthErrorState(code: 404, msg: AppTxt.errorLoginOrPass));
            } else {
              emit(AuthErrorState(code: 500, msg: AppTxt.errorServerResponse));
            }
          } else {
            final user = userResponse.data!.user;
            const noData = 'no_data';
            user.isFullProfile = user.name != noData && user.phone != noData;
            userRepository.saveUser(user);
            emit(AuthSuccessState(user: user));
          }
        }
      } catch (e) {
        emit(AuthErrorState(code: 500, msg: AppTxt.errorServerResponse));
      }
    });

    on<AuthInitEvent>((event, emit) async {
      emit(AuthInitState());
    });
  }
}
