class AddExerciseRequest {
  String title;
  String muscle;
  String type;
  String equipment;
  int difficulty;
  bool isPublic;
  String description;
  int state;

  AddExerciseRequest({
    required this.title,
    required this.muscle,
    required this.type,
    required this.equipment,
    required this.difficulty,
    required this.isPublic,
    required this.description,
    required this.state,
  });

  factory AddExerciseRequest.fromJson(Map<String, dynamic> json) =>
      AddExerciseRequest(
        title: json["title"],
        muscle: json["muscle"],
        type: json["type"],
        equipment: json["equipment"],
        difficulty: json["difficulty"],
        isPublic: json["is_public"],
        description: json["description"],
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
        "state": state,
      };

  @override
  String toString() {
    return 'AddExerciseRequest{title: $title, muscle: $muscle, type: $type, equipment: $equipment, difficulty: $difficulty, isPublic: $isPublic, description: $description, state: $state}';
  }
}
