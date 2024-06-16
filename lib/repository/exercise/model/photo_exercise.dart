import 'package:equatable/equatable.dart';

class PhotoExercise extends Equatable {
  int exerciseId;
  String url;
  int number;

  PhotoExercise({
    required this.exerciseId,
    required this.url,
    required this.number,
  });

  factory PhotoExercise.fromJson(Map<String, dynamic> json) =>
      PhotoExercise(
        exerciseId: json["exercise_id"],
        url: json["url"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "exercise_id": exerciseId,
        "url": url,
        "number": number,
      };

  @override
  List<Object> get props => [];
}
