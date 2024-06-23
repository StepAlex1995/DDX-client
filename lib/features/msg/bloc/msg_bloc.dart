import 'package:ddx_trainer/repository/model/simple_response.dart';
import 'package:ddx_trainer/repository/msg/model/send_msg_request.dart';
import 'package:ddx_trainer/repository/user_repository/model/app_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repository/msg/abstract_msg_repository.dart';
import '../../../repository/msg/model/send_msg_voice_request.dart';
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
        AppResponseModel<SimpleResponse> sendMsgResponse;
        if (event.file != null) {
          var request = SendMsgVoiceRequest(
              taskId: event.sendMsgRequest.taskId,
              trainerId: event.sendMsgRequest.trainerId,
              clientId: event.sendMsgRequest.clientId,
              file: event.file!,
              date: event.sendMsgRequest.date,
              isSendClient: event.sendMsgRequest.isSendClient);
          sendMsgResponse =
              await msgRepository.sendMsgVoice(event.user, request);
        } else {
          sendMsgResponse =
              await msgRepository.sendMsg(event.user, event.sendMsgRequest);
        }
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
