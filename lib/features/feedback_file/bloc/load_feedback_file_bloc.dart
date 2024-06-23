import 'package:ddx_trainer/repository/exercise/model/load_feedback_file_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/exercise/abstract_exercise_repository.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'load_feedback_file_event.dart';

part 'load_feedback_file_state.dart';

class LoadFeedbackFileBloc
    extends Bloc<LoadFeedbackFileEvent, LoadFeedbackFileState> {
  final AbstractExerciseRepository exerciseRepository;

  LoadFeedbackFileBloc(this.exerciseRepository)
      : super(LoadFeedbackFileInit()) {
    on<LoadFeedbackFileUploadEvent>((event, emit) async {
      emit(LoadFeedbackFileUploading());
      try {
        final loadedFeedbackFile = await exerciseRepository
            .uploadFeedbackFileExercise(event.user, event.requestData);
        if (loadedFeedbackFile.code != 200) {
          if (loadedFeedbackFile.code == 401) {
            emit(LoadFeedbackFileFailure(
                code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(LoadFeedbackFileFailure(
                code: 500, msg: AppTxt.errorServerResponse));
          }
        }else {
          if(loadedFeedbackFile.data!= null) {
            emit(LoadFeedbackFileUploaded(
                filename: loadedFeedbackFile.data!.filename));
          }else {
            emit(LoadFeedbackFileFailure(
                code: 500, msg: AppTxt.errorServerResponse));
          }
        }
      } catch (e) {
        emit(LoadFeedbackFileFailure(
            code: 500, msg: AppTxt.errorServerResponse));
      }
    });
  }
}
