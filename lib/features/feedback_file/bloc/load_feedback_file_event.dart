part of 'load_feedback_file_bloc.dart';

abstract class LoadFeedbackFileEvent {}

class LoadFeedbackFileUploadEvent extends LoadFeedbackFileEvent {
  final User user;
  final LoadFeedbackFileRequest requestData;

  LoadFeedbackFileUploadEvent({required this.user, required this.requestData});
}

class LoadFeedbackFileInitEvent extends LoadFeedbackFileEvent {}
