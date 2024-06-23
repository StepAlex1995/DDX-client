part of 'load_feedback_file_bloc.dart';

abstract class LoadFeedbackFileState {}

final class LoadFeedbackFileInit extends LoadFeedbackFileState {}

final class LoadFeedbackFileUploading extends LoadFeedbackFileState {}

final class LoadFeedbackFileUploaded extends LoadFeedbackFileState {
  final String filename;

  LoadFeedbackFileUploaded({required this.filename});
}

final class LoadFeedbackFileFailure extends LoadFeedbackFileState {
  final int code;
  final String msg;

  LoadFeedbackFileFailure({required this.code, required this.msg});
}
