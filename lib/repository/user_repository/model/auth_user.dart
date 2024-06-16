import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String login;
  final String password;

  const AuthUser({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        login: json["login"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "password": password,
      };
}
