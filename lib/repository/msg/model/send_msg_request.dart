class SendMsgRequest {
  int taskId;
  int trainerId;
  int clientId;
  String text;
  int date;
  bool isSendClient;

  SendMsgRequest({
    required this.taskId,
    required this.trainerId,
    required this.clientId,
    required this.text,
    required this.date,
    required this.isSendClient,
  });

  factory SendMsgRequest.fromJson(Map<String, dynamic> json) => SendMsgRequest(
        taskId: json["task_id"],
        trainerId: json["trainer_id"],
        clientId: json["client_id"],
        text: json["text"],
        date: json["date"],
        isSendClient: json["is_send_client"],
      );

  Map<String, dynamic> toJson() => {
        "task_id": taskId,
        "trainer_id": trainerId,
        "client_id": clientId,
        "text": text,
        "date": date,
        "is_send_client": isSendClient,
      };

  @override
  String toString() {
    return 'SendMsgRequest{taskId: $taskId, trainerId: $trainerId, clientId: $clientId, text: $text, date: $date, isSendClient: $isSendClient}';
  }
}
