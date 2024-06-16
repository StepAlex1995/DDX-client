class TaskParamResponse {
  int id;
  int taskId;
  String paramName;
  int target;
  int value;

  TaskParamResponse({
    required this.id,
    required this.taskId,
    required this.paramName,
    required this.target,
    required this.value,
  });

  factory TaskParamResponse.fromJson(Map<String, dynamic> json) =>
      TaskParamResponse(
        id: json["id"],
        taskId: json["task_id"],
        paramName: json["param_name"],
        target: json["target"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_id": taskId,
        "param_name": paramName,
        "target": target,
        "value": value,
      };

  @override
  String toString() {
    return 'TaskParamResponse{id: $id, taskId: $taskId, paramName: $paramName, target: $target, value: $value}';
  }
}
