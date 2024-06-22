import 'package:ddx_trainer/repository/msg/model/send_msg_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/msg/abstract_msg_repository.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'msg_event.dart';

part 'msg_state.dart';

class MsgBloc extends Bloc<MsgEvent, MsgState> {
  final AbstractMsgRepository msgRepository;

  MsgBloc(this.msgRepository) : super(MsgInitState()) {
    on<SendMsgEvent>((event, emit) async {
      try {
        emit(MsgSendingState());
        final sendMsgResponse =
            await msgRepository.sendMsg(event.user, event.sendMsgRequest);
        if (sendMsgResponse.code != 200) {
          if (sendMsgResponse.code == 401) {
            emit(MsgFailureState(code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(MsgFailureState(code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          emit(MsgSendState());
        }
      } catch (e) {
        emit(MsgFailureState(code: 500, msg: AppTxt.errorServerResponse));
      }
    });
  }
}
