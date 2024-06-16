import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class LoadPhotoExerciseRequest extends Equatable {
  int exerciseId;
  int number;
  XFile file;

  LoadPhotoExerciseRequest(
      {required this.exerciseId, required this.number, required this.file});

  @override
  List<Object> get props => [exerciseId, number];

  @override
  String toString() {
    return 'LoadPhotoExerciseRequest{exerciseId: $exerciseId, number: $number, file: $file}';
  }
}
