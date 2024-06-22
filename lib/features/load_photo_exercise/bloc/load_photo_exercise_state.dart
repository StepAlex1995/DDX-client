part of 'load_photo_exercise_bloc.dart';

abstract class LoadPhotoExerciseState {}

final class LoadPhotoExerciseInit extends LoadPhotoExerciseState {}

final class LoadPhotoExerciseUploading extends LoadPhotoExerciseState {}

final class LoadPhotoExerciseUploaded extends LoadPhotoExerciseState {}

final class LoadPhotoExerciseFailure extends LoadPhotoExerciseState {
  final int code;
  final String msg;

  LoadPhotoExerciseFailure({required this.code, required this.msg});
}
