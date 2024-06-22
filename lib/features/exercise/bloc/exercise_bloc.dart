import 'package:ddx_trainer/repository/exercise/model/add_exercise_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/exercise/abstract_exercise_repository.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'exercise_event.dart';

part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final AbstractExerciseRepository exerciseRepository;

  ExerciseBloc(this.exerciseRepository) : super(ExerciseInit()) {
    on<UploadExerciseEvent>((event, emit) async {
      try {
        if (event.exerciseRequest.title.isEmpty ||
            event.exerciseRequest.description.isEmpty ||
            event.exerciseRequest.muscle == AppTxt.emptyDataDropdown ||
            event.exerciseRequest.type == AppTxt.emptyDataDropdown ||
            event.exerciseRequest.equipment == AppTxt.emptyDataDropdown ||
            event.exerciseRequest.difficulty < 0) {
          emit(ExerciseFailure(code: 400, msg: AppTxt.errorInputDataIsEmpty));
        } else {
          emit(ExerciseUploading());
          final addExerciseResponse = await exerciseRepository
              .uploadNewExercise(event.user, event.exerciseRequest);

          if (addExerciseResponse.code != 200 ||
              addExerciseResponse.data == null) {
            if (addExerciseResponse.code == 401) {
              emit(ExerciseFailure(code: 401, msg: AppTxt.errorTokenFailed));
            } else {
              emit(ExerciseFailure(code: 500, msg: AppTxt.errorServerResponse));
            }
          } else {
            if (addExerciseResponse.data!.id > 0) {
              emit(ExerciseUploaded(exerciseId: addExerciseResponse.data!.id));
            } else {
              emit(ExerciseFailure(code: 500, msg: AppTxt.errorServerResponse));
            }
          }
        }
      } catch (e) {
        emit(ExerciseFailure(code: 500, msg: AppTxt.errorServerResponse));
      }
    });

    on<CopyExerciseEvent>((event, emit) async {
      try {
        if (event.exerciseRequest.title.isEmpty ||
            event.exerciseRequest.description.isEmpty ||
            event.exerciseRequest.muscle == AppTxt.emptyDataDropdown ||
            event.exerciseRequest.type == AppTxt.emptyDataDropdown ||
            event.exerciseRequest.equipment == AppTxt.emptyDataDropdown ||
            event.exerciseRequest.difficulty < 0) {
          emit(ExerciseFailure(code: 400, msg: AppTxt.errorInputDataIsEmpty));
        } else {
          emit(ExerciseUploading());
          final addExerciseResponse = await exerciseRepository.copyNewExercise(
              event.user, event.oldExerciseId, event.exerciseRequest);

          if (addExerciseResponse.code != 200 ||
              addExerciseResponse.data == null) {
            if (addExerciseResponse.code == 401) {
              emit(ExerciseFailure(code: 401, msg: AppTxt.errorTokenFailed));
            } else {
              emit(ExerciseFailure(code: 500, msg: AppTxt.errorServerResponse));
            }
          } else {
            if (addExerciseResponse.data!.id > 0) {
              emit(ExerciseUploaded(exerciseId: addExerciseResponse.data!.id));
            } else {
              emit(ExerciseFailure(code: 500, msg: AppTxt.errorServerResponse));
            }
          }
        }
      } catch (e) {
        emit(ExerciseFailure(code: 500, msg: AppTxt.errorServerResponse));
      }
    });

    on<ExerciseInitEvent>((event, emit) {
      emit(ExerciseInit());
    });
  }
}
