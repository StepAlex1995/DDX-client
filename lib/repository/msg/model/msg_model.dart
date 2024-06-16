class MsgModel {
  int id;
  int taskId;
  int trainerId;
  int clientId;
  String text;
  DateTime date;
  bool isSendClient;

  MsgModel({
    required this.id,
    required this.taskId,
    required this.trainerId,
    required this.clientId,
    required this.text,
    required this.date,
    required this.isSendClient,
  });

  factory MsgModel.fromJson(Map<String, dynamic> json) => MsgModel(
        id: json["id"],
        taskId: json["task_id"],
        trainerId: json["trainer_id"],
        clientId: json["client_id"],
        text: json["text"],
        date: DateTime.parse(json["date"]),
        isSendClient: json["is_send_client"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_id": taskId,
        "trainer_id": trainerId,
        "client_id": clientId,
        "text": text,
        "date": date.toIso8601String(),
        "is_send_client": isSendClient,
      };

  @override
  String toString() {
    return 'MsgModel{id: $id, taskId: $taskId, trainerId: $trainerId, clientId: $clientId, text: $text, date: $date, isSendClient: $isSendClient}';
  }
}
