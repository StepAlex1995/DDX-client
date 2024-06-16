import 'exercise.dart';

class ExerciseListResponse {
  List<Exercise> exercises;

  ExerciseListResponse({
    required this.exercises,
  });

  factory ExerciseListResponse.fromJson(Map<String, dynamic> json) => ExerciseListResponse(
    exercises: List<Exercise>.from(json["exercises"].map((x) => Exercise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'ExerciseListResponse{exercises: $exercises}';
  }
}


