part of 'exercise_bloc.dart';

abstract class ExerciseEvent extends Equatable {}

class UploadExerciseEvent extends ExerciseEvent {
  final User user;
  final AddExerciseRequest exerciseRequest;

  UploadExerciseEvent({required this.user, required this.exerciseRequest});

  @override
  List<Object> get props => [user, exerciseRequest];
}

class CopyExerciseEvent extends ExerciseEvent {
  final User user;
  final AddExerciseRequest exerciseRequest;
  final int oldExerciseId;

  CopyExerciseEvent(
      {required this.user,
      required this.exerciseRequest,
      required this.oldExerciseId});

  @override
  List<Object> get props => [user, exerciseRequest, oldExerciseId];
}

class ExerciseInitEvent extends ExerciseEvent {
  @override
  List<Object> get props => [];
}
