part of 'msg_bloc.dart';

abstract class MsgEvent {}

class SendMsgEvent extends MsgEvent {
  final User user;
  final SendMsgRequest sendMsgRequest;
  final XFile? file;

  SendMsgEvent({required this.user, required this.sendMsgRequest,required this.file, });
}
