import 'package:bloc/bloc.dart';
import 'package:ddx_trainer/repository/exercise/model/load_photo_exercise_request.dart';
import 'package:equatable/equatable.dart';

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
        print("2");
        final loadedPhotoResponse = await exerciseRepository
            .uploadPhotoExercise(event.user, event.requestData);
        print("3 = "+loadedPhotoResponse.code.toString());
        if (loadedPhotoResponse.code != 200) {
          print("4");
          if (loadedPhotoResponse.code == 401) {
            print("5");
            emit(LoadPhotoExerciseFailure(
                code: 401, msg: AppTxt.errorTokenFailed));
            print("6");
          } else {
            print("7");
            emit(LoadPhotoExerciseFailure(
                code: 500, msg: AppTxt.errorServerResponse));
            print("8");
          }
        } else {
          print("9");
          emit(LoadPhotoExerciseUploaded());
        }
      } catch (e) {
        print("10 = "+e.toString());
        emit(LoadPhotoExerciseFailure(
            code: 500, msg: AppTxt.errorInputDataIsEmpty));
      }
    });

    on<LoadPhotoExerciseInitEvent>((event, emit) {
      emit(LoadPhotoExerciseInit());
    });
  }
}
