part of 'exercise_list_bloc.dart';

abstract class ExerciseListState  {}

final class ExerciseListInit extends ExerciseListState {
  @override
  List<Object> get props => [];
}

final class ExerciseListLoading extends ExerciseListState {
  @override
  List<Object> get props => [];
}

final class ExerciseListLoaded extends ExerciseListState {
  final List<Exercise> exerciseList;

  ExerciseListLoaded({required this.exerciseList});

  @override
  List<Object> get props => [exerciseList];
}

final class ExerciseListFailure extends ExerciseListState {
  final int code;
  final String msg;

  ExerciseListFailure({required this.code, required this.msg});

  @override
  List<Object> get props => [code, msg];
}
