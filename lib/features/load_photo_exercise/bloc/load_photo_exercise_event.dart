part of 'load_photo_exercise_bloc.dart';

abstract class LoadPhotoExerciseEvent extends Equatable {}

class LoadPhotoExerciseUploadInitEvent extends LoadPhotoExerciseEvent {
  final User user;
  final LoadPhotoExerciseRequest requestData;

  LoadPhotoExerciseUploadInitEvent(
      {required this.user, required this.requestData});

  @override
  List<Object> get props => [user, requestData];
}

class LoadPhotoExerciseInitEvent extends LoadPhotoExerciseEvent {
  @override
  List<Object> get props => [];
}
