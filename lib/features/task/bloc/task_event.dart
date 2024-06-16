part of 'task_bloc.dart';

abstract class TaskEvent {}

class SendFeedbackTask extends TaskEvent {
  final User user;
  final UpdateTaskRequest updateTaskRequest;
  final int taskId;

  SendFeedbackTask(
      {required this.user,
      required this.updateTaskRequest,
      required this.taskId});
}


class TaskInitEvent extends TaskEvent {}


class SendFeedbackWithParamsTask extends TaskEvent {
  final User user;
  final UpdateTaskRequest updateTaskRequest;
  final int taskId;

  SendFeedbackWithParamsTask(
      {required this.user,
        required this.updateTaskRequest,
        required this.taskId});
}