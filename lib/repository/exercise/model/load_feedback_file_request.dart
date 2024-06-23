import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class LoadFeedbackFileRequest extends Equatable {
  final int taskId;
  final XFile file;

  const LoadFeedbackFileRequest({required this.taskId, required this.file});

  @override
  List<Object> get props => [taskId, file];

  @override
  String toString() {
    return 'LoadFeedbackFileRequest{taskId: $taskId, file: $file}';
  }
}
