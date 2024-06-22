import 'package:ddx_trainer/repository/task/model/create_task_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/task/abstract_task_repository.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'add_task_event.dart';

part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AbstractTaskRepository taskRepository;

  AddTaskBloc(this.taskRepository) : super(AddTaskInit()) {
    on<AddTaskUploadEvent>((event, emit) async {
      try {
        emit(AddTaskUploading());
        final addTaskResponse = await taskRepository.createNewTask(
            event.user, event.createTaskRequest);
        if (addTaskResponse.code != 200) {
          if (addTaskResponse.code == 401) {
            emit(AddTaskFailure(code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(AddTaskFailure(code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          emit(AddTaskUploaded());
        }
      } catch (e) {
        emit(AddTaskFailure(code: 500, msg: AppTxt.errorServerResponse));
      }
    });

    on<AddTaskInitEvent>((event, emit) {
      emit(AddTaskInit());
    });
  }
}
