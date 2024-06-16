part of 'task_list_bloc.dart';

abstract class TaskListState {}

final class TaskListInit extends TaskListState {}

final class TaskListLoading extends TaskListState {}

final class TaskListLoaded extends TaskListState {
  final List<TaskModel> taskList;

  TaskListLoaded({required this.taskList});
}

final class TaskListFailure extends TaskListState {
  final int code;
  final String msg;

  TaskListFailure({required this.code, required this.msg});
}
