import 'feedback_param.dart';

class UpdateTaskRequest {
  String fileFeedbackUrl;
  int feedbackClient;
  int feedbackTrainer;
  int state;
  List<FeedbackParam>? params;

  UpdateTaskRequest(
      {required this.feedbackClient,
      required this.feedbackTrainer,
      required this.state,
      required this.fileFeedbackUrl,
      this.params});

  factory UpdateTaskRequest.fromJson(Map<String, dynamic> json) =>
      UpdateTaskRequest(
        fileFeedbackUrl: json["file_feedback_url"],
        feedbackClient: json["feedback_client"],
        feedbackTrainer: json["feedback_trainer"],
        state: json["state"],
        params: json["params"] == null
            ? []
            : List<FeedbackParam>.from(
                json["params"]!.map((x) => FeedbackParam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "file_feedback_url": fileFeedbackUrl,
        "feedback_client": feedbackClient,
        "feedback_trainer": feedbackTrainer,
        "state": state,
        "params": params == null
            ? []
            : List<dynamic>.from(params!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'UpdateTaskRequest{fileFeedbackUrl: $fileFeedbackUrl, feedbackClient: $feedbackClient, feedbackTrainer: $feedbackTrainer, state: $state, params: $params}';
  }
}
