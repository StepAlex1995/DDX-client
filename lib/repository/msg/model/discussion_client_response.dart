import 'package:ddx_trainer/repository/client/model/client.dart';
import 'package:ddx_trainer/repository/task/model/task_model.dart';

class DiscussionResponse {
  List<Discussion> discussion;

  DiscussionResponse({
    required this.discussion,
  });

  factory DiscussionResponse.fromJson(Map<String, dynamic> json) => DiscussionResponse(
    discussion: List<Discussion>.from(json["discussion"].map((x) => Discussion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "discussion": List<dynamic>.from(discussion.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'DiscussionClientResponse{discussion: $discussion}';
  }
}

class Discussion {
  int taskId;
  TaskModel task;
  Client client;
  DateTime taskDate;

  Discussion({
    required this.taskId,
    required this.task,
    required this.client,
    required this.taskDate,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
    taskId: json["task_id"],
    task: TaskModel.fromJson(json["task"]),
    client: Client.fromJson(json["client"]),
    taskDate: DateTime.parse(json["task_date"]),
  );

  Map<String, dynamic> toJson() => {
    "task_id": taskId,
    "task": task.toJson(),
    "client": client.toJson(),
    "task_date": taskDate.toIso8601String(),
  };

  @override
  String toString() {
    return 'DiscussionClient{taskId: $taskId, task: $task, client: $client, taskDate: $taskDate}';
  }
}
