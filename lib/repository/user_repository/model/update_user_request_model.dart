import 'package:equatable/equatable.dart';

class UpdateUserRequestModel extends Equatable {
  final String name;
  final bool isMan;
  final String phone;
  final String birthdate;

  const UpdateUserRequestModel(
      {required this.name,
      required this.isMan,
      required this.phone,
      required this.birthdate});

  @override
  List<Object> get props => [name, isMan, phone, birthdate];

  factory UpdateUserRequestModel.fromJson(Map<String, dynamic> json) => UpdateUserRequestModel(
        name: json["name"],
        isMan: json["is_man"],
        phone: json["phone"],
        birthdate: json["birth_date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "is_man": isMan,
        "phone": phone,
        "birth_date": birthdate,
      };

  @override
  String toString() {
    return 'UpdateUserModel{name: $name, isMan: $isMan, phone: $phone, birthdate: $birthdate}';
  }
}
