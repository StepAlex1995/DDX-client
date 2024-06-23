import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/msg/abstract_msg_repository.dart';
import '../../../repository/msg/model/discussion_client_response.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'discussion_event.dart';

part 'discussion_state.dart';

class DiscussionBloc extends Bloc<DiscussionEvent, DiscussionState> {
  final AbstractMsgRepository msgRepository;

  DiscussionBloc(this.msgRepository) : super(DiscussionInitState()) {
    on<LoadDiscussionClientEvent>((event, emit) async {
      try {
        if(state is! DiscussionLoadedState) {
          emit(DiscussionLoadingState());
        }
        final loadDiscussionClientResponse =
            await msgRepository.loadDiscussionClient(event.user);
        if (loadDiscussionClientResponse.code != 200) {
          if (loadDiscussionClientResponse.code == 401) {
            emit(DiscussionFailureState(
                code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(DiscussionFailureState(
                code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          if (loadDiscussionClientResponse.data!.discussion.isEmpty) {
            emit(DiscussionFailureState(
                code: 200, msg: AppTxt.errorListIsEmpty));
          } else {
            emit(DiscussionLoadedState(
                discussionList: loadDiscussionClientResponse.data!.discussion));
          }
        }
      } catch (e) {
        emit(
            DiscussionFailureState(code: 500, msg: AppTxt.errorServerResponse));
      }
    });

    on<LoadDiscussionTrainerEvent>((event, emit) async {
      try {
        if(state is! DiscussionLoadedState) {
          emit(DiscussionLoadingState());
        }
        final loadDiscussionTrainerResponse =
        await msgRepository.loadDiscussionTrainer(event.user);
        if (loadDiscussionTrainerResponse.code != 200) {
          if (loadDiscussionTrainerResponse.code == 401) {
            emit(DiscussionFailureState(
                code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(DiscussionFailureState(
                code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          if (loadDiscussionTrainerResponse.data!.discussion.isEmpty) {
            emit(DiscussionFailureState(
                code: 200, msg: AppTxt.errorListIsEmpty));
          } else {
            emit(DiscussionLoadedState(
                discussionList: loadDiscussionTrainerResponse.data!.discussion.reversed.toList()));
          }
        }
      } catch (e) {
        emit(
            DiscussionFailureState(code: 500, msg: AppTxt.errorServerResponse));
      }
    });
  }
}
