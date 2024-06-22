class UpdateUserResponseModel {
  ClientUpdated? clientUpdated;

  UpdateUserResponseModel({this.clientUpdated});

  UpdateUserResponseModel.fromJson(Map<String, dynamic> json) {
    clientUpdated = json['clientUpdated'] != null
        ? ClientUpdated.fromJson(json['clientUpdated'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (clientUpdated != null) {
      data['clientUpdated'] = clientUpdated!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'UpdateUserResponseModel{clientUpdated: $clientUpdated}';
  }
}

class ClientUpdated {
  int? id;
  String? name;
  bool? isMan;
  String? phone;
  String? birthDate;
  int? trainerId;

  ClientUpdated(
      {this.id,
      this.name,
      this.isMan,
      this.phone,
      this.birthDate,
      this.trainerId});

  ClientUpdated.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isMan = json['is_man'];
    phone = json['phone'];
    birthDate = json['birth_date'];
    trainerId = json['trainer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['is_man'] = isMan;
    data['phone'] = phone;
    data['birth_date'] = birthDate;
    data['trainer_id'] = trainerId;
    return data;
  }

  @override
  String toString() {
    return 'ClientUpdated{id: $id, name: $name, isMan: $isMan, phone: $phone, birthDate: $birthDate, trainerId: $trainerId}';
  }
}
