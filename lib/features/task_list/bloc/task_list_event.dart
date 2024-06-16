part of 'task_list_bloc.dart';

abstract class TaskListEvent {}

class LoadTaskListEvent extends TaskListEvent {
  final User user;
  final TaskListRequest taskListRequest;

  LoadTaskListEvent({required this.user, required this.taskListRequest});
}
