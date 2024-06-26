import 'dart:io';

import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:ddx_trainer/repository/exercise/abstract_exercise_repository.dart';
import 'package:ddx_trainer/repository/exercise/model/add_exercise_request.dart';
import 'package:ddx_trainer/repository/exercise/model/add_exercise_response.dart';
import 'package:ddx_trainer/repository/exercise/model/exercise_list_response.dart';
import 'package:ddx_trainer/repository/exercise/model/load_feedback_file_request.dart';
import 'package:ddx_trainer/repository/exercise/model/load_feedback_file_response.dart';
import 'package:ddx_trainer/repository/exercise/model/load_photo_exercise_request.dart';
import 'package:ddx_trainer/repository/model/simple_response.dart';
import 'package:ddx_trainer/repository/user_repository/model/app_response_model.dart';
import 'package:ddx_trainer/repository/user_repository/model/user_response.dart';
import 'package:dio/dio.dart';

import '../../config.dart';

class ExerciseRepository extends AbstractExerciseRepository {
  ExerciseRepository({required super.dio});

  @override
  Future<AppResponseModel<ExerciseListResponse>> loadExerciseList(
      User user, bool isPublicList) async {
    String privateExerciseList = isPublicList ? '' : 'private/';
    final response = await dio.get(
      '${Config.server}/api/exercise/$privateExerciseList',
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );
    if (response.statusCode == 200) {
      ExerciseListResponse? data;
      try {
        data = ExerciseListResponse.fromJson(response.data);
      } catch (e) {
        data = null;
      }
      return AppResponseModel(
        code: response.statusCode ?? 500,
        data: data ?? ExerciseListResponse(exercises: []),
      );
    } else {
      return AppResponseModel(code: response.statusCode ?? 500);
    }
  }

  @override
  Future<AppResponseModel<AddExerciseResponse>> uploadNewExercise(
      User user, AddExerciseRequest newExercise) async {
    final response = await dio.post(
      '${Config.server}/api/exercise/',
      data: newExercise.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );

    if (response.statusCode == 200) {
      AddExerciseResponse data = AddExerciseResponse.fromJson(response.data);
      return AppResponseModel(code: response.statusCode ?? 200, data: data);
    } else {
      return AppResponseModel(code: 500);
    }
  }

  @override
  Future<AppResponseModel<SimpleResponse>> uploadPhotoExercise(
      User user, LoadPhotoExerciseRequest photoExercise) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(photoExercise.file.path,
          filename: photoExercise.file.name),
      'exercise_id': photoExercise.exerciseId,
      'number': photoExercise.number
    });

    Response response = await dio.post('${Config.server}/api/file/exercise',
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 600;
          },
          headers: getHeaderWithTokenForFileLoader(user.token),
        ));
    if (response.statusCode == 200) {
      return AppResponseModel(code: 200);
    } else {
      return AppResponseModel(code: 500);
    }
  }

  @override
  Future<AppResponseModel<AddExerciseResponse>> copyNewExercise(
      User user, int oldExerciseId, AddExerciseRequest newExercise) async {
    final response = await dio.post(
      '${Config.server}/api/exercise/$oldExerciseId',
      data: newExercise.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );

    if (response.statusCode == 200) {
      AddExerciseResponse data = AddExerciseResponse.fromJson(response.data);
      return AppResponseModel(code: response.statusCode ?? 200, data: data);
    } else {
      return AppResponseModel(code: 500);
    }
  }

  @override
  Future<AppResponseModel<LoadFeedbackFileResponse>> uploadFeedbackFileExercise(
      User user, LoadFeedbackFileRequest feedback) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(feedback.file.path,
          filename: feedback.file.name),
      'task_id': feedback.taskId,
    });

    Response response = await dio.post('${Config.server}/api/file/task',
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 600;
          },
          headers: getHeaderWithTokenForFileLoader(user.token),
        ));
    if (response.statusCode == 200 && response.data != null) {
      LoadFeedbackFileResponse data =
          LoadFeedbackFileResponse.fromJson(response.data);
      return AppResponseModel(code: 200, data: data);
    } else {
      return AppResponseModel(code: 500);
    }
  }

  @override
  Future<AppResponseModel<LoadFeedbackFileResponse>>
      uploadFeedbackVideoFileExercise(
          User user, LoadFeedbackFileRequest feedback) async {
   final file = File(feedback.file.path);

    var path = file.path;
    String fileName = path.split('/').last;
    String url = '${Config.server}/api/file/task/video/${feedback.taskId}';
    ChunkedUploader chunkedUploader = ChunkedUploader(
      Dio(
        BaseOptions(
          baseUrl: url,
          headers: {
            'Authorization': 'bearer ${user.token}',
            'Content-Type': 'multipart/form-data',
            'Connection': 'Keep-Alive',
          },
        ),
      ),
    );
    Response? response;
    try {
      response = await chunkedUploader.upload(
        fileKey: "file",
        method: "POST",
        maxChunkSize: 5000000000,
        path: url,
        onUploadProgress: (v) {},
        fileDataStream: file.openRead(),
        fileName: fileName,
        fileSize: file.lengthSync(),
      );
    } catch (e) {
      return AppResponseModel(code: 500);
    }
    if (response != null &&
        response.statusCode == 200 &&
        response.data != null) {
      LoadFeedbackFileResponse data =
          LoadFeedbackFileResponse.fromJson(response.data);
      return AppResponseModel(code: 200, data: data);
    } else {
      return AppResponseModel(code: 500);
    }
  }
}
