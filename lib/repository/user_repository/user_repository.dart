import 'package:ddx_trainer/config.dart';
import 'package:ddx_trainer/repository/user_repository/abstract_user_repository.dart';
import 'package:ddx_trainer/repository/user_repository/model/auth_user.dart';
import 'package:ddx_trainer/repository/user_repository/model/reg_response.dart';
import 'package:ddx_trainer/repository/user_repository/model/reg_user.dart';
import 'package:ddx_trainer/repository/user_repository/model/update_user_request_model.dart';
import 'package:ddx_trainer/repository/user_repository/model/update_user_response_mode.dart';
import 'package:ddx_trainer/repository/user_repository/model/user_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'model/app_response_model.dart';

class UserRepository extends AbstractUserRepository {
  String user = "user";
  String token = "userToken";
  String role = "userRole";
  String isFullUserProfile = "isFullUserProfile";

  final FlutterSecureStorage storage;

  UserRepository({required super.dio, required this.storage});


  @override
  Future<User?> getSavedUser() async {
    var storage = GetIt.I.get<FlutterSecureStorage>();
    String? savedData = await storage.read(key: user);
    if (savedData == null) {
      return null;
    }
    User? saveUserInfo = User.deserialize(savedData);
    return saveUserInfo;
  }

  @override
  saveUser(User usr) async {
    var storage = GetIt.I.get<FlutterSecureStorage>();
    await storage.write(key: user, value: User.serialize(usr));
  }

  @override
  Future<AppResponseModel<AuthUserResponse>> signIn(AuthUser authUser) async {
    final response = await dio.post(
      '${Config.server}/auth/sign-in', //'http://81.94.150.234:8080
      data: authUser.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        //headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      AuthUserResponse data = AuthUserResponse.fromJson(response.data);
      return AppResponseModel(code: response.statusCode ?? 500, data: data);
    } else {
      return AppResponseModel(code: response.statusCode ?? 500);
    }
  }

  @override
  Future<AppResponseModel<RegUserResponse>> signUp(RegUser regUser) async {
    final response = await dio.post(
      '${Config.server}/auth/sign-up',
      data: regUser.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        //headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      RegUserResponse data = RegUserResponse.fromJson(response.data);
      return AppResponseModel(code: response.statusCode ?? 500, data: data);
    } else {
      return AppResponseModel(code: response.statusCode ?? 500);
    }
  }

  @override
  logout() async {
    var storage = GetIt.I.get<FlutterSecureStorage>();
    await storage.delete(key: user);
  }

  @override
  Future<AppResponseModel<UpdateUserResponseModel>> editProfile(
      User user, UpdateUserRequestModel updateUserModel) async {
    final Map<String, dynamic> header = getHeaderWithToken(user
        .token); /*{
      'Authorization': 'bearer ${user.token}',
      "Content-Type": "application/json",
      "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE",
      "Accept": "application/json"
    };*/
    final response = await dio.put(
      '${Config.server}/api/clients/${user.clientId}',
      data: updateUserModel.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: header,
      ),
    );
    if (response.statusCode == 200) {
      UpdateUserResponseModel data =
          UpdateUserResponseModel.fromJson(response.data);
      return AppResponseModel(code: response.statusCode ?? 500, data: data);
    } else {
      return AppResponseModel(code: response.statusCode ?? 500);
    }
  }
}
