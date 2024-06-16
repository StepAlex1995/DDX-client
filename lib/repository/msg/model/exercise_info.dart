class ExerciseInfo {
  String title;
  String muscle;
  String type;
  String equipment;
  int difficulty;
  bool isPublic;
  String description;
  int trainerId;
  int state;

  ExerciseInfo({
    required this.title,
    required this.muscle,
    required this.type,
    required this.equipment,
    required this.difficulty,
    required this.isPublic,
    required this.description,
    required this.trainerId,
    required this.state,
  });

  factory ExerciseInfo.fromJson(Map<String, dynamic> json) => ExerciseInfo(
        title: json["title"],
        muscle: json["muscle"],
        type: json["type"],
        equipment: json["equipment"],
        difficulty: json["difficulty"],
        isPublic: json["is_public"],
        description: json["description"],
        trainerId: json["trainer_id"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "muscle": muscle,
        "type": type,
        "equipment": equipment,
        "difficulty": difficulty,
        "is_public": isPublic,
        "description": description,
        "trainer_id": trainerId,
        "state": state,
      };

  @override
  String toString() {
    return 'ExerciseInfo{title: $title, muscle: $muscle, type: $type, equipment: $equipment, difficulty: $difficulty, isPublic: $isPublic, description: $description, trainerId: $trainerId, state: $state}';
  }
}
