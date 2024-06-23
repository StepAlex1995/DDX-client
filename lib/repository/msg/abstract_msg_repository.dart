import 'package:ddx_trainer/repository/abstract_app_repository.dart';
import 'package:ddx_trainer/repository/msg/model/msg_list_response.dart';
import 'package:ddx_trainer/repository/msg/model/send_msg_request.dart';

import '../model/simple_response.dart';
import '../user_repository/model/app_response_model.dart';
import '../user_repository/model/user_response.dart';
import 'model/discussion_client_response.dart';
import 'model/send_msg_voice_request.dart';

abstract class AbstractMsgRepository extends AbstractAppRepository {
  AbstractMsgRepository({required super.dio});

  Future<AppResponseModel<SimpleResponse>> sendMsg(
      User user, SendMsgRequest sendMsgRequest);

  Future<AppResponseModel<SimpleResponse>> sendMsgVoice(
      User user, SendMsgVoiceRequest msgVoice);

  Future<AppResponseModel<MsgListResponse>> loadMsgList(User user, int taskId);

  Future<AppResponseModel<DiscussionResponse>> loadDiscussionClient(
      User user);

  Future<AppResponseModel<DiscussionResponse>> loadDiscussionTrainer(
      User user);
}
