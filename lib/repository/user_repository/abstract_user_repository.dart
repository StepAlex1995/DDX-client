import 'package:ddx_trainer/repository/abstract_app_repository.dart';
import 'package:ddx_trainer/repository/user_repository/model/app_response_model.dart';
import 'package:ddx_trainer/repository/user_repository/model/reg_response.dart';
import 'package:ddx_trainer/repository/user_repository/model/update_user_response_mode.dart';
import 'package:ddx_trainer/repository/user_repository/model/user_response.dart';
import 'package:ddx_trainer/repository/user_repository/model/auth_user.dart';
import 'package:ddx_trainer/repository/user_repository/model/reg_user.dart';

import 'model/update_user_request_model.dart';

abstract class AbstractUserRepository extends AbstractAppRepository {
  AbstractUserRepository({required super.dio});

  Future<User?> getSavedUser();

  saveUser(User usr);

  Future<AppResponseModel<AuthUserResponse>> signIn(AuthUser authUser);

  Future<AppResponseModel<RegUserResponse>> signUp(RegUser regUser);

  Future<AppResponseModel<UpdateUserResponseModel>> editProfile(
      User user, UpdateUserRequestModel updateUserModel);

  logout();
}
