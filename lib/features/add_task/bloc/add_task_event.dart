part of 'add_task_bloc.dart';

abstract class AddTaskEvent {}

class AddTaskUploadEvent extends AddTaskEvent {
  final User user;
  final CreateTaskRequest createTaskRequest;

  AddTaskUploadEvent({required this.user, required this.createTaskRequest});

}

class AddTaskInitEvent extends AddTaskEvent {

}
