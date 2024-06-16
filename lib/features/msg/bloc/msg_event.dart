part of 'msg_bloc.dart';

abstract class MsgEvent {}

class SendMsgEvent extends MsgEvent {
  final User user;
  final SendMsgRequest sendMsgRequest;

  SendMsgEvent({required this.user, required this.sendMsgRequest});
}
