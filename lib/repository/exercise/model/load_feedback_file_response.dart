class LoadFeedbackFileResponse {
  final String filename;

  LoadFeedbackFileResponse({required this.filename});

  factory LoadFeedbackFileResponse.fromJson(Map<String, dynamic> json) =>
      LoadFeedbackFileResponse(
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
      };

  @override
  String toString() {
    return 'LoadFeedbackFileResponse{filename: $filename}';
  }
}
