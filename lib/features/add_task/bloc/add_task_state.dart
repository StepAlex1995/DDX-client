part of 'add_task_bloc.dart';

abstract class AddTaskState {}

final class AddTaskInit extends AddTaskState {}

final class AddTaskUploading extends AddTaskInit {}

final class AddTaskUploaded extends AddTaskInit {}

final class AddTaskFailure extends AddTaskInit {
  final int code;
  final String msg;

  AddTaskFailure({required this.code, required this.msg});
}
