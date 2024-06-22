import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/exercise/abstract_exercise_repository.dart';
import '../../../repository/exercise/model/exercise.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'exercise_list_event.dart';

part 'exercise_list_state.dart';

class ExerciseListBloc extends Bloc<ExerciseListEvent, ExerciseListState> {
  final AbstractExerciseRepository exerciseRepository;

  ExerciseListBloc(this.exerciseRepository) : super(ExerciseListInit()) {
    on<LoadExerciseListEvent>((event, emit) async {
      try {
        emit(ExerciseListLoading());

        final exerciseListResponse = await exerciseRepository.loadExerciseList(
            event.user, event.isPublicExerciseList);

        if (exerciseListResponse.code != 200) {
          if (exerciseListResponse.code == 401) {
            emit(ExerciseListFailure(code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(ExerciseListFailure(
                code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          if (exerciseListResponse.data!.exercises.isEmpty) {
            emit(ExerciseListFailure(code: 200, msg: AppTxt.errorListIsEmpty));
          } else {
            if (event.isPublicExerciseList) {
              emit(ExerciseListLoaded(
                  exerciseList: exerciseListResponse.data!.exercises));
            } else {
              emit(ExerciseListLoaded(
                  exerciseList:
                      exerciseListResponse.data!.exercises.reversed.toList()));
            }
          }
        }
      } catch (e) {
        emit(ExerciseListFailure(code: 500, msg: AppTxt.errorServerResponse));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
