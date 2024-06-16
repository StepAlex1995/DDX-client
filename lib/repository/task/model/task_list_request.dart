class TaskListRequest {
  int date;
  int clientId;

  TaskListRequest({
    required this.date,
    required this.clientId,
  });

  factory TaskListRequest.fromJson(Map<String, dynamic> json) =>
      TaskListRequest(
        date: json["date"],
        clientId: json["client_id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "client_id": clientId,
      };

  @override
  String toString() {
    return 'TaskListRequest{date: $date, clientId: $clientId}';
  }
}
