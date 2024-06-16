import 'package:bloc/bloc.dart';

import '../../../repository/msg/abstract_msg_repository.dart';
import '../../../repository/msg/model/msg_model.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'msg_list_event.dart';

part 'msg_list_state.dart';

class MsgListBloc extends Bloc<MsgListEvent, MsgListState> {
  final AbstractMsgRepository msgRepository;

  MsgListBloc(this.msgRepository) : super(MsgListInitState()) {
    on<LoadMsgListEvent>((event, emit) async {
      try {
        //emit(MsgListLoadingState());
        final loadMsgListResponse =
            await msgRepository.loadMsgList(event.user, event.taskId);
        //print('loadMsgListResponse = ' + loadMsgListResponse.code.toString());
        if (loadMsgListResponse.code != 200) {
          if (loadMsgListResponse.code == 401) {
            emit(MsgListFailureState(code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(MsgListFailureState(
                code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          if (loadMsgListResponse.data!.msgs.isEmpty) {
            emit(MsgListFailureState(code: 200, msg: AppTxt.errorListIsEmpty));
          } else {
            emit(MsgListLoadedState(msgList: loadMsgListResponse.data!.msgs));
          }
        }
      } catch (e) {
        emit(MsgListFailureState(code: 500, msg: AppTxt.errorServerResponse));
      }
    });
  }
}
