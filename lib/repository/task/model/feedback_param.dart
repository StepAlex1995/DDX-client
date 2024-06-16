class FeedbackParam {
  int id;
  int value;

  FeedbackParam({
    required this.id,
    required this.value,
  });

  factory FeedbackParam.fromJson(Map<String, dynamic> json) => FeedbackParam(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };

  @override
  String toString() {
    return 'FeedbackParam{id: $id, value: $value}';
  }
}
