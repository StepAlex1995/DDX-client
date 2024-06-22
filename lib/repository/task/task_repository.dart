import 'package:ddx_trainer/repository/model/simple_response.dart';
import 'package:ddx_trainer/repository/task/abstract_task_repository.dart';
import 'package:ddx_trainer/repository/task/model/create_task_request.dart';
import 'package:ddx_trainer/repository/task/model/task_list_request.dart';
import 'package:ddx_trainer/repository/task/model/task_list_response.dart';
import 'package:ddx_trainer/repository/task/model/update_task_request.dart';
import 'package:ddx_trainer/repository/user_repository/model/app_response_model.dart';
import 'package:ddx_trainer/repository/user_repository/model/user_response.dart';
import 'package:dio/dio.dart';

import '../../config.dart';

class TaskRepository extends AbstractTaskRepository {
  TaskRepository({required super.dio});

  @override
  Future<AppResponseModel<SimpleResponse>> createNewTask(
      User user, CreateTaskRequest taskRequest) async {
    final response = await dio.post(
      '${Config.server}/api/task/',
      data: taskRequest.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );
    if (response.statusCode == 200) {
      return AppResponseModel(code: 200);
    } else {
      return AppResponseModel(code: 500);
    }
  }

  @override
  Future<AppResponseModel<TaskListResponse>> getTaskListByDate(
      User user, TaskListRequest taskRequest) async {
    final response = await dio.get(
      '${Config.server}/api/task/',
      data: taskRequest.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );
    if (response.statusCode == 200) {
      TaskListResponse? data;
      try {
        data = TaskListResponse.fromJson(response.data);
      } catch (e) {
        data = null;
      }
      return AppResponseModel(
        code: response.statusCode ?? 500,
        data: data ?? TaskListResponse(tasks: []),
      );
    } else {
      return AppResponseModel(code: response.statusCode ?? 500);
    }
  }

  @override
  Future<AppResponseModel<SimpleResponse>> updateTask(
      User user, UpdateTaskRequest updateTaskRequest, int taskId) async {
    final response = await dio.put(
      '${Config.server}/api/task/$taskId',
      data: updateTaskRequest.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );
    return AppResponseModel(code: response.statusCode ?? 500);
  }
}
