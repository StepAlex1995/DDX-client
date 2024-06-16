import 'package:equatable/equatable.dart';

class TaskParamRequest extends Equatable {
  String paramName;
  int target;
  int value;

  TaskParamRequest({
    required this.paramName,
    required this.target,
    required this.value,
  });

  factory TaskParamRequest.fromJson(Map<String, dynamic> json) => TaskParamRequest(
        paramName: json["param_name"],
        target: json["target"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "param_name": paramName,
        "target": target,
        "value": value,
      };

  @override
  List<Object> get props => [paramName, target, value];

  @override
  String toString() {
    return 'TaskParam{paramName: $paramName, target: $target, value: $value}';
  }
}
