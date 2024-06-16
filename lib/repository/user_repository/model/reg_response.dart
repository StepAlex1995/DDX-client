class RegUserResponse {
  int id;

  RegUserResponse({
    required this.id,
  });

  factory RegUserResponse.fromJson(Map<String, dynamic> json) =>
      RegUserResponse(id: json["id"]);

  Map<String, dynamic> toJson() => {"id": id};
}
