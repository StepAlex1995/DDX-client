import 'package:ddx_trainer/repository/task/model/task_param_request.dart';
import 'package:equatable/equatable.dart';

class CreateTaskRequest extends Equatable {
  int date;
  int clientId;
  int exerciseId;
  String description;
  int state;
  List<TaskParamRequest> params;

  CreateTaskRequest({
    required this.date,
    required this.clientId,
    required this.exerciseId,
    required this.description,
    required this.state,
    required this.params,
  });

  factory CreateTaskRequest.fromJson(Map<String, dynamic> json) =>
      CreateTaskRequest(
        date: json["date"],
        clientId: json["client_id"],
        exerciseId: json["exercise_id"],
        description: json["description"],
        state: json["state"],
        params: List<TaskParamRequest>.from(
            json["params"].map((x) => TaskParamRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "client_id": clientId,
        "exercise_id": exerciseId,
        "description": description,
        "state": state,
        "params": List<dynamic>.from(params.map((x) => x.toJson())),
      };

  @override
  List<Object> get props =>
      [date, clientId, exerciseId, description, state, params];

  @override
  String toString() {
    return 'CreateTaskRequest{date: $date, clientId: $clientId, exerciseId: $exerciseId, description: $description, state: $state, params: $params}';
  }
}
