import 'package:ddx_trainer/repository/abstract_app_repository.dart';
import 'package:ddx_trainer/repository/exercise/model/add_exercise_request.dart';
import 'package:ddx_trainer/repository/exercise/model/add_exercise_response.dart';
import 'package:ddx_trainer/repository/exercise/model/exercise_list_response.dart';
import 'package:ddx_trainer/repository/exercise/model/load_feedback_file_request.dart';
import 'package:ddx_trainer/repository/exercise/model/load_photo_exercise_request.dart';
import 'package:ddx_trainer/repository/model/simple_response.dart';

import '../user_repository/model/app_response_model.dart';
import '../user_repository/model/user_response.dart';
import 'model/load_feedback_file_response.dart';

abstract class AbstractExerciseRepository extends AbstractAppRepository {
  AbstractExerciseRepository({required super.dio});

  Future<AppResponseModel<ExerciseListResponse>> loadExerciseList(
      User user, bool isPublicList);

  Future<AppResponseModel<AddExerciseResponse>> uploadNewExercise(
      User user, AddExerciseRequest newExercise);

  Future<AppResponseModel<AddExerciseResponse>> copyNewExercise(
      User user, int oldExerciseId, AddExerciseRequest newExercise);

  Future<AppResponseModel<SimpleResponse>> uploadPhotoExercise(
      User user, LoadPhotoExerciseRequest photoExercise);

  Future<AppResponseModel<LoadFeedbackFileResponse>> uploadFeedbackFileExercise(
      User user, LoadFeedbackFileRequest feedback);
}
