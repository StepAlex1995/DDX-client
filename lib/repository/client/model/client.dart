class Client {
  int id;
  String name;
  bool isMan;
  String phone;
  DateTime birthDate;

  Client({
    required this.id,
    required this.name,
    required this.isMan,
    required this.phone,
    required this.birthDate,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    name: json["name"],
    isMan: json["is_man"],
    phone: json["phone"],
    birthDate: DateTime.parse(json["birth_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_man": isMan,
    "phone": phone,
    "birth_date": birthDate.toIso8601String(),
  };

  @override
  String toString() {
    return 'Client{id: $id, name: $name, isMan: $isMan, phone: $phone, birthDate: $birthDate}';
  }
}
