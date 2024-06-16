import 'client.dart';

class ClientListResponse {
  List<Client> clientList;

  ClientListResponse({
    required this.clientList,
  });

  factory ClientListResponse.fromJson(Map<String, dynamic> json) => ClientListResponse(
    clientList: List<Client>.from(json["clientList"].map((x) => Client.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "clientList": List<dynamic>.from(clientList.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'ClientListResponse{clientList: $clientList}';
  }
}
