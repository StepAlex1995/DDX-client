import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/task/abstract_task_repository.dart';
import '../../../repository/task/model/update_task_request.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AbstractTaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(TaskInit()) {
    on<SendFeedbackTask>((event, emit) async {
      try {
        emit(TaskFeedbackTrainerSending());
        final updateTaskResponse = await taskRepository.updateTask(
            event.user, event.updateTaskRequest, event.taskId);
        if (updateTaskResponse.code != 200) {
          if (updateTaskResponse.code == 401) {
            emit(TaskFeedbackTrainerFailure(
                code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(TaskFeedbackTrainerFailure(
                code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          emit(TaskFeedbackTrainerSend());
        }
      } catch (e) {
        emit(TaskFeedbackTrainerFailure(
            code: 500, msg: AppTxt.errorServerResponse));
      }
    });
    on<TaskInitEvent>((event, emit) async {
      emit(TaskInit());
    });

    on<SendFeedbackWithParamsTask>((event, emit) async {
      try {
        emit(TaskFeedbackParamsSending());
        final updateTaskResponse = await taskRepository.updateTask(
            event.user, event.updateTaskRequest, event.taskId);
        if (updateTaskResponse.code != 200) {
          if (updateTaskResponse.code == 401) {
            emit(TaskFeedbackParamsFailure(
                code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(TaskFeedbackParamsFailure(
                code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          emit(TaskFeedbackParamsSend());
        }
      } catch (e) {
        emit(TaskFeedbackParamsFailure(
            code: 500, msg: AppTxt.errorServerResponse));
      }
    });
  }
}
