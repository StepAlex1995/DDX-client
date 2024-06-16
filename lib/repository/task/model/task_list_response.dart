import 'package:ddx_trainer/repository/task/model/task_model.dart';

class TaskListResponse {
  List<TaskModel> tasks;

  TaskListResponse({
    required this.tasks,
  });

  factory TaskListResponse.fromJson(Map<String, dynamic> json) =>
      TaskListResponse(
        tasks: List<TaskModel>.from(
            json["tasks"].map((x) => TaskModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'TaskListResponse{tasks: $tasks}';
  }
}
