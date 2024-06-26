part of 'load_feedback_file_bloc.dart';

abstract class LoadFeedbackFileEvent {}

class LoadFeedbackFileUploadEvent extends LoadFeedbackFileEvent {
  final User user;
  final LoadFeedbackFileRequest requestData;
  final bool isVideoFile;

  LoadFeedbackFileUploadEvent({required this.user, required this.requestData, required this.isVideoFile});
}

class LoadFeedbackFileInitEvent extends LoadFeedbackFileEvent {}
