class AddExerciseResponse {
  int id;

  AddExerciseResponse({
    required this.id,
  });

  factory AddExerciseResponse.fromJson(Map<String, dynamic> json) => AddExerciseResponse(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
