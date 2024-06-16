part of 'exercise_list_bloc.dart';

abstract class ExerciseListEvent extends Equatable {
  get completer => completer;
}

class LoadExerciseListEvent extends ExerciseListEvent {
  final Completer? completer;
  final User user;
  final bool isPublicExerciseList;

  LoadExerciseListEvent(
      {this.completer, required this.user, required this.isPublicExerciseList});

  @override
  List<Object?> get props => [completer];
}
