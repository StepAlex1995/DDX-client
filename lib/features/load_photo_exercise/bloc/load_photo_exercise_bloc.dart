import 'package:ddx_trainer/repository/exercise/model/load_photo_exercise_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/exercise/abstract_exercise_repository.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'load_photo_exercise_event.dart';

part 'load_photo_exercise_state.dart';

class LoadPhotoExerciseBloc
    extends Bloc<LoadPhotoExerciseEvent, LoadPhotoExerciseState> {
  final AbstractExerciseRepository exerciseRepository;

  LoadPhotoExerciseBloc(this.exerciseRepository)
      : super(LoadPhotoExerciseInit()) {
    on<LoadPhotoExerciseUploadInitEvent>((event, emit) async {
      emit(LoadPhotoExerciseUploading());
      try {
        final loadedPhotoResponse = await exerciseRepository
            .uploadPhotoExercise(event.user, event.requestData);
        if (loadedPhotoResponse.code != 200) {
          if (loadedPhotoResponse.code == 401) {
            emit(LoadPhotoExerciseFailure(
                code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(LoadPhotoExerciseFailure(
                code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          emit(LoadPhotoExerciseUploaded());
        }
      } catch (e) {
        emit(LoadPhotoExerciseFailure(
            code: 500, msg: AppTxt.errorInputDataIsEmpty));
      }
    });

    on<LoadPhotoExerciseInitEvent>((event, emit) {
      emit(LoadPhotoExerciseInit());
    });
  }
}
