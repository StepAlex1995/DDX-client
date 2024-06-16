class SimpleResponse {
  String status;

  SimpleResponse({
    required this.status,
  });

  factory SimpleResponse.fromJson(Map<String, dynamic> json) => SimpleResponse(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };

  @override
  String toString() {
    return 'SimpleResponse{status: $status}';
  }
}
