import 'dart:convert';

import 'package:equatable/equatable.dart';

class SaveUserInfo extends Equatable {
  static const int CLIENT_ROLE = 0;
  static const int TRAINER_ROLE = 1;

  final String token;
  final int role;
  final bool isFullUserProfile;

  const SaveUserInfo(
      {required this.token,
      required this.role,
      required this.isFullUserProfile});

  @override
  List<Object> get props => [token, role, isFullUserProfile];

  factory SaveUserInfo.fromJson(Map<String, dynamic> json) => SaveUserInfo(
        token: json["token"],
        role: json["role"],
        isFullUserProfile: json["isFullUserProfile"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "role": role,
        "isFullUserProfile": isFullUserProfile,
      };

  static String serialize(SaveUserInfo model) => json.encode(model.toJson());

  static SaveUserInfo deserialize(String json) =>
      SaveUserInfo.fromJson(jsonDecode(json));

  @override
  String toString() {
    return 'SaveUserInfo{token: $token, role: $role, isFullUserProfile: $isFullUserProfile}';
  }
}
