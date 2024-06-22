import 'package:ddx_trainer/repository/task/abstract_task_repository.dart';
import 'package:ddx_trainer/repository/task/model/task_list_request.dart';
import 'package:ddx_trainer/repository/task/model/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'task_list_event.dart';

part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final AbstractTaskRepository abstractTaskRepository;

  TaskListBloc(this.abstractTaskRepository) : super(TaskListInit()) {
    on<LoadTaskListEvent>((event, emit) async {
      try {
        emit(TaskListLoading());
        final taskListResponse = await abstractTaskRepository.getTaskListByDate(
            event.user, event.taskListRequest);
        if (taskListResponse.code != 200) {
          if (taskListResponse.code == 401) {
            emit(TaskListFailure(code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(TaskListFailure(code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          if (taskListResponse.data!.tasks.isEmpty) {
            emit(TaskListFailure(code: 200, msg: AppTxt.errorListIsEmpty));
          } else {
            taskListResponse.data!.tasks.sort((a, b) => a.id.compareTo(b.id));
            emit(TaskListLoaded(taskList: taskListResponse.data!.tasks));
          }
        }
      } catch (e) {
        emit(TaskListFailure(code: 500, msg: AppTxt.errorServerResponse));
      }
    });
  }
}
