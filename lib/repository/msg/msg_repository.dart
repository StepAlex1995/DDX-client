import 'package:ddx_trainer/repository/model/simple_response.dart';
import 'package:ddx_trainer/repository/msg/abstract_msg_repository.dart';
import 'package:ddx_trainer/repository/msg/model/discussion_client_response.dart';
import 'package:ddx_trainer/repository/msg/model/msg_list_response.dart';
import 'package:ddx_trainer/repository/msg/model/send_msg_request.dart';
import 'package:ddx_trainer/repository/user_repository/model/app_response_model.dart';
import 'package:ddx_trainer/repository/user_repository/model/user_response.dart';
import 'package:dio/dio.dart';

import '../../config.dart';

class MsgRepository extends AbstractMsgRepository {
  MsgRepository({required super.dio});

  @override
  Future<AppResponseModel<SimpleResponse>> sendMsg(
      User user, SendMsgRequest sendMsgRequest) async {
    final response = await dio.post(
      '${Config.server}/api/msg/',
      data: sendMsgRequest.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );
    return AppResponseModel(code: response.statusCode ?? 500);
  }

  @override
  Future<AppResponseModel<MsgListResponse>> loadMsgList(
      User user, int taskId) async {
    final response = await dio.get(
      '${Config.server}/api/msg/$taskId',
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );

    if (response.statusCode == 200) {
      MsgListResponse? data;
      try {
        data = MsgListResponse.fromJson(response.data);
      } catch (e) {
        data = null;
      }
      return AppResponseModel(
        code: response.statusCode ?? 500,
        data: data ?? MsgListResponse(msgs: []),
      );
    } else {
      return AppResponseModel(code: response.statusCode ?? 500);
    }
  }

  @override
  Future<AppResponseModel<DiscussionResponse>> loadDiscussionClient(
      User user) async {
    final response = await dio.get(
      '${Config.server}/api/msg/discussion/${user.clientId}',
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );
    if (response.statusCode == 200) {
      DiscussionResponse? data;
      try {
        data = DiscussionResponse.fromJson(response.data);
      } catch (e) {
        data = null;
      }
      return AppResponseModel(
        code: response.statusCode ?? 500,
        data: data ?? DiscussionResponse(discussion: []),
      );
    } else {
      return AppResponseModel(code: response.statusCode ?? 500);
    }
  }

  @override
  Future<AppResponseModel<DiscussionResponse>> loadDiscussionTrainer(User user) async {
    final response = await dio.get(
      '${Config.server}/api/msg/discussion/trainer/${user.selfTrainerId}',
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );
    if (response.statusCode == 200) {
      DiscussionResponse? data;
      try {
        data = DiscussionResponse.fromJson(response.data);
      } catch (e) {
        data = null;
      }
      return AppResponseModel(
        code: response.statusCode ?? 500,
        data: data ?? DiscussionResponse(discussion: []),
      );
    } else {
      return AppResponseModel(code: response.statusCode ?? 500);
    }
  }
}
