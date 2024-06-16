import 'package:ddx_trainer/repository/exercise/model/photo_exercise.dart';


class Exercise {
  int id;
  String title;
  String muscle;
  String type;
  String equipment;
  bool isPublic;
  String description;
  int trainerId;
  int state;
  int difficulty;
  List<PhotoExercise>? photo;

  Exercise({
    required this.id,
    required this.title,
    required this.muscle,
    required this.type,
    required this.equipment,
    required this.isPublic,
    required this.description,
    required this.trainerId,
    required this.state,
    required this.difficulty,
    required this.photo,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json["id"],
    title: json["title"],
    muscle: json["muscle"],
    type: json["type"],
    equipment: json["equipment"],
    isPublic: json["is_public"],
    description: json["description"],
    trainerId: json["trainer_id"],
    state: json["state"],
    difficulty: json["difficulty"],
    photo: json["photo"] == null ? [] : List<PhotoExercise>.from(json["photo"]!.map((x) => PhotoExercise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "muscle": muscle,
    "type": type,
    "equipment": equipment,
    "is_public": isPublic,
    "description": description,
    "trainer_id": trainerId,
    "state": state,
    "difficulty": difficulty,
    "photo": photo == null ? [] : List<dynamic>.from(photo!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'Exercise{id: $id, title: $title, muscle: $muscle, type: $type, equipment: $equipment, isPublic: $isPublic, description: $description, trainerId: $trainerId, state: $state, difficulty: $difficulty, photo: $photo}';
  }
}