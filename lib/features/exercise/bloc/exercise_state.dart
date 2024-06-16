part of 'exercise_bloc.dart';

abstract class ExerciseState extends Equatable {}

final class ExerciseInit extends ExerciseState {
  @override
  List<Object> get props => [];
}

final class ExerciseUploading extends ExerciseState {
  @override
  List<Object> get props => [];
}

final class ExerciseUploaded extends ExerciseState {
  final int exerciseId;

  ExerciseUploaded({required this.exerciseId});

  @override
  List<Object> get props => [exerciseId];
}

final class ExerciseFailure extends ExerciseState {
  final int code;
  final String msg;

  ExerciseFailure({required this.code, required this.msg});

  @override
  List<Object> get props => [code, msg];
}
