import 'package:ddx_trainer/repository/abstract_app_repository.dart';
import 'package:ddx_trainer/repository/model/simple_response.dart';
import 'package:ddx_trainer/repository/task/model/create_task_request.dart';
import 'package:ddx_trainer/repository/task/model/task_list_request.dart';
import 'package:ddx_trainer/repository/task/model/task_list_response.dart';
import 'package:ddx_trainer/repository/task/model/update_task_request.dart';

import '../user_repository/model/app_response_model.dart';
import '../user_repository/model/user_response.dart';

abstract class AbstractTaskRepository extends AbstractAppRepository {
  AbstractTaskRepository({required super.dio});

  Future<AppResponseModel<SimpleResponse>> createNewTask(
      User user, CreateTaskRequest taskRequest);

  Future<AppResponseModel<TaskListResponse>> getTaskListByDate(
      User user, TaskListRequest taskRequest);

  Future<AppResponseModel<SimpleResponse>> updateTask(
      User user, UpdateTaskRequest updateTaskRequest,int taskId);
}
