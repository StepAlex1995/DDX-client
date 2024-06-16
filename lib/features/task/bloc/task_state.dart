part of 'task_bloc.dart';

abstract class TaskState {}

final class TaskInit extends TaskState {}

final class TaskFeedbackTrainerSending extends TaskState {}

final class TaskFeedbackTrainerSend extends TaskState {}

final class TaskFeedbackTrainerFailure extends TaskState {
  final int code;
  final String msg;

  TaskFeedbackTrainerFailure({required this.code, required this.msg});
}

final class TaskFeedbackParamsSending extends TaskState {}

final class TaskFeedbackParamsSend extends TaskState {}

final class TaskFeedbackParamsFailure extends TaskState {
  final int code;
  final String msg;

  TaskFeedbackParamsFailure({required this.code, required this.msg});
}
