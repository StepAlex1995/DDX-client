import 'dart:convert';

import 'package:ddx_trainer/repository/client/model/client.dart';
import 'package:intl/intl.dart';

import 'base_model.dart';

class AuthUserResponse {
  User user;

  AuthUserResponse({
    required this.user,
  });

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) =>
      AuthUserResponse(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };

  static String serialize(AuthUserResponse model) =>
      json.encode(model.toJson());

  static AuthUserResponse deserialize(String json) =>
      AuthUserResponse.fromJson(jsonDecode(json));
}

class User extends BaseModel {
  static const int CLIENT_ROLE = 0;
  static const int TRAINER_ROLE = 1;

  String login;
  int role;
  int clientId;
  int selfTrainerId;
  String name;
  bool isMan;
  String phone;
  String birthDate;
  int trainerId;
  String photoUrl;
  String token;
  bool? isFullProfile;

  static User createClear() {
    return User(
        login: BaseModel.NO_DATA_STR,
        role: BaseModel.NO_DATA_INT,
        clientId: BaseModel.NO_DATA_INT,
        selfTrainerId: BaseModel.NO_DATA_INT,
        name: BaseModel.NO_DATA_STR,
        isMan: true,
        phone: BaseModel.NO_DATA_STR,
        birthDate: BaseModel.NO_DATA_STR,
        trainerId: BaseModel.NO_DATA_INT,
        photoUrl: BaseModel.NO_DATA_STR,
        token: BaseModel.NO_DATA_STR);
  }

  User({
    required this.login,
    required this.role,
    required this.clientId,
    required this.selfTrainerId,
    required this.name,
    required this.isMan,
    required this.phone,
    required this.birthDate,
    required this.trainerId,
    required this.photoUrl,
    required this.token,
    this.isFullProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
        role: json["role"],
        clientId: json["client_id"],
        selfTrainerId: json["self_trainer_id"],
        name: json["name"],
        isMan: json["is_man"],
        phone: json["phone"],
        birthDate: json["birth_date"],
        trainerId: json["trainer_id"],
        photoUrl: json["photo_url"],
        token: json["token"],
        isFullProfile: json["is_full_profile"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "role": role,
        "client_id": clientId,
        "self_trainer_id": selfTrainerId,
        "name": name,
        "is_man": isMan,
        "phone": phone,
        "birth_date": birthDate,
        "trainer_id": trainerId,
        "photo_url": photoUrl,
        "token": token,
        "is_full_profile": isFullProfile,
      };

  static String serialize(User model) => json.encode(model.toJson());

  static User deserialize(String json) => User.fromJson(jsonDecode(json));

  @override
  String toString() {
    return 'User{login: $login, role: $role, clientId: $clientId, selfTrainerId: $selfTrainerId, name: $name, isMan: $isMan, phone: $phone, birthDate: $birthDate, trainerId: $trainerId, photoUrl: $photoUrl, token: $token, isFullProfile: $isFullProfile}';
  }

  Client convertToClient(){
    DateFormat format = DateFormat("yyy-MM-ddTHH:mm:ss");
    return Client(id: clientId, name: name, isMan: isMan, phone: phone, birthDate: format.parse(birthDate));
  }
}
