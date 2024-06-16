import 'package:equatable/equatable.dart';

class RegUser extends Equatable {
  final String login;
  final String password;
  final String passwordRepeat;

  const RegUser(
      {required this.login,
      required this.password,
      required this.passwordRepeat});

  @override
  List<Object> get props => [login, password, passwordRepeat];

  factory RegUser.fromJson(Map<String, dynamic> json) => RegUser(
    login: json["login"],
    password: json["password"],
    passwordRepeat: json["passwordRepeat"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "password": password,
    "passwordRepeat": passwordRepeat,
  };
}
