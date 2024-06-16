import 'package:ddx_trainer/repository/msg/model/msg_model.dart';

class MsgListResponse {
  List<MsgModel> msgs;

  MsgListResponse({
    required this.msgs,
  });

  factory MsgListResponse.fromJson(Map<String, dynamic> json) =>
      MsgListResponse(
        msgs:
            List<MsgModel>.from(json["msgs"].map((x) => MsgModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msgs": List<dynamic>.from(msgs.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'MsgListResponse{msgs: $msgs}';
  }
}
