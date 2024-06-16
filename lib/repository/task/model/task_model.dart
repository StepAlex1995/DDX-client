import 'package:ddx_trainer/repository/exercise/model/exercise.dart';
import 'package:ddx_trainer/repository/task/model/task_param_response.dart';
import 'package:ddx_trainer/text/text.dart';

class TaskModel {
  int id;
  DateTime date;
  int trainerId;
  int clientId;
  Exercise exercise;
  String fileFeedbackUrl;
  int feedbackClient;
  int feedbackTrainer;
  String description;
  int state;
  List<TaskParamResponse>? params;

  static const String PARAM_WEIGHT = AppTxt.weight;
  static const String PARAM_TIME_MIN = AppTxt.timeMin;
  static const String PARAM_TIME_MAX = AppTxt.timeMax;
  static const String PARAM_SET_COUNT = AppTxt.setCount;
  static const String PARAM_REPEAT_COUNT = AppTxt.repeatCount;

  TaskParamResponse? getParamByName(String paramName) {
    if (params == null) {
      return null;
    }
    for (int i = 0; i < params!.length; i++) {
      if (params![i].paramName == paramName) {
        return params![i];
      }
    }
    return null;
  }

  TaskModel({
    required this.id,
    required this.date,
    required this.trainerId,
    required this.clientId,
    required this.exercise,
    required this.fileFeedbackUrl,
    required this.feedbackClient,
    required this.feedbackTrainer,
    required this.description,
    required this.state,
    required this.params,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        trainerId: json["trainer_id"],
        clientId: json["client_id"],
        exercise: Exercise.fromJson(json["exercise"]),
        fileFeedbackUrl: json["file_feedback_url"],
        feedbackClient: json["feedback_client"],
        feedbackTrainer: json["feedback_trainer"],
        description: json["description"],
        state: json["state"],
        params: json["params"] == null
            ? []
            : List<TaskParamResponse>.from(
                json["params"]!.map((x) => TaskParamResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "trainer_id": trainerId,
        "client_id": clientId,
        "exercise": exercise.toJson(),
        "file_feedback_url": fileFeedbackUrl,
        "feedback_client": feedbackClient,
        "feedback_trainer": feedbackTrainer,
        "description": description,
        "state": state,
        "params": params == null
            ? []
            : List<dynamic>.from(params!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'TaskModel{id: $id, date: $date, trainerId: $trainerId, clientId: $clientId, exercise: $exercise, fileFeedbackUrl: $fileFeedbackUrl, feedbackClient: $feedbackClient, feedbackTrainer: $feedbackTrainer, description: $description, state: $state, params: $params}';
  }
}
